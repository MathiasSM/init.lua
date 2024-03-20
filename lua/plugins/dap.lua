--- Debugging configuration (`nvim-dap`)
--
-- Configuration and mappings subtly copied from lazyvim distro
--
-- @module debugging

return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {"rcarriga/nvim-dap-ui"},
		keys = {
			{
				"<leader>bB",
				function()
					local cond = vim.fn.input("Breakpoint condition: ")
					local hits = vim.fn.input("Num. hits condition: ")
					local logs = vim.fn.input("Log message: ")
					cond = cond == "" and nil or cond
					hits = hits == "" and nil or tostring(hits)
					logs = logs == "" and nil or logs
					require("dap").set_breakpoint(cond, hits, logs)
				end,
				desc = "[Debug] Set Breakpoint",
			},
			{
				"<leader>bb",
				function() require("dap").toggle_breakpoint() end,
				desc = "[Debug] Toggle Breakpoint",
			},
			{ "<leader>bc", function() require("dap").continue() end, desc = "[Debug] Continue" },
			{
				"<leader>bC",
				function() require("dap").run_to_cursor() end,
				desc = "[Debug] Run to Cursor",
			},
			{
				"<leader>bg",
				function() require("dap").goto_() end,
				desc = "[Debug] Go to line (no execute)",
			},
			{ "<leader>bi", function() require("dap").step_into() end, desc = "[Debug] Step Into" },
			{ "<leader>bj", function() require("dap").down() end, desc = "[Debug] Down" },
			{ "<leader>bk", function() require("dap").up() end, desc = "[Debug] Up" },
			{ "<leader>bl", function() require("dap").run_last() end, desc = "[Debug] Run Last" },
			{ "<leader>bo", function() require("dap").step_out() end, desc = "[Debug] Step Out" },
			{ "<leader>bO", function() require("dap").step_over() end, desc = "[Debug] Step Over" },
			{ "<leader>bp", function() require("dap").pause() end, desc = "[Debug] Pause" },
			{
				"<leader>br",
				function() require("dap").repl.toggle() end,
				desc = "[Debug] Toggle REPL",
			},
			{ "<leader>bs", function() require("dap").session() end, desc = "[Debug] Session" },
			{ "<leader>bt", function() require("dap").terminate() end, desc = "[Debug] Terminate" },
			{
				"<leader>bw",
				function() require("dap.ui.widgets").hover() end,
				desc = "[Debug] Widgets",
			},
		},
		config = function(_, opts)
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup(opts)
			dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open({}) end
			dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close({}) end
			dap.listeners.before.event_exited["dapui_config"] = function() dapui.close({}) end
		end,
	},

	{
		"ofirgall/goto-breakpoints.nvim",
		dependencies = { "mfussenegger/nvim-dap" },
		keys = {
			{
				"[b",
				function() require("goto-breakpoints").next() end,
				desc = "[Debug] Prev breakpoint",
			},
			{
				"]b",
				function() require("goto-breakpoints").prev() end,
				desc = "[Debug] Next breakpoint",
			},
			{
				"]S",
				function() require("goto-breakpoints").stopped() end,
				desc = "[Debug] Current stopped line",
			},
		},
	},
}
