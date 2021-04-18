local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.html.setup{
  on_attach = require'lspconfig'.common_on_attach,
  capabilities = capabilities,
}
