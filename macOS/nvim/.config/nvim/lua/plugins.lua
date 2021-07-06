local execute = vim.api.nvim_command
local fn = vim.fn

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'neovim/nvim-lspconfig'
  use 'kabouzeid/nvim-lspinstall'
  use 'scrooloose/NERDTree'
  use 'jiangmiao/auto-pairs'
  use 'unblevable/quick-scope'
  use 'nvim-telescope/telescope.nvim'
  use 'gruvbox-community/gruvbox'
  use 'hrsh7th/nvim-compe'
	end
)

