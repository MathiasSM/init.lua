
return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		cmd = "Neotree",
		keys = {
			{
				"<leader>n",
				function()
					require("neo-tree.command").execute({
						toggle = true,
						source = "filesystem",
						position = "left",
						reveal_force_cwd = true,
						reveal = true,
					})
				end,
				desc = "[Neotree] Files (project dir)",
			},
		},
		config = function()
			require("neo-tree").setup({
				sources = {
					"filesystem",
					"buffers",
					"git_status",
					"document_symbols",
				},
				default_source = "last",
				auto_clean_after_session_restore = false,
				open_files_do_not_replace_types = {
					"terminal",
					"Trouble",
					"qf",
					"edgy",
					"help",
					"harpoon",
				},
				source_selector = {
					winbar = true,
					statusline = false,
					tabs_layout = "start",
					sources = {
						{ source = "filesystem" },
						{ source = "buffers" },
						{ source = "git_status" },
						{ source = "document_symbols" },
					},
				},
				window = {
					width = 44,
				},
				default_component_configs = {
					name = {
						trailing_slash = true,
						highlight_opened_files = true,
					},
					created = {
						enabled = true, -- Defaults to false
						required_width = 120,
					},
				},
				filesystem = {
					renderers = {
						file = {
							{ "icon" },
							{
								"container",
								content = {
									{
										"name",
										zindex = 10,
									},
									{
										"symlink_target",
										zindex = 10,
										highlight = "NeoTreeSymbolicLinkTarget",
									},
									{ "clipboard", zindex = 10 },
									{ "bufnr", zindex = 10 },
									{
										"harpoon_index",
										zindex = 10,
										align = "right",
									},
									{
										"modified",
										zindex = 20,
										align = "right",
									},
									{
										"diagnostics",
										zindex = 20,
										align = "right",
									},
									{
										"git_status",
										zindex = 10,
										align = "right",
									},
									{
										"file_size",
										zindex = 10,
										align = "right",
									},
									{ "type", zindex = 10, align = "right" },
									{
										"last_modified",
										zindex = 10,
										align = "right",
									},
									{ "created", zindex = 10, align = "right" },
								},
							},
						},
					},
					components = {
						harpoon_index = function(config, node, _)
							local harpoon_list = require("harpoon"):list()
							local path = node:get_id()
							local harpoon_key = vim.loop.cwd()

							for i, item in ipairs(harpoon_list.items) do
								local value = item.value
								if string.sub(item.value, 1, 1) ~= "/" then
									value = harpoon_key .. "/" .. item.value
								end

								if value == path then
									return {
										text = string.format(" ⥤ %d", i),
										highlight = config.highlight or "NeoTreeDirectoryIcon",
									}
								end
							end
							return {}
						end,
					},
				},
			})
		end,
	},
}
