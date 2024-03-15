---
return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			local function is_not_unicode() return "utf-8" ~= vim.opt.fileencoding:get() end
			local short_mode = { "mode", fmt = function(str) return str:sub(1, 1) end }
			local filename = {
				"filename",
				newfile_status = true,
				path = 1,
				separator = "",
			}
			local encoding = { "encoding", cond = is_not_unicode }
			local treesitter_node = {
				function()
					local node = require("nvim-treesitter.ts_utils").get_node_at_cursor()
					if node == nil then return nil end
					return "[" .. node:type() .. "]"
				end,
				color = "lualine_c_inactive",
			}
			require("lualine").setup({
				options = {
					theme = "auto",
					icons_enabled = true,
				},
				sections = {
					lualine_a = {
						short_mode,
					},
					lualine_b = { "branch", "diff" },
					lualine_c = {
						filename,
						treesitter_node,
					},
					lualine_x = {
						"diagnostics",
						"filetype",
						encoding,
						"fileformat",
					},
					lualine_y = { "selectioncount", "searchcount", "progress" },
					lualine_z = { "location" },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = { "branch", "diff" },
					lualine_c = { filename, "diagnostics" },
					lualine_x = {
						{ "filetype", icons_enabled = false },
						"encoding",
						"fileformat",
					},
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
				tabline = {
					-- NOTE: If I ever need a tabbar:
					-- lualine_b = {{ "tabs", mode = 2, path = 1, separator = {left='',right=''}}},
				},
				winbar = {},
				inactive_winbar = {},
				extensions = {
					"fugitive",
					"lazy",
					"man",
					"mason",
					"neo-tree",
					"nvim-dap-ui",
					"oil",
					"quickfix",
					"trouble",
				},
			})
		end,
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
