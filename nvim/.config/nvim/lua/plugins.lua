local cmp = require "plug-config.cmp"
local lsp = require "lsp"
local mason = require "plug-config.mason"
local null_ls = require "plug-config.null-ls"
local metals = require "plug-config.nvim-metals"
local treesitter = require "plug-config.treesitter"
local lualine = require "plug-config.lualine"
local telescope = require "plug-config.telescope"
local harpoon = require "plug-config.harpoon"

require "lazy".setup {
    -- Visual
    {
        "catppuccin/nvim",
        lazy = false,
        name = "catppuccin",
        priority = 1000,
        config = function()
            require "catppuccin".setup {
                flavour = "mocha",
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    mason = true,
                    mini = true,
                    native_lsp = {
                        enabled = true,
                        virtual_text = {
                            errors = { "italic" },
                            hints = { "italic" },
                            warnings = { "italic" },
                            information = { "italic" },
                        },
                        underlines = {
                            errors = { "underline" },
                            hints = { "underline" },
                            warnings = { "underline" },
                            information = { "underline" },
                        },
                    },
                    telescope = true,
                    treesitter = true,
                    ts_rainbow = true,
                }
            }
            vim.cmd "colorscheme catppuccin"
        end
    },
    treesitter,
    -- Status line
    lualine,
    {
        "lukas-reineke/indent-blankline.nvim",
        opts = {
            show_current_context = true,
            show_current_context_start = true,
        }
    },
    -- Git
    {
        "lewis6991/gitsigns.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = true,
    },
    {
        "someone-stole-my-name/yaml-companion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require "telescope".load_extension "yaml_schema"
        end,
        lazy = true,
    },
    -- Autocompletion
    cmp,
    {
        "David-Kunz/cmp-npm",
        dependencies = { 'nvim-lua/plenary.nvim' },
        ft = "json",
        config = function()
            require "cmp-npm".setup({})
        end
    },
    -- LSP
    lsp,
    mason,
    null_ls,
    metals,
    {
        "ray-x/lsp_signature.nvim",
        config = true,
        lazy = true,
        event = "InsertEnter",
    },
    -- Utils
    "folke/which-key.nvim",
    {
        "unblevable/quick-scope",
        keys = { "f", "F", "t", "T" },
    },
    telescope,
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require "telescope".load_extension "file_browser"
        end,
        lazy = true,
    },
    "tpope/vim-sleuth",
    {
        "tpope/vim-fugitive",
        cmd = { "G", "Git" },
    },
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
            require "project_nvim".setup {
                manual_mode = true,
                silent_chdir = false,
            }
        end,
    },
    {
        "zbirenbaum/copilot.lua",
        lazy = true,
        event = "InsertEnter",
        config = true,
        opts = {
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
        }
    },
    { "windwp/nvim-autopairs", lazy = true, config = true, },
    -- mini.nvim
    {
        "echasnovski/mini.comment",
        version = false,
        config = function()
            require "mini.comment".setup()
        end
    },
    {
        "echasnovski/mini.surround",
        version = false,
        config = function()
            require "mini.surround".setup()
        end
    },
    {
        'echasnovski/mini.files',
        version = false,
        config = function()
            require "mini.files".setup()
        end,
        keys = {
            { "<Leader>n", function() vim.cmd [[ lua MiniFiles.open() ]] end },
            { "-",         function() vim.cmd [[ lua MiniFiles.open() ]] end },
        }
    },
    harpoon,
}
