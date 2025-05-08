vim.keymap.set(
	"n",
	"<space>oi",
	function() require("jdtls").organize_imports() end,
	{ desc = "[Jdtls] Organize imports" }
)
vim.keymap.set(
	{ "n", "v" },
	"<space>xv",
	function() require("jdtls").extract_variable() end,
	{ desc = "[Jdtls] Extract variable" }
)
vim.keymap.set(
	{ "n", "v" },
	"<space>xc",
	function() require("jdtls").extract_constant() end,
	{ desc = "[Jdtls] Extract constant" }
)
vim.keymap.set(
	"v",
	"<space>xm",
	function() require("jdtls").extract_method() end, -- TODO
	{ desc = "[Jdtls] Extract method" }
)
vim.keymap.set(
	"n",
	"<space>tc",
	function() require("jdtls").test_class() end,
	{ desc = "[Jdtls] Test class" }
)
vim.keymap.set(
	"n",
	"<space>tn",
	function() require("jdtls").test_nearest_method() end,
	{ desc = "[Jdtls] Test nearest method" }
)


local Utils = require("plugins.private.utils")

local function get_jdtls_base_config(root_dir)
	local config = {
        root_dir = root_dir,
    }

	config.cmd = {
		"jdtls", -- need to be on your PATH
		"--jvm-arg=-javaagent:" .. Utils.get_lombok_path(),
		"-data",
		Utils.get_eclipse_workspace(root_dir),
	}


	config.init_options = {
		workspaceFolders = Utils.get_bemol_workspace_folders(root_dir),
	}

	local runtime_name, runtime_path = Utils.brazil_jdk_location(root_dir)
	vim.env.JDK_HOME = runtime_path

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
	return config

end

local function setup_checkstyle(pkg_root_dir)
	if pkg_root_dir == nil then
		vim.notify_once("Could not find package root. Skipping checkstyle.")
		return
	end
	local checkstyle_config = vim.fs.joinpath(pkg_root_dir, "checkstyle.xml")
	require("lint.linters.checkstyle").config_file = checkstyle_config
end

local function setup_jdtls(ws_root_dir)
	if ws_root_dir == nil then
		vim.notify_once("Could not find workspace root. Skipping jdtls.")
		return
	end
	local config = get_jdtls_base_config(ws_root_dir)
	local ecc = require("jdtls").extendedClientCapabilities
	ecc.resolveAdditionalTextEditsSupport = true
	config.init_options.extendedClientCapabilities = ecc
	config.capabilities = require("cmp_nvim_lsp").default_capabilities()
	require("jdtls").start_or_attach(config)
end

local M = {}

function M.setup()
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "java",
		desc = "Attach jdtls on java files",
		group = vim.api.nvim_create_augroup("UserLspConfigJava", {}),
		callback = function()
			local pkg_root_dir = vim.fs.root(0, {"Config"})
			setup_checkstyle(pkg_root_dir)

			local ws_root_dir = vim.fs.root(0, {"packageInfo", ".bemol"})
			setup_jdtls(ws_root_dir)
		end,
	})
end

return M
