return {
    "hrsh7th/nvim-cmp",
    lazy = false,
    priority = 100,
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lua",
        {
            "L3MON4D3/LuaSnip",
            version = "2.*",
        },
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",
        "onsails/lspkind.nvim",
        {
            "folke/lazydev.nvim",
            ft = "lua",
            opts = {
                library = {
                    { path = "luvit-meta/library", words = { "vim%.uv" } },
                },
            },
        },
        { "Bilal2453/luvit-meta", lazy = true },
    },
    config = function()
        require "completion"
    end
}
