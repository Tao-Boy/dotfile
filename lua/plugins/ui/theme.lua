local M = {
	"catppuccin/nvim",
}

function M.config()
	require("catppuccin").setup({
		flavour = "mocha", -- latte, frappe, macchiato, mocha
		transparent_background = false, -- disables setting the background color.
		term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
	})
	vim.cmd.colorscheme("catppuccin")
end

return M
