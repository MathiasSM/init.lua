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
						reveal = true,
					})
				end,
				desc = "[Neotree] Files (project dir)",
			},
		},
		init = function()
			vim.api.nvim_create_autocmd("BufEnter", {
				group = vim.api.nvim_create_augroup(
					"NeoTreeInit",
					{ clear = true }
				),
				callback = function()
					local f = vim.fn.expand("%:p")
					if vim.fn.isdirectory(f) ~= 0 then
						vim.cmd("Neotree current dir=" .. f)
						vim.api.nvim_clear_autocmds({ group = "NeoTreeInit" })
					end
				end,
			})
		end,
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
					mappings = {
						["f"] = function()
							vim.api.nvim_exec2(
								"Neotree focus filesystem left",
								{}
							)
						end,
						["b"] = function()
							vim.api.nvim_exec2("Neotree focus buffers left", {})
						end,
						["g"] = function()
							vim.api.nvim_exec2(
								"Neotree focus git_status left",
								{}
							)
						end,
						["s"] = function()
							vim.api.nvim_exec2(
								"Neotree focus document_symbols left",
								{}
							)
						end,
					},
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
					hijack_netrw_behavior = "open_current",
					filtered_items = {
						hide_dotfiles = false,
						hide_gitignored = false,
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
									vim.print(path)
									return {
										text = string.format(" ⥤ %d", i),
										highlight = config.highlight
											or "NeoTreeDirectoryIcon",
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

	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		cmd = { "Harpoon" },
		keys = {
			"<C-e>", -- Defined in config
			{
				"<leader>`",
				function() require("harpoon"):list():append() end,
				desc = "[Harpoon] Add current to list",
			},
			{
				"<leader>~",
				function() require("harpoon"):list():remove() end,
				desc = "[Harpoon] Remove current from list",
			},

			{
				"<leader>1",
				function() require("harpoon"):list():select(1) end,
				desc = "[Harpoon] Go to 1",
			},
			{
				"<leader>2",
				function() require("harpoon"):list():select(2) end,
				desc = "[Harpoon] Go to 2",
			},
			{
				"<leader>3",
				function() require("harpoon"):list():select(3) end,
				desc = "[Harpoon] Go to 3",
			},
			{
				"<leader>4",
				function() require("harpoon"):list():select(4) end,
				desc = "[Harpoon] Go to 4",
			},

			-- Toggle previous & next buffers stored within harpoon list
			{
				"<leader>-",
				function() require("harpoon"):list():prev() end,
				desc = "[Harpoon] Go to next",
			},
			{
				"<leader>=",
				function() require("harpoon"):list():next() end,
				desc = "[Harpoon] Go to next",
			},
		},
		config = function()
			-- Directly taken from docs
			local harpoon = require("harpoon")
			harpoon:setup({})
			-- Configure telescope UI
			local conf = require("telescope.config").values
			local function toggle_telescope(harpoon_files)
				local file_paths = {}
				for _, item in ipairs(harpoon_files.items) do
					table.insert(file_paths, item.value)
				end

				require("telescope.pickers")
					.new({}, {
						prompt_title = "Harpoon",
						finder = require("telescope.finders").new_table({
							results = file_paths,
						}),
						previewer = conf.file_previewer({}),
						sorter = conf.generic_sorter({}),
					})
					:find()
			end

			vim.keymap.set(
				"n",
				"<C-e>",
				function() toggle_telescope(harpoon:list()) end,
				{ desc = "[Harpoon] Open list" }
			)
		end,
	},

	"mateuszwieloch/automkdir.nvim",
}
