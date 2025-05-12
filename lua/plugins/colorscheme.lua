return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    name = 'kanagawa',
    priority = 1000,
    config = function()
      local kanagawa = require("kanagawa")
      kanagawa.setup({
      })
      vim.cmd.colorscheme 'kanagawa-dragon'
    end
  }
}
