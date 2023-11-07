vim.api.nvim_create_user_command("FormatDisable",
    function(args)
        if args.bang then
            -- FormatDisable! will disable formatting just for this buffer
            vim.b.disable_autoformat = true
        else
            vim.g.disable_autoformat = true
        end
    end,
    {
        desc = "Disable autoformat-on-save",
        bang = true,
    }
)

vim.api.nvim_create_user_command("FormatEnable",
    function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
    end,
    {
        desc = "Re-enable autoformat-on-save",
    }
)

local function deno_overwrite()
    local is_deno_project = vim.fn.glob("deno.json") ~= ""
    if is_deno_project then
        return { "deno_fmt" }
    else
        return { { "prettierd", "prettier" } }
    end
end

return {
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        keys = {
            {
                -- Customize or remove this keymap to your liking
                "<leader>fo",
                function()
                    require("conform").format({ async = true, lsp_fallback = true })
                end,
                mode = "",
                desc = "Format buffer",
            },
        },
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "black" },

                javascript = deno_overwrite(),
                typescript = deno_overwrite(),
                javascriptreact = deno_overwrite(),
                typescriptreact = deno_overwrite(),
                astro = deno_overwrite(),

                nix = { "nixpkgs_fmt" },
            },
            format_on_save = function(bufnr)
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                    return
                end
                return { timeout_ms = 500, lsp_fallback = true }
            end,
        },
    }
}
