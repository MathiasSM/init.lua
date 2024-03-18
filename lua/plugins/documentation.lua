--- Documentation-related plugins
--
-- * Generation of documentation tags
-- * Generation of HTML/other documentation pages from comment tags
-- * Find documentation
--
-- @module documentation

return {
	{
		"danymat/neogen",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = true,
		cmd = { "Neogen" },
		keys = {
			{ "<leader>da", "<cmd>Neogen<cr>", desc = "[Neogen] Add docs" },
		},
	},

	{
		"Zeioth/dooku.nvim",
		cmd = {
			"DookuAutoSetup",
			"DookuGenerate",
			"DookuOpen",
		},
		keys = {
			{ "<leader>dg", "<cmd>DookuGenerate<cr>", desc = "[Dooku] Generate docs" },
			{ "<leader>do", "<cmd>DookuOpen<cr>", desc = "[Dooku] Open generated" },
		},
		opts = {
			browser_cmd = require("utils").get_open_cmd(),
		},
	},

	{
		"luckasRanarison/nvim-devdocs",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		cmd = {
			"DevdocsFetch",
			"DevdocsInstall",
			"DevdocsOpen",
			"DevdocsOpenCurrent",
			"DevdocsToggle",
			"DevdocsUpdateAll",
		},
		keys = {
			{ "<leader>dd", "<cmd>DevdocsToggle<cr>", desc = "[DevDocs] Toggle" },
			{ "<leader>dc", "<cmd>DevdocsOpenCurrent<cr>", desc = "[DevDocs] Open for current ft" },
		},
		opts = {
			wrap = true,
			previewer_cmd = vim.fn.executable("glow") == 1 and "glow" or nil,
			cmd_args = { "-s", "dark", "-w", "80" },
			picker_cmd = vim.fn.executable("glow") == 1 and "glow" or nil,
			picker_cmd_args = { "-p" },
			mappings = {
				open_in_browser = require("utils").get_open_cmd(),
			},
			after_open = function(bufnr)
				vim.api.nvim_exec2("execute 'normal <c-\\><c-n>'") -- Exit terminal mode
				vim.api.nvim_buf_set_keymap(bufnr, "n", "<Esc>", ":close<CR>", {})
			end,
			-- stylua: ignore
			ensure_installed = {
				"html", "c", "cpp", "css", "cypress", "esbuild", "eslint", "gcc", "git", "make",
				"gnuplot", "go", "godot", "handlebars", "haskell", "homebrew", "html", "htmx",
				"http", "javascript", "jest", "jinja", "jq", "jquery", "jsdoc", "latex", "lodash",
				"lua", "moment", "moment_timezone", "nginx", "nix", "node", "npm", "openjdk",
				"postgresql", "python", "react", "react_router", "redux", "rust", "sass", "scala",
				"svg", "typescript", "dom", "web_extensions", "webpack",
			},
		},
		config = function(_, opts)
			require("nvim-devdocs").setup(opts)
			vim.schedule(function() vim.cmd("DevdocsFetch") end)
			vim.notify('You may update docs with `nvim --headless +"DevdocsUpdateAll"`')
		end,
	},

	{
		"luc-tielen/telescope_hoogle",
		dependencies = { "nvim-telescope/telescope.nvim" },
		build = function()
			if vim.fn.executable("hoogle") ~= 1 then
				vim.notify(
					"Did not find `hoogle` executable!\nInstall it with `cabal install hoogle`",
					vim.log.levels.ERROR
				)
				return
			end
			vim.notify("Running `hoogle generate &`", vim.log.levels.INFO)
			vim.fn.system("hoogle generate &")
		end,
		keys = { { "<leader>dh", "<cmd>Telescope hoogle<cr>", desc = "[Telescope] Hoogle" } },
		config = function() require("telescope").load_extension("hoogle") end,
	},
}
