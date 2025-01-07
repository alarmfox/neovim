return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    {
      "windwp/nvim-ts-autotag",
      config = true,
    },
    {
      "nvim-treesitter/nvim-treesitter-context",
      opts = {
        line_numbers = true,
        enable = true,
      },
    },
  },
  config = function()
    require("nvim-treesitter.configs").setup({
      auto_install = false,
      sync_install = false,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
      ensure_installed = {
        "c",
        "lua",
        "javascript",
        "typescript",
        "html",
        "markdown",
        "markdown_inline",
        "json",
        "yaml",
        "make",
        "go",
        "cmake",
        "rust",
        "diff",
        "sql",
        "toml",
        "http",
      },
    })
  end,
}
