return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		local neotree = require("neo-tree")
		neotree.setup({
			filesystem = {
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
				},
			},
		})
		vim.keymap.set("n", "\\", ":Neotree filesystem reveal left<CR>", {})
		vim.keymap.set("n", "<leader>bf", ":Neotree buffers reveal float<CR>", {})
	end,
}
