return {
    {
        "mfussenegger/nvim-lint",
        config = function()
            vim.diagnostic.config({
                virtual_text = {
                    source = true
                },
                float = {
                    source = true
                }
            })

            local lint = require("lint")
            lint.linters_by_ft = {
                javascript = { "eslint_d" },
                typescript = { "eslint_d" },
                javascriptreact = { "eslint_d" },
                typescriptreact = { "eslint_d" },
                astro = { "eslint_d" },
            }

            vim.api.nvim_create_autocmd({ "BufWritePost" },
                {
                    callback = function()
                        lint.try_lint()
                    end,
                })
        end
    }
}