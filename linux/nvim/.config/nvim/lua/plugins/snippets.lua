require'snippets'.use_suggested_mappings()

local nvim_lsp = require('lspconfig')
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true;

-- requires snippet support to provide completion
nvim_lsp.html.setup {
    capabilities = capabilities;
    on_attach = on_attach,
}
