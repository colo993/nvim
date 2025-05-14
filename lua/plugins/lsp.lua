return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			local on_attach = function(client, bufnr)
				local opts = { noremap = true, silent = true }
				vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>h", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
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
		end,
	},
}
