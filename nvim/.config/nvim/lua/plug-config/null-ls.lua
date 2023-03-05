local function eslint_condition(utils)
	return utils.root_has_file { ".eslintrc", ".eslintrc.json", ".eslintrc.js" }
end

local M = {}

function M.setup()
	local null_ls = require "null-ls"
	local lsp_helpers = require "lsp"


	null_ls.setup {
		debug = false,
		sources = {
			null_ls.builtins.diagnostics.eslint_d.with({
				condition = eslint_condition,
			}),
			null_ls.builtins.code_actions.eslint_d.with({
				condition = eslint_condition,
			}),
			null_ls.builtins.formatting.prettierd.with({
				condition = function(utils)
					return utils.root_has_file { ".prettierrc", ".prettierrc.json", ".prettierrc.js" }
				end,
			}),
			null_ls.builtins.formatting.black,
			null_ls.builtins.code_actions.gitsigns,
			null_ls.builtins.diagnostics.markdownlint.with {
				filter = function(diagnostic)
					return diagnostic.code ~= "MD013/line-length"
				end
			},
		},
		on_attach = lsp_helpers.on_attach,
		root_dir = function() return nil end,
	}
end

return M
