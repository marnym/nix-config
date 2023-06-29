local M = {}

local format_group = vim.api.nvim_create_augroup("Format", { clear = false })

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
function M.on_attach(client, bufnr)
	--Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	local bufopts = { noremap = true, silent = true, buffer = bufnr }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "<leader>s", vim.lsp.buf.document_symbol, bufopts)
	vim.keymap.set("n", "<leader>re", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format { async = true } end, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)

	vim.api.nvim_create_autocmd("BufWritePre", {
		callback = function()
			if client.server_capabilities.documentFormattingProvider then
				vim.lsp.buf.format()
			end
		end,
		group = format_group,
		buffer = 0,
	})

	if client.server_capabilities.inlayHintProvider then
		vim.lsp.buf.inlay_hint(bufnr, true)
	end
end

function M.disable_formatting(client, bufnr)
	client.server_capabilities.documentFormattingProvider = false
	client.server_capabilities.documentRangeFormattingProvider = false
	M.on_attach(client, bufnr)
end

function M.root_pattern_excludes(root, exclude)
	local util = require("lspconfig/util")
	local function matches(path, pattern) return 0 < #vim.fn.glob(util.path.join(path, pattern)) end

	return function(startpath)
		return util.search_ancestors(startpath,
			function(path) return matches(path, root) and not matches(path, exclude) end)
	end
end

function M.setup_handlers()
	local nvim_lsp = require("lspconfig")
	local capabilities = require("cmp_nvim_lsp").default_capabilities()
	return {
		function(server_name)
			local settings = { on_attach = M.on_attach, capabilities = capabilities }
			nvim_lsp[server_name].setup(settings)
		end,
		["ansiblels"] = function()
			nvim_lsp.ansiblels.setup {
				on_attach = M.on_attach,
				capabilities = capabilities,
				filetypes = { "yml", "yaml", "yml.ansible", "yaml.ansible" },
				root_dir = nvim_lsp.util.root_pattern("ansible.cfg"),
				single_file_support = false,
			}
		end,
		["denols"] = function()
			nvim_lsp.denols.setup {
				on_attach = M.on_attach,
				capabilities = capabilities,
				root_dir = M.root_pattern_excludes("deno.json", "package.json"),
				init_options = {
					enable = true,
					unstable = true,
				}
			}
		end,
		["tsserver"] = function()
			nvim_lsp.tsserver.setup {
				on_attach = M.disable_formatting,
				capabilities = capabilities,
				root_dir = M.root_pattern_excludes("package.json", "deno.json"),
				single_file_support = false,
				settings = {
					typescript = {
						inlayHints = {
							includeInlayParameterNameHints = "literal",
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
							includeInlayParameterNameHints = "all",
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
		["gopls"] = function()
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
		["lua_ls"] = function()
			nvim_lsp.lua_ls.setup {
				on_attach = M.on_attach,
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							globals = { 'vim' }
						}
					},
					workspace = {
						checkThirdParty = false,
					}
				}
			}
		end,
		["volar"] = function()
			nvim_lsp.volar.setup {
				on_attach = M.disable_formatting,
				capabilities = capabilities,
			}
		end,
		["texlab"] = function()
			nvim_lsp.texlab.setup {
				on_attach = M.on_attach,
				capabilities = capabilities,
				root_dir = nvim_lsp.util.root_pattern("*.tex")
			}
		end,
		["jsonls"] = function()
			local json_capabilities = require("cmp_nvim_lsp").default_capabilities()
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
		["yamlls"] = function()
			local cfg = require("yaml-companion").setup()
			nvim_lsp.yamlls.setup(cfg)
		end,
	}
end

function M.eslint_condition(utils)
	return utils.root_has_file { ".eslintrc", ".eslintrc.json", ".eslintrc.js" }
end

return M
