local function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Jump forward or backward
map("i", "<expr> <Tab>", "vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'", { silent = true })
map("s", "<expr> <Tab>", "vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'", { silent = true })
map("i", "<expr> <S-Tab>", "vsnip#jumpable(-1)   ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'", { silent = true })
map("s", "<expr> <S-Tab>", "vsnip#jumpable(-1)   ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'", { silent = true })

-- Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
map("n", "s", "<Plug>(vsnip-select-text)", { silent = true })
map("x", "s", "<Plug>(vsnip-select-text)", { silent = true })
map("n", "S", "<Plug>(vsnip-cut-text)", { silent = true })
map("x", "S", "<Plug>(vsnip-cut-text)", { silent = true })

-- If you want to use snippet for multiple filetypes, you can `g:vsnip_filetypes` for it.
vim.api.nvim_set_var("vsnip_filetypes", { javascriptreact = { "javascript" }, typescriptreact = { "typescript" } })
