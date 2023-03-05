local M = {}

M.keys = {
	{ "<Leader>fp", function() require "telescope.builtin".git_files() end,                    desc = "Find Git files" },
	{ "<Leader>ff", function() require "telescope.builtin".find_files() end },
	{ "<Leader>fg", function() require "telescope.builtin".live_grep() end },
	{ "<Leader>fb", function() require "telescope.builtin".buffers() end },
	{ "<Leader>fh", function() require "telescope.builtin".help_tags() end },
	{ "<Leader>fs", function() require "telescope.builtin".lsp_dynamic_workspace_symbols() end },
	{ "<Leader>fr", function() require "telescope.builtin".lsp_references() end },
	{ "<Leader>fq", function() require "telescope.builtin".diagnostics() end },
	{ "<leader>ys", function() require "telescope.extensions".yaml_schema.yaml_schema() end },
}

function M.setup()
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
end

return M
