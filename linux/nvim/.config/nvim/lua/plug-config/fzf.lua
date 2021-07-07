local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.fzf_action = { ['ctrl-t'] = 'tab split', ['ctrl-x'] = 'split', ['ctrl-v'] = 'vslplit' }

vim.g.fzf_history_dir = '/home/markus/.local/share/fzf-history'

map('', 'C-f', ':Files<CR>', { silent = true })
map('', 'C-p', ':GFiles<CR>', { silent = true })
map('', '<leader>b', ':Buffers<CR>', { silent = true })
map('n', '<leader>g', ':Rg<CR>', { silent = true })
map('n', '<leader>t', ':Tags<CR>', { silent = true })
map('n', '<leader>m', ':Marks<CR>', { silent = true })



