-- Recognize Config files as new filetype brazil-config
vim.filetype.add({
	filename = {
		["Config"] = "brazil-config",
	},
})

return {
	{ "mfussenegger/nvim-jdtls", lazy = true },

	{
		name = "amazon:scat",
		event = "VeryLazy",
		url = "enlovson@git.amazon.com:pkg/Scat-nvim", branch = "mainline",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"sindrets/diffview.nvim",
		},
		opts = {
			cr = {
				template_path = nil,
				template_content = require("plugins.private.crux_template"),
				user = nil,
				executable = "cr",
			},
		},
	},

	{
		name = "amazon:brazil_config",
		url = "enlovson@git.amazon.com:pkg/NinjaHooks", branch = "mainline",
        ft = "brazil-config",
		config = function(plugin)
			vim.opt.rtp:prepend(plugin.dir .. "/configuration/vim/amazon/brazil-config")

			local lspconfig = require("lspconfig")
			local configs = require("lspconfig.configs")

            if not configs.barium then
				configs.barium = {
					default_config = {
						cmd = { "barium" },
						filetypes = { "brazil-config" },
						root_dir = function(fname)
							return lspconfig.util.find_git_ancestor(fname)
						end,
						settings = {},
					},
				}
			end
            lspconfig.barium.setup({}) -- TEST: Is mason-lspconfig redoing this?
		end,
	},

	{
		name = "local:amazon_java",
		dir = "~/.config/nvim/lua/plugins/private/amazon_java.lua",
		ft = "java",
		dependencies = "mfussenegger/nvim-lint",
		config = function()
			require("plugins.private.amazon_java").setup()
		end
	},

	{
		name = "local:amazon_mappings",
		event = "VeryLazy",
		dir = "~/.config/nvim/lua/plugins/private/amazon_mappings.lua",
		config = function()
			require("plugins.private.amazon_mappings")
		end
	},
}
