
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
  use({ "hrsh7th/nvim-compe", requires = { { "hrsh7th/vim-vsnip", 'hrsh7th/vim-vsnip-integ' } } })
  use "rafamadriz/friendly-snippets"
  use 'itchyny/lightline.vim'
  use 'windwp/nvim-autopairs'
  use { 'junegunn/fzf.vim',
        requires = {
            'junegunn/fzf',
            run = './install --bin',
        },
      }
  use 'scalameta/nvim-metals'
	end
)

