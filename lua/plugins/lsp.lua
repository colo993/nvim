local lsp_handlers = require("user.lsp_handlers")

return {
  -- Mason core
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },

  -- Mason LSP bridge
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "pyright",
          "ruff",
          "taplo",
          "jsonls",
          "html",
          "cssls",
          "emmet_ls",
          "lua_ls",
        },
        automatic_installation = true,
      })
    end,
  },

  -- LSP Config
  {
    "neovim/nvim-lspconfig",
    dependencies = { "mason-lspconfig.nvim" },
    config = function()
      local util = require("lspconfig.util")

      --Lua Language Server
      vim.lsp.enable("lua_ls", {
        on_attach = lsp_handlers.on_attach,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })

      -- Python: Pyright
      vim.lsp.enable("pyright", {
        on_attach = lsp_handlers.on_attach,
        offsetEncoding = "utf-8",
        settings = {
          pyright = {
            disableOrganizeImports = true,
          },
          python = {
            analysis = {
              typeCheckingMode = "basic",
            },
          },
        },
        root_dir = function(fname)
          return util.root_pattern("pyproject.toml", ".git")(fname)
        end,
      })

      -- Python: Ruff
      vim.lsp.enable("ruff", {
        on_attach = lsp_handlers.on_attach,
        offsetEncoding = "utf-8",
        init_options = {
          settings = {
            logLevel = "warn",
          },
        },
        root_dir = function(fname)
          return util.root_pattern("pyproject.toml", ".git")(fname)
        end,
      })

      -- TOML: Taplo
      vim.lsp.enable("taplo", {
        on_attach = lsp_handlers.on_attach,
        filetypes = { "toml" },
        settings = {
          evenBetterToml = {
            schema = {
              enabled = true,
            },
          },
        },
      })

      -- JSON
      vim.lsp.enable("jsonls", {
        on_attach = lsp_handlers.on_attach,
        filetypes = { "json", "jsonc" },
        settings = {
          json = {
            schemas = util.default_schemas,
            validate = { enable = true },
          },
        },
      })

      -- HTML
      vim.lsp.enable("html", {
        on_attach = lsp_handlers.on_attach,
        filetypes = { "html", "htm", "phtml", "xhtml", "htmldjango", "jinja" },
        init_options = {
          provideFormatter = true,
          embeddedLanguages = {
            css = true,
            javascript = true,
          },
        },
      })

      -- CSS
      vim.lsp.enable("cssls", {
        on_attach = lsp_handlers.on_attach,
        filetypes = { "css", "scss", "less", "htmldjango", "jinja" },
      })

      -- Emmet
      vim.lsp.enable("emmet_ls", {
        on_attach = lsp_handlers.on_attach,
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
