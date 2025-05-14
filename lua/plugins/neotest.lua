return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
	},
	{
		"nvim-neotest/neotest-python",
		config = function()
			local neotest = require("neotest")
			local neotest_python = require("neotest-python")
			neotest.setup({
				adapters = {
					neotest_python({
						dap = { justMyCode = false },
						args = { "--log-level", "DEBUG" },
						runner = "pytest",
						python = ".venv/bin/python",
					}),
				},
			})
		end,
	},
}
