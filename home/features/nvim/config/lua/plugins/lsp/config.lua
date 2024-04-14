local M = {}

function M.on_attach(client, bufnr)
    -- stop TSServer from attaching when Deno project
    if (client.name == "tsserver" or client.name == "typescript-tools") and require("lspconfig").util.root_pattern("deno.json", "deno.jsonc")(vim.fn.getcwd()) then
        client.stop()
        return
    end

    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    local no_preview = require('plugins.telescope').no_preview

    nmap('<leader>re', vim.lsp.buf.rename, '[R]e[N]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gr', function() require('telescope.builtin').lsp_references(no_preview()) end, '[G]oto [R]eferences')
    nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    nmap('<leader>ds', function() require('telescope.builtin').lsp_document_symbols(no_preview()) end,
        '[D]ocument [S]ymbols')
    nmap('<leader>ws', function() require('telescope.builtin').lsp_dynamic_workspace_symbols(no_preview()) end,
        '[W]orkspace [S]ymbols')

    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')

    if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(bufnr, true)
    end

    require("lsp_signature").on_attach()
end

function M.disable_formatting(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
    M.on_attach(client, bufnr)
end

function M.setup()
    local lsp = require('lspconfig')

    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    capabilities.offsetEncoding = { 'utf-16' }

    local default_settings = { on_attach = M.on_attach, capabilities = capabilities }

    lsp.marksman.setup(default_settings)

    lsp.nil_ls.setup {
        on_attach = M.on_attach,
        capabilities = capabilities,
        settings = {
            ['nil'] = {
                nix = {
                    flake = {
                        autoArchive = true,
                    }
                }
            }
        }
    }

    lsp.lua_ls.setup {
        on_attach = M.on_attach,
        capabilities = capabilities,
        settings = {
            Lua = {
                runtime = {
                    version = 'LuaJIT',
                },
                diagnostics = {
                    globals = { 'vim', 'require' },
                },
                workspace = {
                    checkThirdParty = false,
                    library = {
                        vim.env.VIMRUNTIME
                    }
                },
                telemetry = { enable = false },
            },
        },
    }

    lsp.clangd.setup(default_settings)

    lsp.ltex.setup(default_settings)
    lsp.typst_lsp.setup(default_settings)


    vim.g.markdown_fenced_languages = {
        'ts=typescript'
    }

    lsp.denols.setup {
        on_attach = M.on_attach,
        capabilities = capabilities,
        root_dir = lsp.util.root_pattern('deno.json', 'deno.jsonc'),
        filetypes = { "typescript, typescriptreact, typescript.tsx" },
        settings = {
            deno = {
                enable = true,
                unstable = true,
                suggest = {
                    imports = {
                        hosts = {
                            ["https://deno.land"] = true,
                        }
                    }
                }
            }
        }
    }

    lsp.gopls.setup {
        on_attach = M.on_attach,
        capabilities = capabilities,
        settings = {
            gopls = {
                experimentalPostfixCompletions = true,
                analyses = {
                    unusedparams = true,
                    shadow = true
                },
                staticcheck = true,
            }
        },
        init_options = {
            usePlaceholders = true,
        }
    }

    vim.g.rustaceanvim = {
        server = {
            on_attach = M.on_attach,
            capabilities = capabilities,
            default_settings = {
                ['rust-analyzer'] = {
                    cargo = {
                        buildScripts = {
                            enable = true,
                        },
                        features = "all",
                    },
                    procMacro = {
                        enable = true,
                    },
                    lru = {
                        capacity = 256,
                    }
                }
            }
        }
    }

    require("typescript-tools").setup {
        on_attach = M.on_attach,
        capabilities = capabilities,
    }

    lsp.texlab.setup {
        on_attach = M.on_attach,
        capabilities = capabilities,
        root_dir = lsp.util.root_pattern('*.tex')
    }

    lsp.ansiblels.setup {
        on_attach = M.on_attach,
        capabilities = capabilities,
        filetypes = { 'yml', 'yaml', 'yml.ansible', 'yaml.ansible' },
        root_dir = lsp.util.root_pattern('ansible.cfg'),
        single_file_support = false,
    }

    lsp.volar.setup {
        on_attach = M.disable_formatting,
        capabilities = capabilities,
    }

    local json_capabilities = require('cmp_nvim_lsp').default_capabilities()
    json_capabilities.textDocument.completion.completionItem.snippetSupport = true
    lsp.jsonls.setup {
        on_attach = M.on_attach,
        capabilities = json_capabilities,
        settings = {
            json = {
                schemas = {
                    {
                        fileMatch = { 'package.json' },
                        url = 'https://json.schemastore.org/package.json',
                    },
                    {
                        fileMatch = { 'tsconfig.json' },
                        url = 'https://json.schemastore.org/tsconfig.json',
                    },
                },
            },
        }
    }

    local yaml_cfg = require('yaml-companion').setup()
    lsp.yamlls.setup(yaml_cfg)

    lsp.html.setup(default_settings)
    lsp.cssls.setup(default_settings)
end

function M.eslint_condition(utils)
    return utils.root_has_file { '.eslintrc', '.eslintrc.json', '.eslintrc.js' }
end

return M
