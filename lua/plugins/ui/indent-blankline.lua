local M = {
	"lukas-reineke/indent-blankline.nvim",
  event = "User AfterLoad",
	main = "ibl",
}

M.opts = {}

function M.config()
	require("ibl").setup()
end

return M
