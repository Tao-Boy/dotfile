local M = {
	"nvim-lualine/lualine.nvim",
	event = "User AfterLoad",
}

function M.config()
	require("lualine").setup({})
end

return M
