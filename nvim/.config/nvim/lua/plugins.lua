
local execute = vim.api.nvim_command
local fn = vim.fn

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'navarasu/onedark.nvim'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', commit = '668de0951a36ef17016074f1120b6aacbe6c4515' }
  use {
    'neovim/nvim-lspconfig',
    'williamboman/nvim-lsp-installer',
  }
  use 'scrooloose/NERDTree'
  use 'unblevable/quick-scope'
  use({ "hrsh7th/nvim-cmp", requires = { { 'hrsh7th/cmp-path', 'hrsh7th/cmp-buffer', "hrsh7th/cmp-nvim-lsp", "hrsh7th/vim-vsnip", 'hrsh7th/cmp-vsnip', "rafamadriz/friendly-snippets" } } })
  use "ray-x/lsp_signature.nvim"
  use 'windwp/nvim-autopairs'
  use { 'junegunn/fzf.vim',
        requires = {
            'junegunn/fzf',
            run = './install --bin',
        },
  }
  use {
    'nvim-telescope/telescope.nvim',
    requires = { 
      {'nvim-lua/plenary.nvim'},
      {'nvim-lua/popup.nvim'}
    }
  }
  use{'scalameta/nvim-metals', requires = { "nvim-lua/plenary.nvim" }}
  use {
    'hoob3rt/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }
  use 'b3nj5m1n/kommentary'
  use 'lervag/vimtex'
  use {
      'iamcco/markdown-preview.nvim',
      run = 'cd app && yarn install',
      ft = {'markdown'}
  }
  use 'lukas-reineke/indent-blankline.nvim'
	end
)
