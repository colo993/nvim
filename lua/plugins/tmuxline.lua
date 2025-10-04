return {
  "edkolev/tmuxline.vim",
  dependencies = { "nvim-lualine/lualine.nvim" },
  config = function()
    vim.g.tmuxline_preset = {
      a = "#S",
      b = "#W",
      c = "#H",
      win = "#I #W",
      cwin = "#I #W",
      x = "%a",
      y = "%R",
      z = "#h",
    }
    vim.g.tmuxline_theme = "kanagawa"
  end,
}
