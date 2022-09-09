local function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local telescope = require("telescope")

telescope.setup({
	defaults = {
		mappings = {
			i = {
				["<C-j>"] = "move_selection_next",
				["<C-k>"] = "move_selection_previous",
			},
		},
	},
})

telescope.load_extension("projects")

map("n", "<Leader>fp", "<cmd>lua require'telescope.builtin'.git_files{}<CR>", { silent = true })
map("n", "<Leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", { silent = true })
map("n", "<Leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", { silent = true })
map("n", "<Leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", { silent = true })
map("n", "<Leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", { silent = true })
map("n", "<Leader>fs", "<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<cr>", { silent = true })
map("n", "<Leader>fr", "<cmd>lua require('telescope.builtin').lsp_references()<cr>", { silent = true })
map("n", "<Leader>fq", "<cmd>lua require('telescope.builtin').diagnostics()<cr>", { silent = true })
map("n", "<Leader>pp", "<cmd>lua require('telescope').extensions.projects.projects()<cr>", { silent = true })
