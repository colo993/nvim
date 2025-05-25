local lsp_handlers = require("user.lsp_handlers")

return {
	"nvimtools/none-ls.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local null_ls = require("null-ls")
		local b = null_ls.builtins
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.completion.spell,
				b.formatting.prettier.with({
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
					},
				}),
			},
			on_attach = lsp_handlers.on_attach,
		})
	end,
}
