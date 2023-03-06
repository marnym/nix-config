local cmp = require "plug-config.cmp"
local lsp = require "lsp"
local mason = require "plug-config.mason"
local null_ls = require "plug-config.null-ls"
local metals = require "plug-config.nvim-metals"
local treesitter = require "plug-config.treesitter"
local lualine = require "plug-config.lualine"
local telescope = require "plug-config.telescope"

require "lazy".setup {
    -- Visual
    {
        "catppuccin/nvim",
        lazy = false,
        name = "catppuccin",
        priority = 1000,
        config = function()
            require "catppuccin".setup {
                transparent_background = true,
                term_colors = true,
                styles = {
                    comments = { "italic" },
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
    -- LSP
    lsp,
    mason,
    null_ls,
    metals,
    {
        "ray-x/lsp_signature.nvim",
        config = true,
        event = "InsertEnter *.*",
    },
    -- Utils
    "folke/which-key.nvim",
    {
        "unblevable/quick-scope",
        keys = { "f", "F", "t", "T" },
    },
    { "windwp/nvim-autopairs", lazy = true, config = true, },
    telescope,
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require "telescope".load_extension "file_browser"
        end,
        lazy = true,
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
        keys = {
            { "<Leader>n", ":Neotree reveal<CR>" },

        }
    },
    "b3nj5m1n/kommentary",
    "lervag/vimtex",
    {
        "danymat/neogen",
        config = true,
    },
}
