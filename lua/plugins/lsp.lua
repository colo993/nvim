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

  -- Mason tool installer
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason.nvim" },
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "prettier",
          "ruff",
          "taplo",
          "stylua",
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

      -- Lua Language Server
      vim.lsp.config("lua_ls", {
        cmd = { "lua-language-server" },
        filetypes = { "lua" },
        root_markers = {
          ".luarc.json",
          ".luarc.jsonc",
          ".luacheckrc",
          ".stylua.toml",
          "stylua.toml",
          "selene.toml",
          "selene.yml",
          ".git",
        },
        capabilities = vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), {
          textDocument = {
            synchronization = {
              didSave = false, -- Add this line
            },
          },
        }),
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
        handlers = {
          ["textDocument/publishDiagnostics"] = vim.lsp.handlers["textDocument/publishDiagnostics"],
        },
      })

      vim.lsp.config("pyright", {
        cmd = { "pyright-langserver", "--stdio" },
        filetypes = { "python" },
        root_markers = { "pyproject.toml", ".git" },
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
        on_attach = function(client)
          client.server_capabilities.documentFormattingProvider = false
        end,
      })

      vim.lsp.config("ruff", {
        cmd = { "ruff", "server" },
        filetypes = { "python" },
        root_markers = { "pyproject.toml", ".git" },
        init_options = {
          settings = {
            logLevel = "warn",
          },
        },
      })

      vim.lsp.config("taplo", {
        cmd = { "taplo", "lsp", "stdio" },
        filetypes = { "toml" },
        root_markers = { ".git" },
        settings = {
          evenBetterToml = {
            schema = {
              enabled = true,
            },
          },
        },
      })

      vim.lsp.config("jsonls", {
        cmd = { "vscode-json-language-server", "--stdio" },
        filetypes = { "json", "jsonc" },
        root_markers = { ".git" },
        settings = {
          json = {
            schemas = util.default_schemas,
            validate = { enable = true },
          },
        },
      })

      vim.lsp.config("html", {
        cmd = { "vscode-html-language-server", "--stdio" },
        filetypes = { "html", "htm", "phtml", "xhtml", "htmldjango", "jinja" },
        root_markers = { ".git" },
        init_options = {
          provideFormatter = true,
          embeddedLanguages = {
            css = true,
            javascript = true,
          },
        },
      })

      vim.lsp.config("cssls", {
        cmd = { "vscode-css-language-server", "--stdio" },
        filetypes = { "css", "scss", "less", "htmldjango", "jinja" },
        root_markers = { ".git" },
      })

      vim.lsp.config("emmet_ls", {
        cmd = { "emmet-ls", "--stdio" },
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
        root_markers = { ".git" },
      })

      -- Set up autocommand to call on_attach when LSP attaches
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client then
            lsp_handlers.on_attach(client, args.buf)
          end
        end,
      })

      -- Enable LSP servers
      vim.lsp.enable("lua_ls")
      vim.lsp.enable("pyright")
      vim.lsp.enable("ruff")
      vim.lsp.enable("taplo")
      vim.lsp.enable("jsonls")
      vim.lsp.enable("html")
      vim.lsp.enable("cssls")
      vim.lsp.enable("emmet_ls")
    end,
  },
}
