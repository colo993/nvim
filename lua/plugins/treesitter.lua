return {
  -- Main treesitter plugin
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    priority = 1000,
    config = function()
      require("nvim-treesitter.config").setup({
        ensure_installed = {
          "bash",
          "css",
          "dockerfile",
          "go",
          "html",
          "javascript",
          "json",
          "lua",
          "markdown",
          "python",
          "rust",
          "toml",
          "typescript",
          "yaml",
          "c",
          "htmldjango",
        },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = false },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<cr>",
            node_incremental = "<cr>",
            node_decremental = "<bs>",
            scope_incremental = "<tab>",
          },
        },
        autotag = {
          enable = true,
        },
      })
    end,
  },

  -- Context plugin
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "VeryLazy",
    opts = {
      enable = true,
      max_lines = 1,
    },
  },

  -- Autotag plugin
  {
    "windwp/nvim-ts-autotag",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "VeryLazy",
  },

  -- Django templates
  {
    "g-hyuga/nvim-treesitter-django",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    url = "https://github.com/interdependence/tree-sitter-htmldjango.git",
  },
}
