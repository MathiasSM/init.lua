
return {
	{
		"kelly-lin/telescope-ag",
		build = function()
			if vim.fn.executable("ag") ~= 1 then
				vim.notify("Did not find `ag` executable!", vim.log.levels.ERROR)
				return
			end
		end,
		dependencies = { "nvim-telescope/telescope.nvim" },
		cmd = "Ag",
		keys = {
			{
				"<leader>fg",
				require("telescope.builtin").live_grep,
				desc = "[Telescope] Live grep (Ag)",
			},
		},
		config = function() require("telescope").load_extension("ag") end,
	},
}

