-- set leader key
vim.api.nvim_set_keymap("", " ", "", { noremap = true })
vim.g.mapleader = " "

-- line numbers default
vim.wo.number = true
vim.o.relativenumber = true

-- copy paste between vim and everything else
vim.o.clipboard = "unnamedplus"

-- enable mouse
vim.o.mouse = "a"

-- set an indentation of 4
vim.o.tabstop = 4

-- enable break indent
vim.o.breakindent = true

-- save undo history
vim.o.undofile = true

-- disable highlight on search
vim.o.hlsearch = false

-- case insensitive search
vim.o.ignorecase = true
vim.o.smartcase = true

-- hide status, since status line shows it
vim.o.showmode = false

-- keep signcolumn on
vim.wo.signcolumn = 'yes'

-- decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- set completeopt
vim.o.completeopt = "menuone,noselect"

vim.o.termguicolors = true

-- disable wrap
vim.o.wrap = false

-- so that `` is visible in markdown files
vim.o.conceallevel = 0

-- Enable highlighting of the current line
vim.o.cursorline = true

-- always keep 8 lines between cursor and top/bottom
vim.o.scrolloff = 8

-- open splits to the right and bottom
vim.o.splitright = true
vim.o.splitbelow = true
