--- Navigation between files and across directories/projects
-- @module navigation

return {
	"mateuszwieloch/automkdir.nvim",

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
		init = function()
			vim.api.nvim_create_autocmd("BufEnter", {
				group = vim.api.nvim_create_augroup("NeoTreeInit", { clear = true }),
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
					hijack_netrw_behavior = "open_current",
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

	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = "Oil",
		keys = {
			{ "<leader>m", "<cmd>Oil --float .<cr>", desc = "[Oil] Open folder float" },
			{ "<leader>M", "<cmd>Oil .<cr>", desc = "[Oil] Open folder" },
		},
		-- init = function()
		-- 	vim.api.nvim_create_autocmd("BufEnter", {
		-- 		group = vim.api.nvim_create_augroup("OilInit", { clear = true }),
		-- 		callback = function()
		-- 			local f = vim.fn.expand("%:p")
		-- 			if vim.fn.isdirectory(f) ~= 0 then
		-- 				vim.cmd("Oil " .. f) -- FIX: Not working
		-- 				vim.api.nvim_clear_autocmds({ group = "OilInit" })
		-- 			end
		-- 		end,
		-- 	})
		-- end,
		opts = {
			-- default_file_explorer = true,
			columns = {
				"icon",
			},
			float = {
				max_width = 60,
				max_height = 40,
			},
			keymaps = {
				["g?"] = "actions.show_help",
				["<CR>"] = "actions.select",
				["o"] = "actions.select",
				["s"] = "actions.select_vsplit",
				["S"] = "actions.select_split",
				["<C-t>"] = "actions.select_tab", -- TODO
				["p"] = "actions.preview",
				["<esc>"] = "actions.close",
				["q"] = "actions.close",
				["r"] = "actions.refresh",
				["R"] = "actions.refresh",
				["-"] = "actions.parent",
				["<del>"] = "actions.parent",
				["_"] = "actions.open_cwd",
				["`"] = "actions.cd",
				["~"] = "actions.tcd",
				["gs"] = "actions.change_sort",
				["gx"] = "actions.open_external",
				["g."] = "actions.toggle_hidden",
				["H"] = "actions.toggle_hidden",
				["g\\"] = "actions.toggle_trash",
			},
		},
	},

	{
		"ThePrimeagen/harpoon", -- TODO: Consider cbochs/grapple.nvim or desdic/marlin.nvim
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
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
				desc = "[Harpoon] Go to previous",
			},
			{
				"<leader>=",
				function() require("harpoon"):list():next() end,
				desc = "[Harpoon] Go to next",
			},
		},
		config = function()
			local function refresh_neotree()
				local neotree_sources_manager = package.loaded["neo-tree.sources.manager"]
				if neotree_sources_manager ~= nil then neotree_sources_manager.refresh() end
			end

			local harpoon = require("harpoon")
			harpoon:setup({})
			harpoon:extend({
				SELECT = function(ctx) vim.notify(" ⥤  " .. ctx.item.value) end,
				ADD = function(ctx)
					vim.notify(" [+] " .. ctx.item.value)
					refresh_neotree()
				end,
				REMOVE = function(ctx)
					vim.notify(" [-] " .. ctx.item.value)
					refresh_neotree()
				end,
				REORDER = function() refresh_neotree() end,
			})

			vim.keymap.set(
				"n",
				"<C-e>",
				function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
				{ desc = "[Harpoon] Open list" }
			)
		end,
	},
}
