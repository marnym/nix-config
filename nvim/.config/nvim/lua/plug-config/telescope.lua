local function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<C-j>"] = "move_selection_next",
				["<C-k>"] = "move_selection_previous",
			},
		},
	},
})

map("n", "<Leader>fp", "<cmd>lua require'telescope.builtin'.git_files{}<CR>", { silent = true })
map("n", "<Leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", { silent = true })
map("n", "<Leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", { silent = true })
map("n", "<Leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", { silent = true })
map("n", "<Leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", { silent = true })
map("n", "<Leader>fs", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>", { silent = true })
