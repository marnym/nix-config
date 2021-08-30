
local execute = vim.api.nvim_command
local fn = vim.fn

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'neovim/nvim-lspconfig'
  use 'kabouzeid/nvim-lspinstall'
  use 'scrooloose/NERDTree'
  use 'unblevable/quick-scope'
  use 'nvim-telescope/telescope.nvim'
  use 'gruvbox-community/gruvbox'
  use({ "hrsh7th/nvim-compe", requires = { { "hrsh7th/vim-vsnip", 'hrsh7th/vim-vsnip-integ', "rafamadriz/friendly-snippets" } } })
  use 'windwp/nvim-autopairs'
  use { 'junegunn/fzf.vim',
        requires = {
            'junegunn/fzf',
            run = './install --bin',
        },
      }
  use 'scalameta/nvim-metals'
  use 'p00f/nvim-ts-rainbow'
  use {
    'hoob3rt/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }
  use 'b3nj5m1n/kommentary'
  -- use 'glepnir/lspsaga.nvim'
	end
)

