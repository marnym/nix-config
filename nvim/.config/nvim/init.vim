lua require'init'
source $HOME/.config/nvim/plug-config/fzf.vim
source $HOME/.config/nvim/plug-config/vsnip.vim 
source $HOME/.config/nvim/plug-config/telescope.vim 
autocmd BufRead,BufNewFile *.tex setlocal spell spelllang=en_us
nnoremap <C-s> a<C-X><C-S>

