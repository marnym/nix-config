local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>q", function() require("trouble").open() end,
	vim.tbl_extend("force", opts, { desc = "Open trouble.nvim" }))
vim.keymap.set("n", "gp", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Go to previous diagnostic" }))
vim.keymap.set("n", "gn", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Go to next diagnostic" }))


local helpers = require("plugins/lsp/helpers")

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
			opts = {
				ensure_installed = {
					"bashls",
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
					"texlab",
					"tailwindcss",
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
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
		},
		event = "InsertEnter *.*",
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup {
				debug = false,
				sources = {
					null_ls.builtins.diagnostics.eslint_d.with({
						condition = function(utils)
							return not utils.root_has_file("deno.json")
						end,
					}),
					null_ls.builtins.code_actions.eslint_d.with({
						condition = function(utils)
							return not utils.root_has_file("deno.json")
						end,
					}),
					null_ls.builtins.formatting.prettierd.with({
						condition = function(utils)
							return not utils.root_has_file("deno.json")
						end,
						extra_filetypes = { "astro" }
					}),
					null_ls.builtins.formatting.black,
					null_ls.builtins.code_actions.gitsigns,
					null_ls.builtins.diagnostics.markdownlint.with {
						filter = function(diagnostic)
							return diagnostic.code ~= "MD013/line-length"
						end
					},
					null_ls.builtins.formatting.nixpkgs_fmt
				},
				on_attach = helpers.on_attach,
			}
		end,
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
