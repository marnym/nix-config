
" Plugins will be downloaded under the specified directory.
call plug#begin('~/.config/nvim/plugged')

" Declare the list of plugins.
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'scrooloose/NERDTree'
Plug 'jiangmiao/auto-pairs'
Plug 'plasticboy/vim-markdown'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'unblevable/quick-scope'
" Plug 'neovim/nvim-lspconfig'
" Plug 'hrsh7th/nvim-compe'
" List ends here. Plugins become visible to Vim after this call.
call plug#end()

colorscheme dracula
