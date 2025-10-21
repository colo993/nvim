return {
  "stevearc/conform.nvim",
  event = { "BufReadPost", "BufNewFile" },
  keys = {
    {
      "<leader>fm",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = { "n", "v" },
      desc = "Format buffer",
    },
  },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        python = { "ruff_organize_imports", "ruff_fix", "ruff_format" },
        html = { "prettier" },
        css = { "prettier" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        toml = { "taplo" },
        lua = { "stylua" },
      },
      --format_on_save = {
      --  timeout_ms = 500,
      --  lsp_fallback = true,
      --},
    })
  end,
}
