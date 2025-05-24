return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      {
        "g-hyuga/nvim-treesitter-django",
        url = "git@github.com:interdependence/tree-sitter-htmldjango.git",
      },
    },
    config = function()
      local config = require("nvim-treesitter.configs")
      config.setup({
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        ensure_installed = {
          "html",
          "css",
          "javascript",
          "python",
          "lua",
          "toml",
          "htmldjango", -- Essential for Django templates
        },
        textobjects = {
          select = {
            enable = true,
          },
        },
      })
    end,
  },
}
