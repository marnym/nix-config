CACHE_PATH = vim.fn.stdpath 'cache'

local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local opt = vim.opt

-- set leader key 
vim.api.nvim_set_keymap('', ' ', '', {noremap = true})
g.mapleader = ' '

opt.shortmess:remove('F'):append('c')

opt.hidden = true                              -- Required to keep multiple buffers open multiple buffers
opt.errorbells = false                       -- Doesn't make a fuss about errors
opt.wrap = false                              -- Display long lines as just one line
opt.pumheight = 10                        -- Makes popup menu smaller
opt.fileencoding = 'utf-8'                  -- The encoding written to file
opt.bo.fileencoding = 'utf-8'                  -- The encoding written to file
opt.ruler = true              			            -- Show the cursor position all the time
opt.cmdheight = 2                         -- More space for displaying messages
opt.iskeyword:append('-')
opt.mouse = 'a'                             -- Enable your mouse
opt.splitbelow = true                          -- Horizontal splits will automatically be below
opt.splitright = true                          -- Vertical splits will automatically be to the right
opt.autoindent = true
cmd([[ filetype plugin indent on ]])
opt.conceallevel = 0                      -- So that I can see `` in markdown files
opt.tabstop = 2                           -- Insert 2 spaces for a tab
opt.shiftwidth = 2                        -- Change the number of space characters inserted for indentation
opt.smarttab = true                            -- Makes tabbing smarter will realize you have 2 vs 4
opt.expandtab = true                           -- Converts tabs to spaces
-- opt.smartindent = true                         -- Makes indenting smart opt.autoindent = true                          -- Good auto indent
opt.number = true                              -- Line numbers
opt.relativenumber = true                      -- Relative linenumbers
opt.cursorline = true                          -- Enable highlighting of the current line
opt.background = 'dark'                     -- tell vim what the background color looks like
opt.showtabline = 2                       -- Always show tabs
opt.showmode = false                          -- We don't need to see things like -- INSERT -- anymore
opt.backup = false                            -- This is recommended by coc
opt.swapfile = false
opt.writebackup = false                       -- This is recommended by coc
opt.updatetime=300                      -- Faster completion
opt.timeoutlen=500                      -- By default timeoutlen is 1000 ms
cmd([[autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o]])                  -- Stop newline continution of comments
cmd([[autocmd BufRead,BufNewFile *.tex setlocal spell spelllang=en_us]])

opt.clipboard = 'unnamedplus'               -- Copy paste between vim and everything else
opt.autochdir = true                           -- Your working directory will always be the same as your working directory
opt.undodir = CACHE_PATH .. '/undo'
opt.undofile = true
opt.incsearch = true
opt.scrolloff = 8

vim.cmd [[ highlight Comment cterm=italic gui=italic ]]

local onedark = require("onedark")
onedark.load()

