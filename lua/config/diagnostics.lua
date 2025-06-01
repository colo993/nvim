vim.diagnostic.config({
	float = {
		source = "always",
		border = "single",
		focusable = false,
	},
	jump = {
		float = false,
		wrap = true,
	},
	severity_sort = false,
	signs = true,
	underline = true,
	update_in_insert = false,
	virtual_lines = false,
	virtual_text = {
		severity_sort = true,
		spacing = 4,
	},
})
