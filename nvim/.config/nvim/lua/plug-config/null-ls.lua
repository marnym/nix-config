local null_ls = require("null-ls")
local lsp_helpers = require('lsp.lsp-helpers')

null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.code_actions.eslint_d,
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.completion.spell,
  },
  on_attach = lsp_helpers.on_attach
})
