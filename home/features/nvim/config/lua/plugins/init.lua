vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
vim.cmd("highlight QuickScopePrimary guifg='#00C7DF' gui=underline ctermfg=155 cterm=underline")
vim.cmd("highlight QuickScopeSecondary guifg='#afff5f' gui=underline ctermfg=81 cterm=underline")
vim.g.qs_max_chars = 150

return {
    -- Visual
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        event = "BufEnter",
        opts = {
            debounce = 100,
            indent = { char = "┊" },
            scope = {
                enabled = true,
                highlight = "Identifier",
                char = "│",
            }
        }
    },
    {
        "folke/trouble.nvim",
        keys = {
            {
                "<leader>q",
                function() require("trouble").open() end,
                desc =
                "Open trouble.nvim"
            },
            {
                "gp",
                function()
                    local trouble = require("trouble")
                    if trouble.is_open() then
                        trouble.previous({ skip_groups = true, jump = true })
                    else
                        vim.diagnostic.goto_prev()
                    end
                end,
                desc = "[G]o to [P}revious diagnostic"
            },
            {
                "gn",
                function()
                    local trouble = require("trouble")
                    if trouble.is_open() then
                        trouble.next({ skip_groups = true, jump = true })
                    else
                        vim.diagnostic.goto_next()
                    end
                end,
                desc =
                "[G]o to [N]ext diagnostic"
            },
        },
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            auto_preview = false,
            win_config = {
                border = "rounded",
            },
        },
    },
    {
        "someone-stole-my-name/yaml-companion.nvim",
        lazy = true,
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("telescope").load_extension("yaml_schema")
        end,
    },
    -- Autocompletion
    {
        "David-Kunz/cmp-npm",
        dependencies = { 'nvim-lua/plenary.nvim' },
        ft = "json",
        config = function()
            require("cmp-npm").setup {}
        end
    },
    {
        "mrcjkb/rustaceanvim",
        version = '^4',
        ft = "rust",
    },
    {
        "pmizio/typescript-tools.nvim",
        ft = "javascript,javascriptreact,javascript.jsx,typescript,typescriptreact,typescript.tsx",
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    },
    -- Utils
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
    },
    {
        "unblevable/quick-scope",
        keys = { "f", "F", "t", "T" },
    },
    {
        "danymat/neogen",
        cmd = "Neogen",
        opts = {
            snippet_engine = "luasnip"
        },
    },
    {
        "ahmedkhalf/project.nvim",
        config = function()
            require("project_nvim").setup {
                manual_mode = true,
                silent_chdir = false,
            }
        end
    },
    { "windwp/nvim-autopairs", lazy = true, config = true, },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
        keys = {
            { "<Leader>n", function() vim.cmd [[Neotree toggle]] end },
        },
    },
    -- mini.nvim
    {
        "echasnovski/mini.starter",
        version = false,
        lazy = false,
        config = true,
    },
    {
        "echasnovski/mini.surround",
        version = false,
        event = "BufEnter",
        config = function()
            require("mini.surround").setup()
        end
    },
    {
        'echasnovski/mini.files',
        version = false,
        config = function()
            require("mini.files").setup {
                mappings = {
                    go_in = 'L',
                    go_in_plus = 'l',
                },
            }
        end,
        keys = {
            { "-", function() require("mini.files").open(vim.api.nvim_buf_get_name(0)) end },
        }
    },
}
