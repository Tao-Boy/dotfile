M = {
  "hrsh7th/nvim-cmp",
  event = {  "User AfterLoad" },
}

M.dependencies = {
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-nvim-lsp-signature-help",
  "hrsh7th/cmp-cmdline",
  "dmitmel/cmp-cmdline-history",
  "saadparwaiz1/cmp_luasnip",
  "onsails/lspkind.nvim",
}

function M.config()
  local luasnip = require("luasnip")
  local cmp = require("cmp")
  cmp.setup({
    inlay_hints = { enabled = true },

    experimental = {
      ghost_text = true,
    },

    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        local kind = require("lspkind").cmp_format { mode = "symbol", maxwidth = 50 } (entry, vim_item)
        local strings = vim.split(kind.kind, "%s", { trimempty = true })
        local menu = {
          luasnip = "[SNP]",
          nvim_lsp = "[LSP]",
          nvim_lua = "[VIM]",
          buffer = "[BUF]",
          async_path = "[PTH]",
          calc = "[CLC]",
          latex_symbols = "[TEX]",
          orgmode = "[ORG]",
        }
        kind.kind = (strings[1] or "")
        kind.menu = menu[entry.source.name]
        return kind
      end,
    },
    -- window = {
    -- 	completion = cmp.config.window.bordered(),
    -- 	documentation = cmp.config.window.bordered(),
    -- },

    completion = {
      completeopt = vim.o.completeopt,
    },

    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },

    mapping = cmp.mapping.preset.insert({
      ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
      ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if luasnip.expand_or_locally_jumpable() then
          luasnip.jump(1)
        else
          fallback()
        end
      end, { "i", "s", "c" }),

      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s", "c" }),
    }),
    sources = cmp.config.sources({
      -- { name = "lazydev" },
      { name = "nvim_lsp" },
      { name = "luasnip" }, -- For luasnip user
      { name = "buffer" },
      { name = "path" },
    }),
  })

  cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" },
    },
  })

  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      { name = "cmdline" },
    }),
    matching = { disallow_symbol_nonprefix_matching = false },
  })
end

return M
