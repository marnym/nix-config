require "neodev".setup()
local nvim_lsp = require "lspconfig"

local M = {}

vim.api.nvim_create_augroup("Format", { clear = false })

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
function M.on_attach(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	--Enable completion triggered by <c-x><c-o>
	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	local opts = { noremap = true, silent = true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "gy", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_set_keymap("n", "gp", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	buf_set_keymap("n", "gn", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	buf_set_keymap("n", "<leader>e", "<cmd>lua vim.diagnostic.show_line_diagnostics()<CR>", opts)
	buf_set_keymap("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
	buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)
	buf_set_keymap("n", "<leader>s", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", opts)
	buf_set_keymap("n", "<leader>re", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)

	vim.api.nvim_create_autocmd("BufWritePre", {
		group = "Format",
		buffer = 0,
		callback = function()
			vim.lsp.buf.format()
		end
	})
end

local function disable_formatting(client, bufnr)
	client.server_capabilities.document_formatting = false
	client.server_capabilities.document_range_formatting = false
	M.on_attach(client, bufnr)
end

function M.setup_servers()
	local capabilities = require("cmp_nvim_lsp").default_capabilities()

	require "mason-lspconfig".setup_handlers {
		function(server_name)
			local settings = { on_attach = M.on_attach, capabilities = capabilities }
			nvim_lsp[server_name].setup(settings)
		end,
		["ansiblels"] = function()
			nvim_lsp.ansiblels.setup {
				on_attach = M.on_attach,
				capabilities = capabilities,
				filetypes = { "yml", "yaml", "yml.ansible", "yaml.ansible" },
				root_dir = nvim_lsp.util.root_pattern("ansible.cfg");
				single_file_support = false,
			}
		end,
		["denols"] = function()
			nvim_lsp.denols.setup {
				on_attach = M.on_attach,
				capabilities = capabilities,
				root_dir = nvim_lsp.util.root_pattern("deno.json", "import_map.json"),
				init_options = {
					enable = true,
					unstable = true,
				}
			}
		end,
		["tsserver"] = function()
			nvim_lsp.tsserver.setup {
				on_attach = disable_formatting,
				capabilities = capabilities,
			}
		end,
		["sumneko_lua"] = function()
			nvim_lsp.sumneko_lua.setup {
				on_attach = M.on_attach,
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							globals = { 'vim' }
						}
					}
				}
			}
		end,
		["volar"] = function()
			nvim_lsp.volar.setup {
				on_attach = disable_formatting,
				capabilities = capabilities,
			}
		end,
		["texlab"] = function()
			nvim_lsp.texlab.setup {
				on_attach = M.on_attach,
				capabilities = capabilities,
				root_dir = nvim_lsp.util.root_pattern("*.tex")
			}
		end
	}
end

return M
