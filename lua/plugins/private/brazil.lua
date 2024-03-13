local Utils = require("plugins.private.utils")

local function setup_jdtls_with_brazil(root_dir)
	local jdtls = require("jdtls")

	local runtime_name, runtime_path = Utils.brazil_open_jdk_location(root_dir)
	vim.env.JDK_HOME = runtime_path

	local config = {}

	config.cmd = {
		"jdtls", -- need to be on your PATH
		"--no-validate-java-version",
		"--jvm-arg=-javaagent:" .. Utils.get_lombok_path(),
		"--jvm-arg=-noverify",
		"-data",
		Utils.get_eclipse_workspace(root_dir),
	}

	config.root_dir = root_dir

	config.capabilities = require("cmp_nvim_lsp").default_capabilities()

	config.init_options = {
		workspaceFolders = Utils.get_workspace_folders(root_dir),
		extendedClientCapabilities = (function()
			local ecc = jdtls.extendedClientCapabilities
			ecc.resolveAdditionalTextEditsSupport = true
			return ecc
		end)(),
	}

	-- https://github.com/eclipse-jdtls/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line
	config.settings = {}
	config.settings.java = {
		settings = {
			url = Utils.get_jdtls_settings_path(),
		},
		implementationCodeLens = { enabled = true }, -- TODO: Test
		signatureHelp = { enabled = true },
		configuration = {
			runtimes = {
				{
					name = runtime_name,
					path = runtime_path,
				},
			},
		},
	}
	jdtls.start_or_attach(config)
end

return {
	{
		"mfussenegger/nvim-jdtls",
		ft = "java",
		config = function()
			local jdtls = require("jdtls")
			local map = vim.keymap.set
			map(
				"n",
				"<space>oi",
				function() jdtls.organize_imports() end,
				{ desc = "[Jdtls] Organize imports" }
			)
			map(
				{ "n", "v" },
				"<space>xv",
				function() jdtls.extract_variable() end,
				{ desc = "[Jdtls] Extract variable" }
			)
			map(
				{ "n", "v" },
				"<space>xc",
				function() jdtls.extract_constant() end,
				{ desc = "[Jdtls] Extract constant" }
			)
			map(
				"v",
				"<space>xm",
				function() jdtls.extract_method() end, -- TODO
				{ desc = "[Jdtls] Extract method" }
			)
			map(
				"n",
				"<space>tc",
				function() jdtls.test_class() end,
				{ desc = "[Jdtls] Test class" }
			)
			map(
				"n",
				"<space>tn",
				function() jdtls.test_nearest_method() end,
				{ desc = "[Jdtls] Test nearest method" }
			)
		end,
	},

	{
		name = "amazon:java",
		dir = "~/.config/nvim/lua/plugins/private/noop.lua",
		ft = "java",
		dependencies = "mfussenegger/nvim-lint",
		config = function()
			require("mason-lspconfig").setup({
				handlers = {
					["jdtls"] = function()
						vim.api.nvim_create_autocmd("FileType", {
							pattern = "java",
							desc = "Attach jdtls on java files",
							group = vim.api.nvim_create_augroup("UserLspConfigJava", {}),
							callback = function()
								local setup = require("jdtls.setup")
								local root_dir = setup.find_root({ "packageInfo" }, "Config")
								setup_jdtls_with_brazil(root_dir)
								local checkstyle_config = Utils.get_checkstyle_config(root_dir)
								require("lint.linters.checkstyle").config_file = checkstyle_config
							end,
						})
					end,
				},
			})
		end,
	},

	{
		name = "amazon:scat",
		url = "enlovson@git.amazon.com:pkg/Scat-nvim",
		branch = "mainline",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"sindrets/diffview.nvim",
		},
		opts = {},
	},

	{
		-- TODO: Load lazily adding lazy keys
		name = "amazon:brazil",
		dir = "~/.config/nvim/lua/plugins/private/noop.lua",
		dependencies = "amazon:scat",
		config = function()
			local brazil = require("scat.brazil")
			local brazil_utils = require("scat.brazil.utils")

			-- Display
			vim.keymap.set(
				"n",
				"<leader>al",
				brazil.list_all_packages,
				{ desc = "[Brazil] List All Packages" }
			)
			vim.keymap.set(
				"n",
				"<leader>auv",
				brazil.display_current_version_set_url,
				{ desc = "[Brazil] Display URL for Current Version Set" }
			)

			-- Prepare
			vim.keymap.set(
				"n",
				"<leader>ai",
				brazil.install_current_jdt_package,
				{ desc = "[Brazil] Install Current JDT Package" }
			)

			-- Build
			vim.keymap.set(
				"n",
				"<leader>abb",
				brazil.build_current_package,
				{ desc = "[Brazil] bb (current package)" }
			)
			vim.keymap.set(
				"n",
				"<leader>abr",
				brazil.build_current_package_recursively,
				{ desc = "[Brazil] bb (current package recursively)" }
			)

			-- Other Tasks
			vim.keymap.set("n", "<leader>abt", function()
				brazil.pick_brazil_task_inside_current_package({
					callback = function(task) vim.g.test_replacement_command = task end,
				})
			end, { desc = "[Brazil] bb <task> (pick task)" })
			vim.keymap.set(
				"n",
				"<leader>abl",
				brazil.run_prev_brazil_task,
				{ desc = "[Brazil] bb <task> (last task)" }
			)
			vim.keymap.set(
				"n",
				"<leader>ac",
				brazil.run_command_inside_current_package,
				{ desc = "[Brazil] <any cmd>" }
			)
			vim.keymap.set(
				"n",
				"<leader>aC",
				brazil_utils.run_checkstyle,
				{ desc = "[Brazil] Checkstyle" } -- TODO: Confirm is this or lint is better
			)
			vim.keymap.set(
				"n",
				"<leader>aw",
				brazil.switch_workspace_package_info,
				{ desc = "[Brazil] Change packageInfo in Current Workspace" }
			)
		end,
	},
}
