local lsp_handlers = require("user.lsp_handlers")

return {
	"nvimtools/none-ls.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local null_ls = require("null-ls")
		local b = null_ls.builtins
		null_ls.setup({
			debug = true,
			offset_encoding = "utf-8",
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.completion.spell,
				b.formatting.prettier.with({
					command = "/home/colo/.nvm/versions/node/v24.1.0/bin/prettier",
					filetypes = {
						"html",
						"htm",
						"css",
						"scss",
						"less",
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
						"vue",
						"json",
						"jsonc",
						"markdown",
						"htmldjango",
					},
				}),
			},
			on_attach = lsp_handlers.on_attach,
		})
	end,
}
