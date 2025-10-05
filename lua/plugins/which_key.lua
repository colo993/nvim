return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern", -- or "classic", "helix"
    delay = 200, -- delay before showing the popup (ms)
    defer = function(ctx)
      return ctx.mode == "V" or ctx.mode == "<C-V>"
    end,
    plugins = {
      marks = true, -- shows a list of your marks on ' and `
      registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
      spelling = {
        enabled = true, -- show suggestions for misspelled words
        suggestions = 20,
      },
      presets = {
        operators = true, -- adds help for operators like d, y, ...
        motions = true, -- adds help for motions
        text_objects = true, -- help for text objects triggered after an operator
        windows = true, -- default bindings on <c-w>
        nav = true, -- misc bindings to work with windows
        z = true, -- bindings for folds, spelling and others
        g = true, -- bindings for code actions, goto ...
      },
    },

    -- New v3 syntax for icons
    icons = {
      breadcrumb = "»",
      separator = "➜",
      group = "+",
      ellipsis = "…",
      mappings = true, -- show icon mappings
      rules = false, -- use default icon rules
      colors = true, -- use colors for icons
      keys = {
        Up = " ",
        Down = " ",
        Left = " ",
        Right = " ",
        C = "󰘴 ",
        M = "󰘵 ",
        D = "󰘳 ",
        S = "󰘶 ",
        CR = "󰌑 ",
        Esc = "󱊷 ",
        ScrollWheelDown = "󱕐 ",
        ScrollWheelUp = "󱕑 ",
        NL = "󰌑 ",
        BS = "󰁮",
        Space = "󱁐 ",
        Tab = "󰌒 ",
        F1 = "󱊫",
        F2 = "󱊬",
        F3 = "󱊭",
        F4 = "󱊮",
        F5 = "󱊯",
        F6 = "󱊰",
        F7 = "󱊱",
        F8 = "󱊲",
        F9 = "󱊳",
        F10 = "󱊴",
        F11 = "󱊵",
        F12 = "󱊶",
      },
    },

    -- New v3 syntax for window
    win = {
      border = "rounded", -- none, single, double, shadow, rounded
      padding = { 1, 2 }, -- top, right, bottom, left
      wo = {
        winblend = 0, -- transparency
      },
    },

    layout = {
      height = { min = 4, max = 25 },
      width = { min = 20, max = 50 },
      spacing = 3,
      align = "left",
    },

    -- New v3 syntax for filtering
    filter = function(mapping)
      -- Return true to show the mapping, false to hide it
      return true
    end,

    -- Replaced ignore_missing and hidden with show options
    show_help = true, -- show help message on the command line
    show_keys = true, -- show the currently pressed key and its label

    -- Trigger configuration
    triggers = {
      { "<leader>", mode = { "n", "v" } },
    },
  },

  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)

    -- Register all groups
    wk.add({
      { "<leader>b", group = "Buffer" },
      { "<leader>d", group = "Debug" },
      { "<leader>f", group = "Find" },
      { "<leader>g", group = "Git" },
      { "<leader>h", group = "Git Hunk" },
      { "<leader>k", group = "Kanagawa Theme" },
      { "<leader>l", group = "LSP" },
      { "<leader>p", group = "UV/Python" },
      { "<leader>s", group = "Spell/Search" },
      { "<leader>t", group = "Test/Toggle/TODO" },
      { "<leader>u", group = "UI" },
    })
  end,

  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
