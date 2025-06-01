local lsp_handlers = require("user.lsp_handlers")

return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.pyright.setup({
        on_attach = lsp_handlers.on_attach,
        offset_encoding = "utf-8",
        settings = {
          pyright = {
            disableOrganizeImports = true,
            typeCheckingMode = "basic",
          },
        },
      })
      lspconfig.ruff.setup({
        on_attach = lsp_handlers.on_attach,
        offset_encoding = "utf-8",
        root_dir = (function()
          local root = lspconfig.util.root_pattern("pyproject.toml", ".git")(bufnr)
          local abs_root = root and vim.fn.fnamemodify(root, ":p") or nil -- provide absolute project's path to ruff config
          return abs_root
        end)(),
        init_options = {
          settings = {
            logLevel = "warn",
          },
        },
      })
      lspconfig.taplo.setup({
        on_attach = lsp_handlers.on_attach,
        filetypes = { "toml" },
        settings = {
          indent_tables = true,
        },
      })
      lspconfig.jsonls.setup({
        on_attach = lsp_handlers.on_attach,
        filetypes = { "json", "jsonc" },
        cmd = { "vscode-json-languageserver", "--stdio" },
        settings = {
          json = {
            schemas = require("lspconfig/util").schemas,
          },
        },
      })
      lspconfig.html.setup({
        on_attach = lsp_handlers.on_attach,
        cmd = { "html-languageserver", "--stdio" },
        filetypes = { "html", "htm", "phtml", "xhtml", "htmldjango", "jinja" },
        init_options = {
          provideFormatter = true,
          embeddedLanguages = {
            css = true,
            javascript = true,
          },
        },
        on_init = function(client)
          client.server_capabilities.documentFormattingProvider = true
          client.server_capabilities.documentRangeFormattingProvider = true
        end,
      })
      lspconfig.cssls.setup({
        on_attach = lsp_handlers.on_attach,
        cmd = { "css-languageserver", "--stdio" },
        filetypes = { "css", "scss", "less", "htmldjango", "jinja" },
      })
      lspconfig.emmet_ls.setup({
        on_attach = lsp_handlers.on_attach,
        cmd = { "emmet-language-server", "--stdio" },
        filetypes = {
          "html",
          "htm",
          "css",
          "scss",
          "less",
          "javascriptreact",
          "typescriptreact",
          "vue",
          "svelte",
          "astro",
          "php",
          "twig",
          "erb",
          "hbs",
          "htmldjango",
          "jinja",
        },
      })
    end,
  },
}
