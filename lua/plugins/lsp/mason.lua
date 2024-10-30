local M = {
	"williamboman/mason.nvim",
}

M.dependencies = {
	"williamboman/mason-lspconfig.nvim",
}

M.keys = {
	{ "<leader>m", "<cmd>Mason<CR>", desc = "open Mason" },
}

M.opts = {
	ui = {
		border = "rounded",
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
}

return M
