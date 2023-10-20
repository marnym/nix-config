local M = {}

local format_group = vim.api.nvim_create_augroup('Format', { clear = false })

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
function M.on_attach(client, bufnr)
	local nmap = function(keys, func, desc)
		if desc then
			desc = 'LSP: ' .. desc
		end

		vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
	end


	nmap('<leader>re', vim.lsp.buf.rename, '[R]e[N]ame')
	nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

	nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
	nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
	nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
	nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
	nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
	nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

	nmap('K', vim.lsp.buf.hover, 'Hover Documentation')

	vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
		if client.server_capabilities.documentFormattingProvider then
			vim.lsp.buf.format()
		end
	end, { desc = 'Format current buffer with LSP' })
	nmap('<leader>fo', ':Format<CR>', '[FO]rmat current buffer')

	if client.server_capabilities.documentFormattingProvider then
		vim.api.nvim_create_autocmd('BufWritePre', {
			callback = function()
				vim.lsp.buf.format()
			end,
			group = format_group,
			buffer = 0,
		})

		vim.api.nvim_buf_create_user_command(bufnr, 'FormatOnSaveDisable', function(_)
			local autocmds = vim.api.nvim_get_autocmds({ group = 'Format' })
			for _, autocmd in ipairs(autocmds) do
				vim.api.nvim_del_autocmd(autocmd.id)
			end
		end, { desc = 'Disable formatting on save' })
	end

	-- if client.server_capabilities.inlayHintProvider then
	-- 	vim.lsp.buf.inlay_hint(bufnr, true)
	-- end
end

function M.disable_formatting(client, bufnr)
	client.server_capabilities.documentFormattingProvider = false
	client.server_capabilities.documentRangeFormattingProvider = false
	M.on_attach(client, bufnr)
end

function M.root_pattern_excludes(root, exclude)
	local util = require('lspconfig/util')
	local function matches(path, pattern) return 0 < #vim.fn.glob(util.path.join(path, pattern)) end

	return function(startpath)
		return util.search_ancestors(startpath,
			function(path) return matches(path, root) and not matches(path, exclude) end)
	end
end

function M.setup_handlers()
	local nvim_lsp = require('lspconfig')
	local capabilities = require('cmp_nvim_lsp').default_capabilities()

	capabilities.offsetEncoding = { 'utf-16' }

	local settings = { on_attach = M.on_attach, capabilities = capabilities }
	nvim_lsp.nil_ls.setup(settings)

	nvim_lsp.lua_ls.setup {
		on_attach = M.on_attach,
		capabilities = capabilities,
		settings = {
			Lua = {
				runtime = {
					version = 'LuaJIT',
				},
				diagnostics = {
					globals = { 'vim', 'require' },
				},
				workspace = {
					checkThirdParty = false,
					library = {
						vim.env.VIMRUNTIME
					}
				},
				telemetry = { enable = false },
			},
		},
	}

	nvim_lsp.clangd.setup(settings)

	return {
		function(server_name)
			nvim_lsp[server_name].setup(settings)
		end,
		['ansiblels'] = function()
			nvim_lsp.ansiblels.setup {
				on_attach = M.on_attach,
				capabilities = capabilities,
				filetypes = { 'yml', 'yaml', 'yml.ansible', 'yaml.ansible' },
				root_dir = nvim_lsp.util.root_pattern('ansible.cfg'),
				single_file_support = false,
			}
		end,
		['denols'] = function()
			-- To appropriately highlight codefences returned from denols, you will need to augment vim.g.markdown_fenced languages
			vim.g.markdown_fenced_languages = {
				'ts=typescript'
			}
			nvim_lsp.denols.setup {
				cmd = { '/home/markus/.nix-profile/bin/deno', 'lsp' },
				on_attach = M.on_attach,
				capabilities = capabilities,
				root_dir = M.root_pattern_excludes('deno.json', 'package.json'),
				init_options = {
					enable = true,
					unstable = true,
				}
			}
		end,
		['tsserver'] = function()
			nvim_lsp.tsserver.setup {
				on_attach = M.disable_formatting,
				capabilities = capabilities,
				root_dir = M.root_pattern_excludes('package.json', 'deno.json'),
				single_file_support = false,
				settings = {
					typescript = {
						inlayHints = {
							includeInlayParameterNameHints = 'literal',
							includeInlayParameterNameHintsWhenArgumentMatchesName = false,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = false,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
					},
					javascript = {
						inlayHints = {
							includeInlayParameterNameHints = 'all',
							includeInlayParameterNameHintsWhenArgumentMatchesName = false,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
					}
				}
			}
		end,
		['gopls'] = function()
			nvim_lsp.gopls.setup {
				on_attach = M.on_attach,
				capabilities = capabilities,
				settings = {
					gopls = {
						analyses = {
							unusedparams = true,
							shadow = true
						},
						staticcheck = true,
					}
				}
			}
		end,
		['volar'] = function()
			nvim_lsp.volar.setup {
				on_attach = M.disable_formatting,
				capabilities = capabilities,
			}
		end,
		['texlab'] = function()
			nvim_lsp.texlab.setup {
				on_attach = M.on_attach,
				capabilities = capabilities,
				root_dir = nvim_lsp.util.root_pattern('*.tex')
			}
		end,
		['jsonls'] = function()
			local json_capabilities = require('cmp_nvim_lsp').default_capabilities()
			json_capabilities.textDocument.completion.completionItem.snippetSupport = true
			nvim_lsp.jsonls.setup {
				on_attach = M.on_attach,
				capabilities = json_capabilities,
				settings = {
					json = {
						schemas = {
							{
								fileMatch = { 'package.json' },
								url = 'https://json.schemastore.org/package.json',
							},
							{
								fileMatch = { 'tsconfig.json' },
								url = 'https://json.schemastore.org/tsconfig.json',
							},
						},
					},
				}
			}
		end,
		['yamlls'] = function()
			local cfg = require('yaml-companion').setup()
			nvim_lsp.yamlls.setup(cfg)
		end,
	}
end

function M.eslint_condition(utils)
	return utils.root_has_file { '.eslintrc', '.eslintrc.json', '.eslintrc.js' }
end

return M
