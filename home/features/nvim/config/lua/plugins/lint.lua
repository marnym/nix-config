return {
    {
        "mfussenegger/nvim-lint",
        event = "BufEnter",
        config = function()
            vim.diagnostic.config {
                virtual_text = {
                    source = true
                },
                float = {
                    source = true
                }
            }

            local lint = require("lint")
            lint.linters_by_ft = {
                sh = { "shellcheck" },
            }

            local eslint_d_exists = vim.fn.executable("eslint_d") == 1

            ---@param path string
            ---@return boolean
            local function root_has(path)
                return vim.fn.glob(path) ~= ""
            end

            vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                group = vim.api.nvim_create_augroup("lint", { clear = true }),
                callback = function()
                    lint.try_lint()

                    -- todo: check filetype
                    if root_has("deno.json") then
                        lint.try_lint("deno")
                    elseif root_has(".eslintrc*") and eslint_d_exists then
                        lint.try_lint("eslint_d")
                    elseif root_has(".eslintrc*") and not eslint_d_exists then
                        lint.try_lint("eslint")
                    end
                end,
            })
        end
    }
}
