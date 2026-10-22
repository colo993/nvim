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
    end,
  },
  {
    "ayu-theme/ayu-vim",
    lazy = false,
    name = "ayu",
    priority = 1000,
    config = function()
      vim.opt.termguicolors = true

      local function set_ayu(variant)
        vim.g.ayucolor = variant
        vim.cmd.colorscheme("ayu")
      end

      vim.keymap.set("n", "<leader>am", function()
        set_ayu("mirage")
      end, { desc = "Ayu Mirage" })
      vim.keymap.set("n", "<leader>ad", function()
        set_ayu("dark")
      end, { desc = "Ayu Dark" })
      vim.keymap.set("n", "<leader>al", function()
        set_ayu("light")
      end, { desc = "Ayu Light" })

      set_ayu("mirage")
    end,
  },
}
