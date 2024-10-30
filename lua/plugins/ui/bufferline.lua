local M = {
	"akinsho/bufferline.nvim",
	event = "User AfterLoad",
}

M.keys = {
	{ "<leader>bd", "<Cmd>bdelete<CR>",            desc = "Toggle Pin" },
	{ "<c-h>",      "<cmd>BufferLineCyclePrev<cr>",            desc = "Prev Buffer" },
	{ "<c-l>",      "<cmd>BufferLineCycleNext<cr>",            desc = "Next Buffer" },
}

M.opts = {}

return M
