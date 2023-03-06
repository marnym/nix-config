local M = {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-context",
		"p00f/nvim-ts-rainbow"
	},
}

function M.config()
	require "nvim-treesitter.configs".setup {
		ensure_installed = {
			"bash",
			"bibtex",
			"c",
			"comment",
			"cmake",
			"cpp",
			"css",
			"dockerfile",
			"go",
			"hcl",
			"html",
			"java",
			"javascript",
			"json",
			"kotlin",
			"latex",
			"lua",
			"python",
			"rust",
			"scala",
			"scss",
			"toml",
			"tsx",
			"typescript",
			"vue",
			"yaml",
		},
		highlight = {
			enable = true, -- false will disable the whole extension
		},
		rainbow = {
			enable = true,
			extended = true,
			max_file_lines = 1000,
		},
	}
end

return M
