return {
    -- Visual
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd [[ colorscheme tokyonight-night ]]
        end,
        opts = {},
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        opts = {
            show_current_context = true,
            show_current_context_start = true,
        }
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
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("telescope").load_extension("file_browser")
        end,
        lazy = true,
    },
    "tpope/vim-sleuth",
    "lervag/vimtex",
    {
        "iamcco/markdown-preview.nvim",
        build = "cd app && npm install",
        ft = "markdown"
    },
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
