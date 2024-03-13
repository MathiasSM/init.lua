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

	{
		"Weissle/persistent-breakpoints.nvim",
		cmd = { "PBToggleBreakpoint", "PBSetConditionalBreakpoint", "PBClearAllBreakpoints" },
		config = function()
			require("persistent-breakpoints").setup({
				load_breakpoints_event = { "BufReadPost" },
			})
		end,
	},

	{
		"ofirgall/goto-breakpoints.nvim",
		dependencies = {"mfussenegger/nvim-dap"},
		keys = { "]b", "[b", "]S" },
		config = function()
			vim.keymap.set("n", "]d", require("goto-breakpoints").next, {desc = "[Debug] Prev breakpoint"})
			vim.keymap.set("n", "[d", require("goto-breakpoints").prev, {desc = "[Debug] Next breakpoint"})
			vim.keymap.set("n", "]S", require("goto-breakpoints").stopped, {desc = "[Debug] Current stopped line"})
		end,
	},

	-- Configured alongside other LSPs
	"mfussenegger/nvim-jdtls",
	"mrcjkb/haskell-tools.nvim",
}
