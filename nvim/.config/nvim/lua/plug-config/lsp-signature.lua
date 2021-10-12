  require "lsp_signature".setup({
      bind = true, -- This is mandatory, otherwise border config won't get registered.
      doc_lines = 0,
      hi_parameter = "IncSearch",
      floating_window = false,
      hint_enable = true,
      handler_opts = {
        border = "single"
      }
    })
