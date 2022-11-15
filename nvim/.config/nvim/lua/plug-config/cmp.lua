vim.opt.completeopt = "menu,menuone,noselect"

local cmp = require "cmp"
local luasnip = require "luasnip"
local lspkind = require "lspkind"

require "luasnip.loaders.from_vscode".lazy_load()
require "luasnip.loaders.from_vscode".lazy_load({ paths = "~/.snippets" })

local source_mapping = {
	nvim_lsp = "[LSP]",
	nvim_lua = "[LUA]",
	path = "[PATH]",
	buffer = "[BUFFER]"
}

cmp.setup {
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = {
		["<C-j>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
		["<C-k>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm { select = true },
		["<Tab>"] = cmp.mapping(function(fallback)
			if luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			end
		end, { "i", "s" }),
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "luasnip", option = { history = false } },
		{ name = "path" },
		{ name = "buffer" },
	},
	formatting = {
		format = function(entry, vim_item)
			vim_item.kind = lspkind.presets.default[vim_item.kind]
			vim_item.menu = source_mapping[entry.source.name]
			return vim_item
		end,
	},
}
