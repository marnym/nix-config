local telescope = require "telescope"

telescope.setup {
	defaults = {
		mappings = {
			i = {
				["<C-j>"] = "move_selection_next",
				["<C-k>"] = "move_selection_previous",
			},
		},
	},
}

telescope.load_extension "projects"
telescope.load_extension "yaml_schema"

local telescope_builtin = require "telescope.builtin"

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<Leader>fp", telescope_builtin.git_files, opts)
vim.keymap.set("n", "<Leader>ff", telescope_builtin.find_files, opts)
vim.keymap.set("n", "<Leader>fg", telescope_builtin.live_grep, opts)
vim.keymap.set("n", "<Leader>fb", telescope_builtin.buffers, opts)
vim.keymap.set("n", "<Leader>fh", telescope_builtin.help_tags, opts)
vim.keymap.set("n", "<Leader>fs", telescope_builtin.lsp_dynamic_workspace_symbols, opts)
vim.keymap.set("n", "<Leader>fr", telescope_builtin.lsp_references, opts)
vim.keymap.set("n", "<Leader>fq", telescope_builtin.diagnostics, opts)
vim.keymap.set("n", "<Leader>pp", telescope.extensions.projects.projects, opts)
vim.keymap.set("n", "<leader>ys", telescope.extensions.yaml_schema.yaml_schema, opts)
