return require "packer".startup(function(use)
	-- Plugin installer
	use "wbthomason/packer.nvim"

	-- Visual
	use { "catppuccin/nvim", as = "catppuccin" }

	-- Syntax Highlighting
	use {
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		commit = "668de0951a36ef17016074f1120b6aacbe6c4515",
		requires = { "p00f/nvim-ts-rainbow" },
	}
	-- Shows current context in top
	use "nvim-treesitter/nvim-treesitter-context"
	-- Status line
	use {
		"hoob3rt/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	}
	-- Buffer line
	use {
		'akinsho/bufferline.nvim',
		tag = "v2.*",
		requires = 'kyazdani42/nvim-web-devicons',
		config = function()
			require "bufferline".setup()
		end
	}
	-- Shows indentation
	use {
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require "indent_blankline".setup {
				show_current_context = true,
				show_current_context_start = true,
			}
		end,
	}
	-- Shows git things
	use {
		"lewis6991/gitsigns.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require "gitsigns".setup()
		end
	}
	-- Lsp
	use {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	}
	-- Autocomplete
	use {
		"hrsh7th/nvim-cmp",
		requires = {
			{
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-nvim-lua",
				"L3MON4D3/LuaSnip",
				"saadparwaiz1/cmp_luasnip",
				"rafamadriz/friendly-snippets",
			},
		},
	}
	-- Shows function signatures
	use "ray-x/lsp_signature.nvim"
	-- Lsp for eslint etc.
	use {
		"jose-elias-alvarez/null-ls.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
		},
	}
	-- Lsp for Scala
	use { "scalameta/nvim-metals", requires = { "nvim-lua/plenary.nvim" } }
	-- Plugin for easier nvim dev
	use "folke/lua-dev.nvim"

	-- Utils
	-- Enhances netrw
	use "tpope/vim-vinegar"
	-- Highlights when moving with f and t
	use "unblevable/quick-scope"
	-- Sets brackets... automatically
	use "windwp/nvim-autopairs"
	-- For searching things
	use {
		"nvim-telescope/telescope.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-lua/popup.nvim" },
		},
	}
	-- Line and block commenting
	use "b3nj5m1n/kommentary"
	-- LaTeX editing
	use "lervag/vimtex"
	-- Preview Markdown in browser
	use {
		"iamcco/markdown-preview.nvim",
		run = "cd app && yarn install",
		setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
		ft = { "markdown" },
	}
	use "ellisonleao/glow.nvim"
	-- Better annotations
	use {
		"danymat/neogen",
		config = function()
			require "neogen".setup({})
		end
	}

	-- Makes indentation consistent
	use "tpope/vim-sleuth"
	-- Sets working dir to project root
	use "ahmedkhalf/project.nvim"
end
)
