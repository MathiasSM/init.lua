--- Plugins for running tests 
--
-- Some interact with the DAP
--
-- @module testing

return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			-- Used adapters
			"nvim-neotest/neotest-jest",
			"mrcjkb/neotest-haskell",
			"rcasia/neotest-java",
			"rcasia/neotest-bash",
			"nvim-neotest/neotest-plenary",
			"nvim-neotest/neotest-vim-test",
		},
		cmd = {
			"TestNearest",
			"TestFile",
			"TestNearestDebug",
			"TestFileDebug",
			-- "TestStop",
			-- "TestNearestAttach"
		},
		config = function()
			-- TODO: Look for Config file instead
			local is_amazon = false
			if vim.fn.executable("brazil-build") == 1 then is_amazon = true end
			-- TODO: Setup commands
			---@diagnostic disable-next-line missing-fields
			require("neotest").setup({
				adapters = {
					-- TODO: Test
					require("neotest-jest")({
						jestCommand = is_amazon and "brazil-build test --" or "npm test --",
					}),
					-- TODO: Config
					require("neotest-haskell"),
					-- TODO: Test
					require("neotest-java"),
					require("neotest-bash"),
					require("neotest-plenary"),
					require("neotest-vim-test")({
						ignore_file_types = {
							"typescript",
							"javascript",
							"java",
							"bash",
							"vim",
							"lua",
						},
					}),
				},
			})
		end,
	},

	{
		"nvim-neotest/neotest-vim-test",
		lazy = true,
		dependencies = {
			{
				"vim-test/vim-test",
				init = function()
					-- TODO: Confirm it's used
					-- TODO: Check Tslime
					vim.cmd([[
						let test#strategy = {
							\ 'nearest': 'neovim',
							\ 'file':    'dispatch',
							\ 'suite':   'basic',
						\}
					]])
				end,
			},
		},
	},
}
