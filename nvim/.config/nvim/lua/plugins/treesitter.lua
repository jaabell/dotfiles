return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",

    opts = {
      ensure_installed = {
        "c",
        "cpp",
        "python",
        "lua",
        "bash",
        "cmake",
        "json",
        "yaml",
        "markdown",
      },

      highlight = {
        enable = true,
      },

      indent = {
        enable = true,
      },
    },
  },
}
