CACHE_PATH = vim.fn.stdpath("cache")

-- set leader key
vim.api.nvim_set_keymap("", " ", "", { noremap = true })
vim.g.mapleader = " "

vim.opt.shortmess:remove("F"):append("c")

vim.opt.hidden = true -- Required to keep multiple buffers open multiple buffers
vim.opt.errorbells = false -- Doesn't make a fuss about errors
vim.opt.wrap = false -- Display long lines as just one line
vim.opt.pumheight = 10 -- Makes popup menu smaller
vim.opt.fileencoding = "utf-8" -- The encoding written to file
vim.opt.bo.fileencoding = "utf-8" -- The encoding written to file
vim.opt.ruler = true -- Show the cursor position all the time
vim.opt.cmdheight = 2 -- More space for displaying messages
vim.opt.iskeyword:append("-")
vim.opt.mouse = "a" -- Enable your mouse
vim.opt.splitbelow = true -- Horizontal splits will automatically be below
vim.opt.splitright = true -- Vertical splits will automatically be to the right
vim.opt.conceallevel = 0 -- So that I can see `` in markdown files
vim.opt.number = true -- Line numbers
vim.opt.relativenumber = true -- Relative linenumbers
vim.opt.cursorline = true -- Enable highlighting of the current line
vim.opt.background = "dark" -- tell vim what the background color looks like
vim.opt.showtabline = 0 -- Always show tabs
vim.opt.showmode = false -- We don't need to see things like -- INSERT -- anymore
vim.opt.backup = false -- This is recommended by coc
vim.opt.swapfile = false
vim.opt.writebackup = false -- This is recommended by coc
vim.opt.updatetime = 300 -- Faster completion
vim.opt.timeoutlen = 500 -- By default timeoutlen is 1000 ms
vim.cmd("autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o") -- Stop newline continution of comments
vim.cmd("autocmd BufRead,BufNewFile *.tex setlocal spell spelllang=en_us")

vim.opt.clipboard = "unnamedplus" -- Copy paste between vim and everything else
vim.opt.autochdir = true -- Your working directory will always be the same as your working directory
vim.opt.undodir = CACHE_PATH .. "/undo"
vim.opt.undofile = true
vim.opt.incsearch = true
vim.opt.scrolloff = 8
vim.opt.shiftwidth = 0
vim.opt.softtabstop = 0
vim.opt.tabstop = 4

vim.cmd("colorscheme tokyonight")
