vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
vim.cmd("highlight QuickScopePrimary guifg='#00C7DF' gui=underline ctermfg=155 cterm=underline")
vim.cmd("highlight QuickScopeSecondary guifg='#afff5f' gui=underline ctermfg=81 cterm=underline")
vim.g.qs_max_chars = 150

return {
    -- Visual
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
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
            require("mini.files").setup({
                mappings = {
                    go_in = 'L',
                    go_in_plus = 'l',
                },
            })
        end,
        keys = {
            { "<Leader>n", function() vim.cmd [[ lua MiniFiles.open() ]] end },
            { "-",         function() vim.cmd [[ lua MiniFiles.open(vim.api.nvim_buf_get_name(0)) ]] end },
        }
    },
}
