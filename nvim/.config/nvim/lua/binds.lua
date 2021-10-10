local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}  
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Better nav for omnicomplete
-- vim.cmd 'inoremap <expr> <c-j> ("\\<C-n>")'
-- vim.cmd 'inoremap <expr> <c-k> ("\\<C-p>")'
--[[ map('i', '<C-j>', '("\\<C-n>")', { expr = true })
map('i', '<C-k>', '("\\<C-p>")', { expr = true }) ]]

-- Use alt + hjkl to resize windows
map('n', '<M-j>', ':resize -2<CR>', { silent = true })
map('n', '<M-k>', ':resize +2<CR>', { silent = true })
map('n', '<M-h>', ':vertical resize -2<CR>', { silent = true })
map('n', '<M-l>', ':vertical resize +2<CR>', { silent = true })

-- I hate escape more than anything else
map('i', 'jk', '<Esc>', { silent = true })
map('i', 'kj', '<Esc>', { silent = true })

-- Easy CAPS
-- inoremap <c-U> <ESC>viwUi
-- nnoremap <c-U> viwU<Esc>

-- TAB in general mode will move to text buffer
map('n', '<TAB>', ':bnext<CR>', { silent = true })
-- SHIFT-TAB will go back
map('n', '<S-TAB>', ':bprevious<CR>', { silent = true })


-- Better tabbing
map('v', '<', '<gv', { silent = true })
map('v', '>', '>gv', { silent = true })

-- Better window navigation
map('n', '<C-h>', '<C-w>h', { silent = true })
map('n', '<C-j>', '<C-w>j', { silent = true })
map('n', '<C-k>', '<C-w>k', { silent = true })
map('n', '<C-l>', '<C-w>l', { silent = true })

-- map('n', '<Leader>o', 'o<Esc>^Da')
-- map('n', '<Leader>O', 'O<Esc>^Da')


-- map('n', '<C-s>', 'a<C-X><C-S>')
