vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
vim.cmd("highlight QuickScopePrimary guifg='#00C7DF' gui=underline ctermfg=155 cterm=underline")
vim.cmd("highlight QuickScopeSecondary guifg='#afff5f' gui=underline ctermfg=81 cterm=underline")
vim.g.qs_max_chars = 150

return {
    -- Visual
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("kanagawa").setup({
                colors = {
                    theme = {
                        all = {
                            ui = {
                                bg_gutter = "none"
                            }
                        }
                    }
                },
                overrides = function(colors)
                    local theme = colors.theme
                    return {
                        NormalFloat = { bg = "none" },
                        FloatBorder = { bg = "none" },
                        FloatTitle = { bg = "none" },

                        -- Save an hlgroup with dark background and dimmed foreground
                        -- so that you can use it where your still want darker windows.
                        -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
                        NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

                        -- Popular plugins that open floats will link to NormalFloat by default;
                        -- set their background accordingly if you wish to keep them dark and borderless
                        LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                        MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

                        TelescopeTitle = { fg = theme.ui.special, bold = true },
                        TelescopePromptNormal = { bg = theme.ui.bg_p1 },
                        TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
                        TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
                        TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
                        TelescopePreviewNormal = { bg = theme.ui.bg_dim },
                        TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },

                        Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
                        PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
                        PmenuSbar = { bg = theme.ui.bg_m1 },
                        PmenuThumb = { bg = theme.ui.bg_p2 },
                    }
                end
            })

            vim.cmd("colorscheme kanagawa")
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            debounce = 100,
            indent = { char = "┊" },
            scope = {
                enable = true,
                highlight = "Identifier",
                char = "│",
            }

        }
    },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = true,
    },
    {
        "someone-stole-my-name/yaml-companion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("telescope").load_extension("yaml_schema")
        end,
        lazy = true,
    },
    -- Autocompletion
    {
        "David-Kunz/cmp-npm",
        dependencies = { 'nvim-lua/plenary.nvim' },
        ft = "json",
        config = function()
            require("cmp-npm").setup({})
        end
    },
    -- Utils
    "folke/which-key.nvim",
    {
        "unblevable/quick-scope",
        keys = { "f", "F", "t", "T" },
    },
    "tpope/vim-sleuth",
    -- {
    --     "lervag/vimtex",
    --     config = function()
    --         vim.cmd "let g:tex_flavor = 'latex'"
    --     end
    -- },
    {
        "danymat/neogen",
        config = true,
    },
    {
        "ahmedkhalf/project.nvim",
        config = function()
            require("project_nvim").setup {
                manual_mode = true,
                silent_chdir = false,
                ignore_lsp = { "null-ls" }
            }
        end,
    },
    {
        "zbirenbaum/copilot.lua",
        lazy = true,
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                suggestion = {
                    auto_trigger = true,
                    keymap = {
                        accept = false,
                        next = "<M-j>",
                        prev = "<M-k>",
                    },
                },
                filetypes = {
                    lua = true,
                    ["*"] = function()
                        return vim.fn.filereadable(vim.fn.getcwd() .. "/.copilot") == 1
                    end,
                },
            })

            -- Bind <leader>cp to toggle copilot
            vim.api.nvim_set_keymap("n", "<leader>cp", ":Copilot! toggle<CR>", { noremap = true, silent = true })
        end,
    },
    { "windwp/nvim-autopairs", lazy = true, config = true, },
    -- mini.nvim
    {
        "echasnovski/mini.comment",
        version = false,
        config = function()
            require("mini.comment").setup()
        end
    },
    {
        "echasnovski/mini.surround",
        version = false,
        config = function()
            require("mini.surround").setup()
        end
    },
    {
        'echasnovski/mini.files',
        version = false,
        config = function()
            require("mini.files").setup()
        end,
        keys = {
            { "<Leader>n", function() vim.cmd [[ lua MiniFiles.open() ]] end },
            { "-",         function() vim.cmd [[ lua MiniFiles.open() ]] end },
        }
    },
}
