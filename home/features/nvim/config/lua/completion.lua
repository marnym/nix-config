local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")
local compare = require("cmp.config.compare")
local luasnip = require("luasnip")
local lspkind = require("lspkind")

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load { paths = "./snippets" }

local source_mapping = {
    buffer = "[Buffer]",
    nvim_lsp = "[LSP]",
    luasnip = "[LuaSnip]",
    nvim_lua = "[nvim]",
    path = "[Path]",
    npm = "[NPM]",
    latex = "[LaTeX]",
}

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = {
        ["<C-j>"] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_next_item { behavior = cmp.SelectBehavior.Insert }
            elseif luasnip.jumpable(1) then
                luasnip.jump(1)
            end
        end),
        ["<C-k>"] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_prev_item { behavior = cmp.SelectBehavior.Insert }
            elseif luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
            end
        end),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm { select = true },
    },
    sources = {
        { name = "npm",      priority = 9, keyword_length = 4 },
        { name = "nvim_lsp", priority = 8 },
        { name = "lazydev",  priority = 8, group_index = 0 },
        { name = "luasnip",  priority = 7, max_item_count = 4, option = { history = false } },
        { name = "path",     priority = 6 },
        { name = "buffer",   priority = 5 },
    },
    sorting = {
        priority_weight = 1.0,
        comparators = {
            compare.offset,
            compare.exact,
            compare.score,

            -- copied from cmp-under, but I don't think I need the plugin for this.
            -- I might add some more of my own.
            function(entry1, entry2)
                local _, entry1_under = entry1.completion_item.label:find "^_+"
                local _, entry2_under = entry2.completion_item.label:find "^_+"
                entry1_under = entry1_under or 0
                entry2_under = entry2_under or 0
                if entry1_under > entry2_under then
                    return false
                elseif entry1_under < entry2_under then
                    return true
                end
            end,

            compare.kind,
            compare.sort_text,
            compare.length,
            compare.order,
        },
    },
    formatting = {
        format = lspkind.cmp_format({
            mode = "symbol_text",
            menu = source_mapping,
        })
    },
    preselect = cmp.PreselectMode.None,
    window = {
        completion = cmp.config.window.bordered {
            winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None',
        },
        documentation = cmp.config.window.bordered {
            winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None',
        },
    },
    performance = {
        max_view_entries = 50,
    },
}

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
