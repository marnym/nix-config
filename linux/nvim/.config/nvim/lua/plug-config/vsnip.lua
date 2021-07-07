local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}  
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Expand
map('i', '<C-j>', "vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'", { expr = true })
map('s', '<C-j>', "vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'", { expr = true })

-- Expand or jump
map('i', '<C-l>', "vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'", { expr = true })
map('s', '<C-l>', "vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'", { expr = true })

-- Jump forward or backward
map('i', '<Tab>', "vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'", { expr = true })
map('s', '<Tab>', "vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'", { expr = true })
map('i', '<S-Tab>', "vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'", { expr = true })
map('s', '<S-Tab>', "vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'", { expr = true })

-- Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
-- See https://github.com/hrsh7th/vim-vsnip/pull/50
-- nmap        s   <Plug>(vsnip-select-text)
-- xmap        s   <Plug>(vsnip-select-text)
-- nmap        S   <Plug>(vsnip-cut-text)
-- xmap        S   <Plug>(vsnip-cut-text)
