---
return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {
			options = {
				theme = "auto",
				icons_enabled = true,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = {
					{ "mode", fmt = function(str) return str:sub(1, 1) end },
				},
				lualine_b = { "branch", "diff" },
				lualine_c = { "filename", "diagnostics" },
				lualine_x = {
					function()
						local node = require("nvim-treesitter.ts_utils").get_node_at_cursor()
						if node == nil then return nil end
						return "[" .. node:type() .. "]"
					end,
					"filetype",
					"encoding",
					"fileformat",
				},
				lualine_y = { "selectioncount", "searchcount", "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = { "branch", "diff" },
				lualine_c = { "filename", "diagnostics" },
				lualine_x = {
					{ "filetype", icons_enabled = false },
					"encoding",
					"fileformat",
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = { "neo-tree", "trouble" },
		},
	},

	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		opts = {
			current_line_blame = true,
			current_line_blame_formatter = function(_, info)
				local time = os.date("%Y-%m-%d", info.author_time)
				local username = (info.author_mail or ""):match("<(.-)@")
				local line = " " .. username .. "@ " .. time .. ": " .. info.summary

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

	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle" },
		keys = {
			{ "<leader>xx", function() require("trouble").toggle() end, desc = "[Trouble] Toggle" },
			{
				"<leader>xw",
				function() require("trouble").toggle("workspace_diagnostics") end,
				desc = "[Trouble] Workspace diagnostics",
			},
			{
				"<leader>xd",
				function() require("trouble").toggle("document_diagnostics") end,
				desc = "[Trouble] Document diagnostics",
			},
			{
				"<leader>xq",
				function() require("trouble").toggle("quickfix") end,
				desc = "[Trouble] Quickfix list",
			},
			{
				"<leader>xl",
				function() require("trouble").toggle("loclist") end,
				desc = "[Trouble] Location list",
			},
			--{ "gR", function() require("trouble").toggle("lsp_references") end },
		},
		event = { "LspAttach" },
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function() end,
	},

	{
		"folke/zen-mode.nvim",
		cmd = { "ZenMode" },
		keys = {
			{ "<leader>z", function() require("zen-mode").toggle() end, desc = "[ZenMode] Toggle" },
		},
		opts = {
			options = {
				signcolumn = "no",
				number = false,
			},
		},
	},

	{
		"vladdoster/remember.nvim",
		lazy = false,
		config = true,
	},

	{ "kevinhwang91/nvim-bqf", ft = "qf" },

	{
		"nvim-treesitter/playground",
		dependencies = "nvim-treesitter/nvim-treesitter",
		cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
		config = function()
			---@diagnostic disable-next-line missing-fields
			require("nvim-treesitter.configs").setup({
				playground = { enable = true },
			})
		end,
	},
}
