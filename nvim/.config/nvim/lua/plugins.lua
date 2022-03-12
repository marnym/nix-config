local execute = vim.api.nvim_command
local fn = vim.fn

return require("packer").startup(function()
	-- Packer
	use("wbthomason/packer.nvim")

	-- Visual
	use("navarasu/onedark.nvim")
	use("folke/tokyonight.nvim")

	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		commit = "668de0951a36ef17016074f1120b6aacbe6c4515",
		requires = { "p00f/nvim-ts-rainbow" },
	})
	use({
		"hoob3rt/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})
	use({
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("indent_blankline").setup({
				show_current_context = true,
				show_current_context_start = true,
			})
		end,
	})
	use({
		"lewis6991/gitsigns.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("gitsigns").setup()
		end,
	})
	use("fladson/vim-kitty")

	-- Lsp
	use({
		"neovim/nvim-lspconfig",
		"williamboman/nvim-lsp-installer",
	})
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			{
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/vim-vsnip",
				"hrsh7th/cmp-vsnip",
				"rafamadriz/friendly-snippets",
			},
		},
	})
	use("ray-x/lsp_signature.nvim")
	use({
		"jose-elias-alvarez/null-ls.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
		},
	})
	use({ "scalameta/nvim-metals", requires = { "nvim-lua/plenary.nvim" } })
	use("jose-elias-alvarez/nvim-lsp-ts-utils")
	use("folke/lua-dev.nvim")

	-- Utils
	use("scrooloose/NERDTree")
	use("unblevable/quick-scope")
	use("windwp/nvim-autopairs")
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-lua/popup.nvim" },
		},
	})
	use("b3nj5m1n/kommentary")
	use("lervag/vimtex")
	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && yarn install",
		ft = { "markdown" },
	})
	use({
		"danymat/neogen",
		config = function()
			require("neogen").setup()
		end,
	})
	use({
		"Darazaki/indent-o-matic",
		config = function()
			require("indent-o-matic").setup()
		end,
	})
end)
