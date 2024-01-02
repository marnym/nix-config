local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>q", function() require("trouble").open() end)
vim.tbl_extend("force", opts, { desc = "Open trouble.nvim" })
vim.keymap.set("n", "gp", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Go to previous diagnostic" }))
vim.keymap.set("n", "gn", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Go to next diagnostic" }))


local helpers = require("plugins/lsp/helpers")

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })

return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"folke/neodev.nvim",
		},
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local setup_handlers = helpers.setup_handlers()
			require("mason-lspconfig").setup_handlers(setup_handlers)
		end
	},
	{
		"williamboman/mason.nvim",
		dependencies = { {
			"williamboman/mason-lspconfig.nvim",
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
	},
	{
		"ray-x/lsp_signature.nvim",
		config = function()
			require("lsp_signature").setup {
				bind = true, -- This is mandatory, otherwise border config won't get registered.
				doc_lines = 0,
				hi_parameter = "IncSearch",
				floating_window = true,
				hint_enable = true,
				handler_opts = {
					border = "single",
				},
			}
		end,
		lazy = true,
		event = "InsertEnter",
	},
	{
		"scalameta/nvim-metals",
		dependencies = { "nvim-lua/plenary.nvim" },
		ft = { "scala", "sbt" },
		config = function()
			local metals_config = require("metals").bare_config()
			metals_config.settings = {
				showImplicitArguments = true,
				excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
			}

			local nvim_metals_group = vim.api.nvim_create_augroup("NvimMetals", { clear = true })
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "scala", "sbt" },
				callback = function()
					require("metals").initialize_or_attach(metals_config)
				end,
				group = nvim_metals_group,
			})
		end,
	},
}
