return {
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		opts = {
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

			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns
				print("?")
				print(gs)

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end
				local function nmap(l, r, opts) return map("n", l, r, opts) end
				local function vmap(l, r, opts) return map("v", l, r, opts) end

				-- Navigation
				nmap("]c", function()
					if vim.wo.diff then return "]c" end
					vim.schedule(function() gs.next_hunk() end)
					return "<Ignore>"
				end, { expr = true, desc = "[Git] Next hunk (change)" })

				nmap("[c", function()
					if vim.wo.diff then return "[c" end
					vim.schedule(function() gs.prev_hunk() end)
					return "<Ignore>"
				end, { expr = true, desc = "[Git] Previous hunk (change)" })

				-- Actions
				nmap("<leader>hs", gs.stage_hunk, { desc = "[Git] Stage hunk" })
				vmap(
					"<leader>hs",
					function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
					{ desc = "[Git] Stage hunk" }
				)

				nmap("<leader>hr", gs.reset_hunk, { desc = "[Git] Reset hunk" })
				vmap(
					"<leader>hr",
					function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
					{ desc = "[Git] Reset hunk" }
				)

				nmap("<leader>hu", gs.undo_stage_hunk, { desc = "[Git] Undo stage hunk" })

				nmap("<leader>hS", gs.stage_buffer, { desc = "[Git] Stage buffer" })
				nmap("<leader>hR", gs.reset_buffer, { desc = "[Git] Reset buffer" })

				nmap("<leader>hp", gs.preview_hunk, { desc = "[Git] Preview hunk" })

				nmap(
					"<leader>gB",
					function() gs.blame_line({ full = true, ignore_whitespace = true }) end,
					{ desc = "[Git] Full blame on float" }
				)
				nmap("<leader>gb", gs.toggle_current_line_blame, { desc = "[Git] Blame (toggle)" })
				nmap("<leader>gd", gs.diffthis, { desc = "[Git] Gitsigns diffthis" })
			end,
		},
	},
}
