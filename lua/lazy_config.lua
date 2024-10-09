--- Lazy.nvim bootstrapping and configuration
-- @script

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Plugins definitions in CONFIG/lua/plugins.lua
require("lazy").setup("plugins", {
	lockfile = require("lazy_lockfile"),
	change_detection = { enabled = true, notify = false },
	checker = { enabled = true, notify = false },
	ui = {
		border = "single",
		browser = require("utils").get_open_cmd(),
	},
	profiling = {
		loader = false,
		require = false,
	},
})
