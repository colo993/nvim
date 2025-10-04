return {
  "echasnovski/mini.nvim",
  event = "VeryLazy",
  config = function()
    -- mini.ai setup
    require("mini.ai").setup({
      custom_textobjects = {
        o = require("mini.ai").gen_spec.treesitter({
          a = { "@block.outer", "@conditional.outer", "@loop.outer" },
          i = { "@block.inner", "@conditional.inner", "@loop.inner" },
        }, {}),
        f = require("mini.ai").gen_spec.treesitter({
          a = "@function.outer",
          i = "@function.inner",
        }, {}),
        c = require("mini.ai").gen_spec.treesitter({
          a = "@class.outer",
          i = "@class.inner",
        }, {}),
      },
      n_lines = 500,
      search_method = "cover_or_next",
    })

    -- mini.indentscope setup
    require("mini.indentscope").setup({
      symbol = "│",
      options = { try_as_border = true },
    })

    -- Disable indentscope in certain filetypes
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "help",
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
      },
      callback = function()
        vim.b.miniindentscope_disable = true
      end,
    })
  end,
}
