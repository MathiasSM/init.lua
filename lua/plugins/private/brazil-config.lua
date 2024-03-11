-- Recognize Config files as new filetype brazil-config
vim.filetype.add({
	filename = {
		["Config"] = "brazil-config",
	},
})

return {
	{
		url = "enlovson@git.amazon.com:pkg/NinjaHooks",
		branch = "mainline",
        ft = "brazil-config",
		config = function(plugin)
			-- Setup brazil-config
			vim.opt.rtp:prepend(plugin.dir .. "/configuration/vim/amazon/brazil-config")

			local lspconfig = require("lspconfig")
			local configs = require("lspconfig.configs")

            if not configs.barium then
				configs.barium = {
					default_config = {
						cmd = { "barium" },
						filetypes = { "brazil-config" },
						root_dir = function(fname) return lspconfig.util.find_git_ancestor(fname) end,
						settings = {},
					},
				}
			end
            lspconfig.barium.setup({}) -- TEST: Is mason-lspconfig redoing this?
		end,
	},
}
