return {
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		keys = {
			-- Movement
			{
				"]c",
				function()
					if vim.wo.diff then return "]c" end
					vim.schedule(function() require("gitsigns").next_hunk() end)
					return "<Ignore>"
				end,
				expr = true,
				desc = "[Git] Next hunk (change)",
			},

			{
				"[c",
				function()
					if vim.wo.diff then return "[c" end
					vim.schedule(function() require("gitsigns").prev_hunk() end)
					return "<Ignore>"
				end,
				expr = true,
				desc = "[Git] Previous hunk (change)",
			},

			-- Actions
			{
				"<leader>hs",
				function() require("gitsigns").stage_hunk() end,
				desc = "[Git] Stage hunk",
			},
			{
				mode = "v",
				"<leader>hs",
				function()
					require("gitsigns").stage_hunk({
						vim.fn.line("."),
						vim.fn.line("v"),
					})
				end,
				desc = "[Git] Stage hunk",
			},

			{
				"<leader>hr",
				function() require("gitsigns").reset_hunk() end,
				desc = "[Git] Reset hunk",
			},
			{
				mode = "v",
				"<leader>hr",
				function()
					require("gitsigns").reset_hunk({
						vim.fn.line("."),
						vim.fn.line("v"),
					})
				end,
				desc = "[Git] Reset hunk",
			},

			{
				"<leader>hu",
				function() require("gitsigns").undo_stage_hunk() end,
				desc = "[Git] Undo stage hunk",
			},

			{
				"<leader>hS",
				function() require("gitsigns").stage_buffer() end,
				desc = "[Git] Stage buffer",
			},
			{
				"<leader>hR",
				function() require("gitsigns").reset_buffer() end,
				desc = "[Git] Reset buffer",
			},

			{
				"<leader>hp",
				function() require("gitsigns").preview_hunk() end,
				desc = "[Git] Preview hunk",
			},

			{
				"<leader>gB",
				function()
					require("gitsigns").blame_line({ full = true, ignore_whitespace = true })
				end,
				desc = "[Git] Full blame on float",
			},
			{
				"<leader>gb",
				function() require("gitsigns").toggle_current_line_blame() end,
				desc = "[Git] Blame (toggle)",
			},
			{
				"<leader>gd",
				function() require("gitsigns").diffthis() end,
				desc = "[Git] Gitsigns diffthis",
			},
		},
		opts = {
			attach_to_untracked = true,
			current_line_blame = false,
			current_line_blame_formatter = function(_, info)
				local time = os.date("%Y-%m-%d", info.author_time)
				local username = (info.author_mail or ""):match("<(.-)@")
				local line = " " .. username .. "@ " .. time .. ": " .. (info.summary or "")
				return {
					{
						line,
						"GitSignsCurrentLineBlame",
					},
				}
			end,
			current_line_blame_opts = {
				virt_text_priority = require("ui_priorities").virtual_text.git_blame,
				ignore_whitespace = true,
			},
		},
	},
}
