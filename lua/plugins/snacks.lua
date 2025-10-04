return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    -- Disable dashboard since you use alpha
    dashboard = { enabled = false },

    -- Better notifications
    notifier = {
      enabled = true,
      timeout = 3000,
    },

    -- Lazygit integration (complements your fugitive + gitsigns)
    lazygit = {
      enabled = true,
      configure = true,
    },

    -- Smart buffer deletion (preserves window layout)
    bufdelete = {
      enabled = true,
    },

    -- Git browse (open file/line on GitHub)
    gitbrowse = {
      enabled = true,
    },

    -- Smooth scrolling
    scroll = {
      enabled = true,
    },

    -- Better quickfix/loclist
    quickfile = {
      enabled = true,
    },
  },
  keys = {
    {
      "<leader>gg",
      function()
        require("snacks").lazygit()
      end,
      desc = "Lazygit",
    },
    {
      "<leader>gb",
      function()
        require("snacks").gitbrowse()
      end,
      desc = "Git browse",
    },
    {
      "<leader>bd",
      function()
        require("snacks").bufdelete()
      end,
      desc = "Delete buffer",
    },
    {
      "<leader>un",
      function()
        require("snacks").notifier.hide()
      end,
      desc = "Dismiss notifications",
    },
  },
}
