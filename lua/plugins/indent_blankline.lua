-- lua/plugins/indent_blankline.lua

return {
  "lukas-reineke/indent-blankline.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function ()
    require('ibl').setup({
    })
  end
}
