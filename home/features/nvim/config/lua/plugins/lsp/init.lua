return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "folke/neodev.nvim",
        },
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
            vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help,
                { border = 'rounded' })

            require("mason").setup()
            require("mason-lspconfig").setup()
            require("plugins/lsp/config").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = true,
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        opts = {
            ui = {
                icons = {
                    server_installed = "✓",
                    server_pending = "➜",
                    server_uninstalled = "✗",
                },
            },
        },
    },
    {
        "ray-x/lsp_signature.nvim",
        event = "InsertEnter",
        config = function()
            require("lsp_signature").setup {
                bind = true, -- This is mandatory, otherwise border config won't get registered.
                hint_enable = true,
            }
        end,
    },
    {
        "scalameta/nvim-metals",
        dependencies = { "nvim-lua/plenary.nvim" },
        ft = { "scala", "sbt" },
        config = function()
            local metals_config = require("metals").bare_config()
            metals_config.settings = {
                showImplicitArguments = true,
                excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
            }

            local nvim_metals_group = vim.api.nvim_create_augroup("NvimMetals", { clear = true })
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "scala", "sbt" },
                callback = function()
                    require("metals").initialize_or_attach(metals_config)
                end,
                group = nvim_metals_group,
            })
        end,
    },
}
