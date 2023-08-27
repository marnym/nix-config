local no_preview = function()
    return require('telescope.themes').get_dropdown({
        borderchars = {
            { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
            prompt = { "─", "│", " ", "│", '┌', '┐', "│", "│" },
            results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
            preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
        },
        width = 0.8,
        previewer = false,
        prompt_title = false
    })
end

return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-lua/popup.nvim",
    },
    keys = {
        {
            "<Leader>fp",
            function() require("telescope.builtin").git_files(no_preview()) end,
            desc = "Find Git files"
        },
        { "<Leader>ff", function() require("telescope.builtin").find_files(no_preview()) end },
        { "<Leader>fg", function() require("telescope.builtin").live_grep(no_preview()) end },
        { "<Leader>fb", function() require("telescope.builtin").buffers(no_preview()) end },
        { "<Leader>fh", function() require("telescope.builtin").help_tags(no_preview()) end },
        { "<Leader>fs", function() require("telescope.builtin").lsp_dynamic_workspace_symbols(no_preview()) end },
        { "<Leader>fr", function() require("telescope.builtin").lsp_references(no_preview()) end },
        { "<Leader>fq", function() require("telescope.builtin").diagnostics(no_preview()) end },
        { "<Leader>fe",
            function()
                require("telescope").extensions.file_browser.file_browser({
                    path = vim.fs.dirname(vim.api.nvim_buf_get_name(0)),
                    select_buffer = true,
                    theme = no_preview(),
                })
            end },
        { "<leader>ys", function() require("telescope").extensions.yaml_schema.yaml_schema(no_preview()) end },
    },
    opts = {
        defaults = {
            mappings = {
                i = {
                    ["<C-j>"] = "move_selection_next",
                    ["<C-k>"] = "move_selection_previous",
                },
            },
            file_ignore_patterns = {
                "node_modules/"
            },
        },
        extensions = {
            file_browser = {
                hijack_netrw = true,
            }
        }
    }
}
