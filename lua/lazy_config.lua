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
	change_detection = { notify = false }, -- Gets annoying fast
	ui = {
		border = "single",
		browser = nil, -- TODO
	},
	checker = { enabled = true },
	profiling = {
		loader = false,
		require = false,
	},
})
