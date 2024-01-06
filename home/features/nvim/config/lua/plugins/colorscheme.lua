return {
    {
        "sainnhe/gruvbox-material",
        lazy = false,
        priority = 1000,
        config = function()
            vim.o.background = "dark"
            vim.g.gruvbox_material_background = "hard"
            vim.g.gruvbox_material_foreground = "material"
            vim.g.gruvbox_material_better_performance = 1
            vim.g.gruvbox_material_diagnostic_virtual_text = "colored"

            local group = vim.api.nvim_create_augroup("GruvboxMaterialCustom", { clear = true })
            vim.api.nvim_create_autocmd({ "ColorScheme" }, {
                pattern = "gruvbox-material",
                group = group,
                callback = function()
                    local palette = vim.api.nvim_call_function("gruvbox_material#get_palette",
                        { vim.g.gruvbox_material_background, vim.g.gruvbox_material_foreground, vim.api.nvim_eval("{}") })

                    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE", fg = palette.grey1[1] })
                    vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE", fg = palette.grey1[1] })
                end,
            })

            vim.cmd("colorscheme gruvbox-material")
        end
    },
}
