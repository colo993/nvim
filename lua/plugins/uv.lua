return {
  "benomahony/uv.nvim",
  -- Only load for Python files to improve startup time
  ft = { "python" },
  dependencies = { "nvim-lua/plenary.nvim" },
  -- Optional: If you want to use a nice UI for selection
  -- dependencies = { "nvim-telescope/telescope.nvim" },
  config = function()
    require("uv").setup({
      -- By default, uv.nvim will find the uv executable in your PATH.
      -- If you want the plugin to automatically install it for you,
      -- you can specify a path.
      -- For Mason:
      -- uv_path = vim.fn.stdpath("data") .. "/mason/bin/uv",

      -- Or let the plugin manage it automatically (recommended for ease of use)
      -- This requires `curl` and `tar` on Linux/macOS.
      ensure_installed = true,

      -- Which backend to use for UI.
      -- Can be "native" (vim.ui.select), "telescope", or "fzf-lua"
      backend = "native",

      -- By default, the venv is created in `.venv` in the project root.
      -- You can change that here if needed.
      -- venv_dir = ".venv",
    })
  end,
  -- === KEYMAPS ARE ESSENTIAL ===
  -- This is where the plugin becomes useful.
  keys = {
    {
      "<leader>pv",
      function()
        require("uv").venv()
      end,
      desc = "[P]ython [V]env Create/Select",
    },
    {
      "<leader>pi",
      function()
        require("uv").install()
      end,
      desc = "[P]ython [I]nstall Package",
    },
    {
      "<leader>pI",
      function()
        require("uv").install_from_file()
      end,
      desc = "[P]ython [I]nstall from requirements.txt",
    },
    {
      "<leader>pu",
      function()
        require("uv").uninstall()
      end,
      desc = "[P]ython [U]ninstall Package",
    },
    {
      "<leader>ps",
      function()
        require("uv").sync()
      end,
      desc = "[P]ython [S]ync from requirements.txt",
    },
    {
      "<leader>pf",
      function()
        require("uv").freeze()
      end,
      desc = "[P]ython [F]reeze to requirements.txt",
    },
    {
      "<leader>pl",
      function()
        require("uv").list_packages()
      end,
      desc = "[P]ython [L]ist Installed Packages",
    },
  },
}
