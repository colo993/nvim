return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    name = "kanagawa",
    priority = 1000,
    config = function()
      vim.keymap.set("n", "<leader>kw", ":colorscheme kanagawa-wave<CR>", { desc = "Kanagawa Wave theme" })
      vim.keymap.set("n", "<leader>kd", ":colorscheme kanagawa-dragon<CR>", { desc = "Kanagawa Dragon theme" })
      vim.keymap.set("n", "<leader>kl", ":colorscheme kanagawa-lotus<CR>", { desc = "Kanagawa Lotus theme" })

      local kanagawa = require("kanagawa")

      kanagawa.setup({
        overrides = function(colors)
          return {
            Normal = { fg = "#D8DEE9" },
            ["@variable"] = { fg = "#D8DEE9" },
          }
        end,
      })

      vim.cmd.colorscheme("kanagawa-wave")
    end,
  },
}
