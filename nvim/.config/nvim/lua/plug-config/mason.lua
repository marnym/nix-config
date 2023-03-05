local M = {}

function M.setup()
	require "mason".setup {
		ui = {
			icons = {
				server_installed = "✓",
				server_pending = "➜",
				server_uninstalled = "✗",
			},
		},
	}

	require "mason-lspconfig".setup {
		ensure_installed = {
			"ansiblels",
			"bashls",
			"clangd",
			"cmake",
			"cssls",
			"denols",
			"dockerls",
			"gopls",
			"html",
			"jsonls",
			"tsserver",
			"ltex",
			"lua_ls",
			"marksman",
			"pyright",
			"rust_analyzer",
			"sqls",
			"svelte",
			"taplo",
			"texlab",
			"tailwindcss",
			"terraformls",
			"volar",
		}
	}
end

return M
