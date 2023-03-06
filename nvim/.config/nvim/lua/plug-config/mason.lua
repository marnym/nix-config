local M = {
	"williamboman/mason.nvim",
	dependencies = { {
		"williamboman/mason-lspconfig.nvim",
		opts = {
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
		},
		lazy = true
	} },
	opts = {
		ui = {
			icons = {
				server_installed = "✓",
				server_pending = "➜",
				server_uninstalled = "✗",
			},
		},
	},
	lazy = true,
}

return M
