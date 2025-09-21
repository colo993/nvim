local lsp_handlers = require("user.lsp_handlers")

return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.lsp.enable("pyright", {
        on_attach = lsp_handlers.on_attach,
        offset_encoding = "utf-8",
        settings = {
          pyright = {
            disableOrganizeImports = true,
            typeCheckingMode = "basic",
          },
        },
      })
      vim.lsp.enable("ruff", {
        on_attach = lsp_handlers.on_attach,
        offset_encoding = "utf-8",
        root_dir = function(fname)
          local util = require("lspconfig.util")
          return util.root_pattern("pyproject.toml", ".git")(fname)
        end,
        init_options = {
          settings = {
            logLevel = "warn",
          },
        },
      })
      vim.lsp.enable("taplo", {
        on_attach = lsp_handlers.on_attach,
        filetypes = { "toml" },
        settings = {
          indent_tables = true,
        },
      })
      vim.lsp.enable("jsonls", {
        on_attach = lsp_handlers.on_attach,
        filetypes = { "json", "jsonc" },
        cmd = { "vscode-json-languageserver", "--stdio" },
        settings = {
          json = {
            schemas = require("lspconfig/util").schemas,
          },
        },
      })
      vim.lsp.enable("html", {
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
      vim.lsp.enable("cssls", {
        on_attach = lsp_handlers.on_attach,
        cmd = { "css-languageserver", "--stdio" },
        filetypes = { "css", "scss", "less", "htmldjango", "jinja" },
      })
      vim.lsp.enable("emmet_ls", {
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
