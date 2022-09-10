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
		--lsp
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
		"julials",
		"ltex",
		"sumneko_lua",
		"marksman",
		"pyright",
		"rust_analyzer",
		"sqls",
		"svelte",
		"taplo",
		"tailwindcss",
		"terraformls",
		"volar",
	}
}
