return {
	{
		"mhartington/formatter.nvim",
		keys = {
			{ "<leader>pp", ":FormatWrite<CR>", desc = "Format" },
		},
		cmd = { "Format", "FormatWrite" },
		config = function()
			require("formatter").setup({
				logging = true,
				log_level = vim.log.levels.WARN,
				-- All formatter configurations are opt-in
				filetype = {
					-- and will be executed in order
					lua = { require("formatter.filetypes.lua").stylua },
					javascript = {
						require("formatter.filetypes.javascript").eslint_d,
					},
					typescript = {
						require("formatter.filetypes.typescript").eslint_d,
					},
					sh = { require("formatter.filetypes.sh").shfmt },
					sql = {
						require("formatter.filetypes.sql").pgformat,
						require("formatter.filetypes.sql").sqlfluff,
					},

					["*"] = {
						require("formatter.filetypes.any").remove_trailing_whitespace,
					},
				},
			})
		end,
	},
}
