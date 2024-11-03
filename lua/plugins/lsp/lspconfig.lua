local M = {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
}

M.dependencies = {
  { "williamboman/mason.nvim", config = true },
  "williamboman/mason-lspconfig.nvim",
  "hrsh7th/cmp-nvim-lsp",
}

function M.config()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
  local servers = require("server_settings").servers
  local custom = require("custom")

  local lsp_keymap = function(bufnr)
    -- lsp-builtin
    local set = function(keys, func, indesc)
      vim.keymap.set("n", keys, func, { buffer = bufnr, desc = indesc })
    end
    set("K", vim.lsp.buf.hover, "hover")
    set("gD", vim.lsp.buf.declaration, "declaration")
    set("gd", vim.lsp.buf.definition, "definition")
    set("gk", vim.lsp.buf.signature_help, "LSP Signature help")
    set("gi", vim.lsp.buf.implementation, "implementation")
    set("[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
    set("]d", vim.diagnostic.goto_next, "Next Diagnostic")
    set("<leader>cn", vim.lsp.buf.rename, "[C]ode Item Re[N]ame")
    set("<leader>ct", vim.lsp.buf.type_definition, "[C]ode [T]ype definition")
    set("<leader>cd", vim.diagnostic.open_float, "[C]ode [D]iagnostic")
    set("<leader>cf", vim.lsp.buf.format, "[Code] [F]ormat")
  end

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
    callback = function(args)
      lsp_keymap(args.buf)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
        local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
          buffer = args.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
          buffer = args.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.clear_references,
        })

        vim.api.nvim_create_autocmd("LspDetach", {
          group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
          callback = function(args2)
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = args2.buf })
          end,
        })
      end

      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client and client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true)
      end
    end,
  })

  require('mason-lspconfig').setup {
    handlers = {
      function(server_name)
        local server = servers[server_name] or {}
        server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
        require('lspconfig')[server_name].setup(server)
      end,
    },
  }
  vim.diagnostic.config {
    virtual_text = { spacing = 4 },
    float = {
      border = custom.border,
      severity_sort = true,
      source = "if_many",
    },
    severity_sort = true,
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = custom.icons.diagnostic.Error,
        [vim.diagnostic.severity.WARN] = custom.icons.diagnostic.Warning,
        [vim.diagnostic.severity.HINT] = custom.icons.diagnostic.Hint,
        [vim.diagnostic.severity.INFO] = custom.icons.diagnostic.Information,
      },
    },
  }
end

return M
