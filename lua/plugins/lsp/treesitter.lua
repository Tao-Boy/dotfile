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
                "vim",
                "regex",
                "bash",
                "markdown_inline",
                "comment",
                "yaml",
                "markdown",
                "fish",
                "html",
                "css",
                "javascript",
                "typescript",
                "nix",
                "typst",
                "vue",
                "astro",
                "vimdoc",
            },
        }
    end,
}