return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufNewFile", "BufRead" },
    cmd = { "TSUpdate", "TSInstall", "TSInstallInfo" },
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup {
            auto_install = false,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            ensure_installed = {
                "cpp",
                "lua",
                "rust",
                "python",
                "regex",
                "bash",
                "markdown_inline",
                "yaml",
                "markdown",
                "html",
                "css",
                "typst",
                "vimdoc",
            },
        }
    end,
}