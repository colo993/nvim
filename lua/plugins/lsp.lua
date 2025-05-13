return {
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "pyright", 'ruff' },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = { "williamboman/mason-lspconfig.nvim" },
        config = function()
            local lspconfig = require("lspconfig")
            local on_attach = function(client, bufnr)
              if client.name == 'ruff' then
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
              settings = {
                pyright = {
                  disableOrganizeImports = true,
                },
              },
            })
            lspconfig.ruff.setup({
              on_attach = on_attach,
              root_dir = lspconfig.util.root_pattern("pyproject.toml", ".git")(bufnr),
            })
        end,
    },
}

