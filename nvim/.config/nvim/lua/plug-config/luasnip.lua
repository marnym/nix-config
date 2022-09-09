require "luasnip.loaders.from_vscode".lazy_load()

local function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Jump forward or backward
map("i", "<expr> <Tab>", "luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'", { silent = true })
map("s", "<expr> <Tab>", "require('luasnip').jump(1)", { silent = true })
map("i", "<expr> <S-Tab>", "require'luasnip'.jump(-1)", { silent = true })
map("s", "<expr> <S-Tab>", "require'luasnip'.jump(-1)", { silent = true })
