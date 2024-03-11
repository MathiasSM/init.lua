--- Debugging configuration (`nvim-dap`)
-- TODO: Confirm it works
--
-- @module debugging

return {
	{
		"mfussenegger/nvim-dap",
		lazy = true,
	},

	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"theHamsta/nvim-dap-virtual-text",
		},
		cmd = {
			"Debug",
			"TestNearestDebug",
			"TestFileDebug",
		},
		-- TODO: Setup commands
		config = true,
	},

	{
		"theHamsta/nvim-dap-virtual-text",
		dependencies = {
			"theHamsta/nvim-dap-virtual-text",
			"nvim-treesitter/nvim-treesitter",
		},
		lazy = true,
		config = true,
	},

	-- Configured alongside other LSPs
	"mfussenegger/nvim-jdtls",
	"mrcjkb/haskell-tools.nvim",
}
