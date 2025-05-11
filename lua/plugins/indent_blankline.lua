-- lua/plugins/indent_blankline.lua

return {
  'chasnovski/mini.nvim',
  config = function()
    require('mini.indentscope').setup({
    })
  end
}
