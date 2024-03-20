return {
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
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
}
