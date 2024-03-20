--- Navigation between files and across directories/projects
-- Directories/file visualization definedin other files
-- @module navigation

return {
	{ "mateuszwieloch/automkdir.nvim", event = "VeryLazy" },

	{
		"ThePrimeagen/harpoon", -- NOTE: Consider cbochs/grapple.nvim or desdic/marlin.nvim
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = { "Harpoon" },
		keys = {
			"<C-e>", -- Defined in config
			{
				"<leader>=",
				function() require("harpoon"):list():append() end,
				desc = "[Harpoon] Add current to list",
			},
			{
				"<leader><del>",
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
				"<leader>[",
				function() require("harpoon"):list():prev({ ui_nav_wrap = true }) end,
				desc = "[Harpoon] Go to previous",
			},
			{
				"<leader>]",
				function() require("harpoon"):list():next({ ui_nav_wrap = true }) end,
				desc = "[Harpoon] Go to next",
			},
		},
		config = function()
			local function refresh_neotree()
				local neotree_sources_manager = package.loaded["neo-tree.sources.manager"]
				if neotree_sources_manager ~= nil then neotree_sources_manager.refresh() end
			end

			local harpoon = require("harpoon")
			local harpoon_default_list = require("harpoon.config").DEFAULT_LIST

			harpoon:setup({
				settings = {
					save_on_toggle = true,
					sync_on_ui_close = true,
					key = vim.loop.cwd, -- Grouping key for lists,
				},
			})

			local list_name = function(name)
				if name == harpoon_default_list then return "" end
				return "[" .. name .. "]"
			end

			harpoon:extend({
				SELECT = function(ctx)
					vim.notify(
						list_name(ctx.list.name) .. " ⥤  " .. ctx.idx .. ": " .. ctx.item.value
					)
				end,
				ADD = function(ctx)
					vim.notify(list_name(ctx.list.name) .. "  " .. ctx.item.value)
					refresh_neotree()
				end,
				REMOVE = function(ctx)
					vim.notify(list_name(ctx.list.name) .. " 󰍴 " .. ctx.item.value)
					refresh_neotree()
				end,
				REORDER = function() refresh_neotree() end,
			})

			vim.keymap.set("n", "<leader>0", function()
				local title = "Harpoon ⥤ " .. harpoon.config.settings.key()
				harpoon.ui:toggle_quick_menu(harpoon:list(), { title = title })
			end, { desc = "[Harpoon] Project files" })
		end,
	},
}
