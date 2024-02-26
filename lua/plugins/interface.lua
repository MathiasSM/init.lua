return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
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
						local node =
							require("nvim-treesitter.ts_utils").get_node_at_cursor()
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
			extensions = { "neo-tree", "fzf", "fugitive", "lazy" },
		},
	},

	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		config = true,
	},

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			require("which-key").setup({ window = { border = "single" } })
			require("which-key").register({
				["<leader>"] = {
					name = "Personal mappings",
				},
				["<space>"] = {
					name = "Diagnostics & LSP",
					["w"] = {
						name = "Workspaces",
					},
					["h"] = {
						name = "Haskell",
					},
				},
				["g"] = {
					name = "Go to (mostly)",
				},
			})
		end,
	},

	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle" },
		event = { "LspAttach" },
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = true,
	},

	{
		"folke/zen-mode.nvim",
		cmd = { "ZenMode" },
		-- Changing config not working
	},

	{
		"vladdoster/remember.nvim",
		lazy = false,
		config = true,
	},
}
