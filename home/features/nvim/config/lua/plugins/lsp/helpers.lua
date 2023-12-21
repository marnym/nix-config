local M = {}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
function M.on_attach(_, bufnr)
	local nmap = function(keys, func, desc)
		if desc then
			desc = 'LSP: ' .. desc
		end

		vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
	end

	local no_preview = require('plugins.telescope').no_preview

	nmap('<leader>re', vim.lsp.buf.rename, '[R]e[N]ame')
	nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

	nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
	nmap('gr', function() require('telescope.builtin').lsp_references(no_preview()) end, '[G]oto [R]eferences')
	nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
	nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
	nmap('<leader>ds', function() require('telescope.builtin').lsp_document_symbols(no_preview()) end,
		'[D]ocument [S]ymbols')
	nmap('<leader>ws', function() require('telescope.builtin').lsp_dynamic_workspace_symbols(no_preview()) end,
		'[W]orkspace [S]ymbols')

	nmap('K', vim.lsp.buf.hover, 'Hover Documentation')

	-- if client.server_capabilities.inlayHintProvider then
	-- 	vim.lsp.buf.inlay_hint(bufnr, true)
	-- end
end

function M.disable_formatting(client, bufnr)
	client.server_capabilities.documentFormattingProvider = false
	client.server_capabilities.documentRangeFormattingProvider = false
	M.on_attach(client, bufnr)
end

function M.setup_handlers()
	local nvim_lsp = require('lspconfig')
	local capabilities = require('cmp_nvim_lsp').default_capabilities()

	capabilities.offsetEncoding = { 'utf-16' }

	local settings = { on_attach = M.on_attach, capabilities = capabilities }

	nvim_lsp.marksman.setup(settings)

	nvim_lsp.nil_ls.setup {
		on_attach = M.on_attach,
		capabilities = capabilities,
		settings = {
			['nil'] = {
				nix = {
					flake = {
						autoArchive = true,
					}
				}
			}
		}
	}

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


	vim.g.markdown_fenced_languages = {
		'ts=typescript'
	}

	nvim_lsp.denols.setup {
		on_attach = M.on_attach,
		capabilities = capabilities,
		root_dir = nvim_lsp.util.root_pattern('deno.json', 'deno.jsonc'),
		settings = {
			deno = {
				enable = true,
				unstable = true,
				suggest = {
					imports = {
						hosts = {
							["https://deno.land"] = true,
						}
					}
				}
			}
		}
	}

	nvim_lsp.gopls.setup {
		on_attach = M.on_attach,
		capabilities = capabilities,
		settings = {
			gopls = {
				experimentalPostfixCompletions = true,
				analyses = {
					unusedparams = true,
					shadow = true
				},
				staticcheck = true,
			}
		},
		init_options = {
			usePlaceholders = true,
		}
	}

	nvim_lsp.rust_analyzer.setup {
		on_attach = M.on_attach,
		capabilities = capabilities,
		settings = {
			['rust-analyzer'] = {
				cargo = {
					buildScripts = {
						enable = true,
					},
					features = "all",
				},
				procMacro = {
					enable = true,
				},
				lru = {
					capacity = 256,
				}
			}
		}
	}

	require("typescript-tools").setup {
		on_attach = M.on_attach,
		capabilities = capabilities,
	}

	nvim_lsp.texlab.setup {
		on_attach = M.on_attach,
		capabilities = capabilities,
		root_dir = nvim_lsp.util.root_pattern('*.tex')
	}


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
		['volar'] = function()
			nvim_lsp.volar.setup {
				on_attach = M.disable_formatting,
				capabilities = capabilities,
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
