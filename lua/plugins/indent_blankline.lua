-- lua/plugins/indent_blankline.lua

return {
  "lukas-reineke/indent-blankline.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function ()
    require('ibl').setup({
      indent = { highlight = "IblScope"},
      scope = {
        show_exact_scope = false,
        show_start = false,
        show_end = false,
        highlight = "IblScope",
      }
    })
  end
}
