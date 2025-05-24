return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      local on_attach = function(client, bufnr)
        local opts = { noremap = true, silent = true }
        -- Go To Definition: Jumps to the primary definition
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
        -- Go To Declaration: Jumps to the declaration (might be different from definition in some languages/cases)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
        -- Go To Implementation: Jumps to implementation(s) of an interface/method
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
        -- Go To References: Lists all references to the symbol
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
        -- Hover: Shows type information and docstrings (Pyright provides this)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>h", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
        -- Rename: Renames the symbol across the project/scope
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
        -- Code Actions: Shows available actions (like Organize Imports from Ruff)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "v", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts) -- Also in visual mode
        -- Diagnostics mappings (helpful for seeing errors/warnings)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "[j", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
        if client.name == "ruff" then
          client.server_capabilities.hoverProvider = false
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ client_id = client.id })
            end,
          })
        end
      end
      lspconfig.pyright.setup({
        on_attach = on_attach,
        offset_encoding = "utf-8",
        settings = {
          pyright = {
            disableOrganizeImports = true,
            typeCheckingMode = "strict",
          },
        },
      })
      lspconfig.ruff.setup({
        on_attach = on_attach,
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
        on_attach = on_attach,
        filetypes = { "toml" },
        settings = {
          indent_tables = true,
        }
      })
      lspconfig.html.setup({
        on_attach = on_attach,
        cmd = { "html-languageserver", "--stdio" },
        filetypes = {"html", "htm", "phtml", "xhtml", "djangohtml", "jinja" },
      })
      lspconfig.cssls.setup({
        on_attach = on_attach,
        cmd = { "css-languageserver", "--stdio" },
        filetypes = {"css", "scss", "less", "djangohtml", "jinja" },
      })
      lspconfig.emmet_ls.setup({
        on_attach = on_attach,
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
          "djangohtml",
          "jinja",
        },
      })
      lspconfig.jsonls.setup({
        on_attach = on_attach,
        filetypes = { "json", "jsonc" },
        settings = {
          json = {
            schemas = require("lspconfig/util").schemas,
          },
        },
      })
    end,
  },
}
