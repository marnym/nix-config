local null_ls = require("null-ls")
local lsp_helpers = require("lsp.lsp-helpers")

local function eslint_condition(utils)
	return utils.root_has_file({ ".eslintrc", ".eslintrc.json", ".eslintrc.js" })
end

null_ls.setup({
	sources = {
		null_ls.builtins.diagnostics.eslint_d.with({
			condition = eslint_condition,
		}),
		null_ls.builtins.code_actions.eslint_d.with({
			condition = eslint_condition,
		}),
		null_ls.builtins.formatting.prettier.with({
			condition = function(utils)
				return utils.root_has_file({ ".prettierrc", ".prettierrc.json", ".prettierrc.js" })
			end,
		}),
		null_ls.builtins.formatting.black,
		null_ls.builtins.code_actions.gitsigns,
		null_ls.builtins.formatting.stylua,
	},
	on_attach = lsp_helpers.on_attach,
})
