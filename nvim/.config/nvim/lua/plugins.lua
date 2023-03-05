local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local cmp = require "plug-config.cmp"
local lsp = require "lsp"
local mason = require "plug-config.mason"
local null_ls = require "plug-config.null-ls"
local metals = require "plug-config.nvim-metals"
local treesitter = require "plug-config.treesitter"
local lualine = require "plug-config.lualine"
local telescope = require "plug-config.telescope"

require "lazy".setup {
	-- Visual
	{
		"catppuccin/nvim",
		lazy = false,
		name = "catppuccin",
		config = function()
			vim.g.catppuccin_flavour = "macchiato"
			require "catppuccin".setup()
			vim.cmd "colorscheme catppuccin"
		end
	},

	{
		"nvim-treesitter/nvim-treesitter",
		config = treesitter.setup,
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-context",
			"p00f/nvim-ts-rainbow"
		},
	},
	-- Status line
	{
		"hoob3rt/lualine.nvim",
		dependencies = "kyazdani42/nvim-web-devicons",
		opts = lualine.opts,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		opts = {
			show_current_context = true,
			show_current_context_start = true,
		}
	},

	-- Git
	{
		"lewis6991/gitsigns.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = true,
	},
	{
		"someone-stole-my-name/yaml-companion.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require "telescope".load_extension("yaml_schema")
		end
	},
	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lua",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
			"onsails/lspkind.nvim",
		},
		config = cmp.setup,
	},
	-- LSP
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"folke/neodev.nvim",
		},
		event = "InsertEnter",
		config = function()
			mason.setup()
			lsp.setup_servers()
		end,
		keys = lsp.keys,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
		},
		config = null_ls.setup,
	},
	{
		"scalameta/nvim-metals",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = metals.setup,
	},
	{
		"ray-x/lsp_signature.nvim",
		opts = {
			bind = true, -- This is mandatory, otherwise border config won't get registered.
			doc_lines = 0,
			hi_parameter = "IncSearch",
			floating_window = true,
			hint_enable = true,
			handler_opts = {
				border = "single",
			},
		}
	},
	-- Utils
	"folke/which-key.nvim",
	"tpope/vim-vinegar",
	"unblevable/quick-scope",
	{ "windwp/nvim-autopairs", config = true },
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-lua/popup.nvim",
		},
		config = telescope.setup,
		keys = telescope.keys,
	},
	"b3nj5m1n/kommentary",
	"lervag/vimtex",
	{
		"danymat/neogen",
		config = true,
	},
	"tpope/vim-sleuth",
	"gpanders/editorconfig.nvim",
}
