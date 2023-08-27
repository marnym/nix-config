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
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
            cond = function()
                return vim.fn.executable 'make' == 1
            end,
        },
    },
    keys = {
        {
            "<leader><space>",
            function() require("telescope.builtin").buffers(no_preview()) end,
            desc = "[ ] Find existing buffers"
        },
        {
            "<leader>gf",
            function() require("telescope.builtin").git_files(no_preview()) end,
            desc = "Search [G]it [F]iles",
        },
        {
            "<leader>sf",
            function() require("telescope.builtin").find_files(no_preview()) end,
            desc = "[S]earch [F]iles",
        },
        {
            "<leader>sw",
            function() require("telescope.builtin").grep_string(no_preview()) end,
            desc = "[S]earch current [W]ord",
        },
        {
            "<leader>sg",
            function() require("telescope.builtin").live_grep(no_preview()) end,
            desc = "[S]earch by [G]rep",
        },
        {
            "<leader>sh",
            function() require("telescope.builtin").help_tags(no_preview()) end,
            desc = "[S]earch [H]elp"
        },
        {
            "<leader>ss",
            function() require("telescope.builtin").lsp_dynamic_workspace_symbols(no_preview()) end,
            desc = "[S]earch [S]ymbols"
        },
        {
            "<leader>sd",
            function() require("telescope.builtin").diagnostics(no_preview()) end,
            desc = "[S]earch [D]iagnostics"
        },
        {
            "<leader>ys",
            function() require("telescope").extensions.yaml_schema.yaml_schema(no_preview()) end,
            desc = "[Y]aml [S]chema"
        },
    },
    config = function()
        require('telescope').setup({
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
        })
        pcall(require('telescope').load_extension, 'fzf')
    end,
}
