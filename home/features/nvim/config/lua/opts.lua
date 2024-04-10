-- set leader key
vim.api.nvim_set_keymap("", " ", "", { noremap = true })
vim.g.mapleader = " "

local opt = vim.opt

-- add all subdirectories to path
opt.path = vim.o.path .. "**"

-- line numbers default
vim.wo.number = true
opt.relativenumber = true

-- copy paste between vim and everything else
opt.clipboard = "unnamedplus"

-- enable mouse
opt.mouse = "a"

-- set indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true

-- enable break indent
opt.breakindent = true

-- save undo history
opt.undofile = true

-- disable highlight on search
opt.hlsearch = false

-- case insensitive search
opt.ignorecase = true
opt.smartcase = true

-- hide status, since status line shows it
opt.showmode = false

-- keep signcolumn on
vim.wo.signcolumn = 'yes'

-- decrease update time
opt.updatetime = 1000

-- decrease timeoutlen
opt.timeoutlen = 500

-- set completeopt
opt.completeopt = "menuone,noselect"

opt.termguicolors = true

-- so that `` is visible in markdown files
opt.conceallevel = 0

-- Enable highlighting of the current line
opt.cursorline = true

-- always keep 10 lines between cursor and top/bottom
opt.scrolloff = 10

-- opt.smoothscroll = true

-- open splits to the right and bottom
opt.splitright = true
opt.splitbelow = true

-- listchars
vim.opt.list = true
vim.opt.listchars = {
    eol = "↲",
    tab = "» ",
    trail = "·",
}

-- filetypes
vim.filetype.add {
    pattern = {
        ['.*/playbooks/.*%.ya?ml'] = 'yaml.ansible',
        ['.*/roles/.*/tasks/.*%.ya?ml'] = 'yaml.ansible',
        ['.*/roles/.*/handlers/.*%.ya?ml'] = 'yaml.ansible',
    }
}
