local function no_preview()
    return require('telescope.themes').get_dropdown({
        borderchars = {
            { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
            prompt = { "─", "│", " ", "│", '┌', '┐', "│", "│" },
            results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
            preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
        },
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

        vim.keymap.set('n', '<leader><space>', function() require("telescope.builtin").buffers(no_preview()) end,
            { desc = "[ ] Find existing buffers" })
        vim.keymap.set('n', '<leader>fp', function() require("telescope.builtin").git_files(no_preview()) end,
            { desc = "[F]ind [P]roject files" })
        vim.keymap.set('n', '<leader>ff', function() require("telescope.builtin").find_files(no_preview()) end,
            { desc = "[F]ind [F]iles" })
        vim.keymap.set('n', '<leader>sw', function() require("telescope.builtin").grep_string(no_preview()) end,
            { desc = "[S]earch current [W]ord" })
        vim.keymap.set('n', '<leader>fg', function() require("telescope.builtin").live_grep(no_preview()) end,
            { desc = "[F]ind by [G]rep" })
        vim.keymap.set('n', '<leader>sh', function() require("telescope.builtin").help_tags(no_preview()) end,
            { desc = "[S]earch [H]elp" })
        vim.keymap.set('n', '<leader>ss',
            function() require("telescope.builtin").lsp_dynamic_workspace_symbols(no_preview()) end,
            { desc = "[S]earch [S]ymbols" })
        vim.keymap.set('n', '<leader>sd', function() require("telescope.builtin").diagnostics(no_preview()) end,
            { desc = "[S]earch [D]iagnostics" })
        vim.keymap.set('n', '<leader>ys',
            function() require("telescope").extensions.yaml_schema.yaml_schema(no_preview()) end,
            { desc = "[Y]aml [S]chema" })
    end,

    no_preview = no_preview,
}
