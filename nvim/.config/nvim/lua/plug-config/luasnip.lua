require "luasnip.loaders.from_vscode".lazy_load()

local opts = { noremap = true, silent = true }

-- Jump forward or backward
vim.keymap.set("i", "<expr> <Tab>", "luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'", opts)
vim.keymap.set("s", "<expr> <Tab>", function() require "luasnip".jump(1) end, opts)
vim.keymap.set("i", "<expr> <S-Tab>", function() require "luasnip".jump(-1) end, opts)
vim.keymap.set("s", "<expr> <S-Tab>", function() require "luasnip".jump(-1) end, opts)
