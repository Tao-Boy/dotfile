local M = {}

M.servers = {
	lua_ls = {
		cmd = { "lua-language-server" },
		filetypes = { "lua" },
		root_dir = require("lspconfig.util").root_pattern(".git", vim.fn.getcwd()),
	},
	tinymist = {
		offset_encoding = "utf-8",
		cmd = { "tinymist" },
		single_file_support = true,
		settings = {
			exportPdf = "never",
			formatterMode = "typstfmt"
		},
	}
}

return M
