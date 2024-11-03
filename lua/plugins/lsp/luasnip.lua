local M = {
    "L3MON4D3/LuaSnip",
    dependencies = {
        "nvim-treesitter/nvim-treesitter"
    },
    event = "User AfterLoad",
}

function M.config()
    local snippets_paths = function ()
        if vim.fn.has "win32" == 1 then
            return "~/AppData/Local/nvim/snippets/"
        else
            return "~/.config/nvim/snippets/"
        end
    end
    require("luasnip").config.setup({ enable_autosnippets = true })
    require("luasnip.loaders.from_lua").load({ paths = snippets_paths() })
end

M.keys = {
      {
        "<C-Space>",
        "<Plug>luasnip-next-choice",
        mode = { "i", "s" },
      },
}

return M