local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}  
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end


-- Use alt + hjkl to resize windows
map('n', '<M-j>', ':resize -2<CR>', { silent = true })
map('n', '<M-k>', ':resize +2<CR>', { silent = true })
map('n', '<M-h>', ':vertical resize -2<CR>', { silent = true })
map('n', '<M-l>', ':vertical resize +2<CR>', { silent = true })

map('i', 'jk', '<Esc>', { silent = true })
map('i', 'kj', '<Esc>', { silent = true })

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

map('n', '<C-s>', 'a<C-X><C-S>', { silent = true })

-- Plugins
map('', '<Leader>n', ':NERDTreeToggle<CR>')

map('n', '<leader>tb', '<cmd>Gitsigns toggle_current_line_blame<CR>')
map('n', '<leader>th', '<cmd>Gitsigns preview_hunk<CR>')
map('n', '<leader>tn', '<cmd>Gitsigns next_hunk<CR>')
map('n', '<leader>tp', '<cmd>Gitsigns prev_hunk<CR>')

