local M = {}
M.on_attach = function(client, bufnr)
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
	vim.api.nvim_buf_set_keymap(
		bufnr,
		"n",
		"<leader>fm",
		"<cmd>lua "
			.. "local current_bufnr = vim.api.nvim_get_current_buf(); "
			.. "local buftype = vim.api.nvim_buf_get_option(current_bufnr, 'filetype'); "
			.. "if buftype == 'python' then "
			.. "  vim.lsp.buf.format({ bufnr = current_bufnr, async = true, filter = function(cl) return cl.name == 'ruff' and cl.supports_method('textDocument/formatting') end }) "
			.. "elseif buftype == 'html' or buftype == 'htm' or buftype == 'htmldjango' then "
			.. "  vim.lsp.buf.format({ bufnr = current_bufnr, async = true, filter = function(cl) return cl.name == 'null-ls' and cl.supports_method('textDocument/formatting') end }) "
			.. "elseif buftype == 'toml' or buftype == 'yaml' or buftype == 'yml' then "
			.. "  vim.lsp.buf.format({ bufnr = current_bufnr, async = true, filter = function(cl) return cl.name == 'taplo' and cl.supports_method('textDocument/formatting') end }) "
			.. "elseif buftype == 'toml' or buftype == 'yaml' or buftype == 'yml' then "
			.. "  vim.lsp.buf.format({ bufnr = current_bufnr, async = true, filter = function(cl) return cl.name == 'taplo' and cl.supports_method('textDocument/formatting') end }) "
			.. "else "
			.. "  vim.lsp.buf.format({ bufnr = current_bufnr, async = true, filter = function(cl) return cl.name == 'null-ls' and cl.supports_method('textDocument/formatting') end }) "
			.. "end<CR>",
		opts
	)
	if client.name == "ruff" then
		client.server_capabilities.hoverProvider = false
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({ client_id = client.id })
			end,
		})
	end
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = vim.api.nvim_create_augroup("LspFormatOnSave", { clear = true }),
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({ bufnr = bufnr, async = false })
			end,
		})
	end
end

return M
