local nvim_lsp = require("lspconfig")

local M = {}

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
	buf_set_keymap("n", "gp", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
	buf_set_keymap("n", "gn", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
	buf_set_keymap("n", "<leader>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
	buf_set_keymap("n", "<leader>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
	buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
	buf_set_keymap("n", "<leader>s", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", opts)
	buf_set_keymap("n", "<leader>re", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)

	if client.resolved_capabilities.document_formatting then
		vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
	end

	vim.api.nvim_set_current_dir(client.config.root_dir)
end

function M.setup_servers()
	local buf_map = function(bufnr, mode, lhs, rhs, opts)
		vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
			silent = true,
		})
	end

	local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

	local lsp_installer = require("nvim-lsp-installer")

	lsp_installer.on_server_ready(function(server)
		local opts = { on_attach = M.on_attach, capabilities = capabilities }
		if server.name == "denols" then
			opts.root_dir = nvim_lsp.util.root_pattern("deno.json")
		elseif server.name == "tsserver" then
			opts.on_attach = function(client, bufnr)
				client.resolved_capabilities.document_formatting = false
				client.resolved_capabilities.document_range_formatting = false

				local ts_utils = require("nvim-lsp-ts-utils")
				ts_utils.setup({})
				ts_utils.setup_client(client)

				buf_map(bufnr, "n", "gs", ":TSLspOrganize<CR>")
				buf_map(bufnr, "n", "gi", ":TSLspRenameFile<CR>")
				buf_map(bufnr, "n", "go", ":TSLspImportAll<CR>")

				M.on_attach(client, bufnr)
			end
		elseif server.name == "sumneko_lua" then
			opts.on_attach = function(client, bufnr)
				client.resolved_capabilities.document_formatting = false
				client.resolved_capabilities.document_range_formatting = false

				M.on_attach(client, bufnr)
			end
			if vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()):match(".dotfiles") then
				local luadev = require("lua-dev").setup()
				opts = luadev
			end
		elseif server.name == "volar" then
			opts.on_attach = function(client, bufnr)
				client.resolved_capabilities.document_formatting = false
				client.resolved_capabilities.document_range_formatting = false
				M.on_attach(client, bufnr)
			end
		end
		server:setup(opts)
	end)
end

return M
