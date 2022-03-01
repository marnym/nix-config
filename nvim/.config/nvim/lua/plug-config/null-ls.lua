local nvim_lsp = require("lspconfig")
local null_ls = require("null-ls")
local lsp_helpers = require('lsp.lsp-helpers')

null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.code_actions.eslint_d,
    null_ls.builtins.formatting.prettier,
  },
  on_attach = lsp_helpers.on_attach
  -- TODO: Add should_attach that checks if eslintrc or prettierc exists and only attaches then
})
