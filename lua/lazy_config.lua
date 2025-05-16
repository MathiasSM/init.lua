local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Plugins definitions in CONFIG/lua/plugins.lua
require("lazy").setup("plugins", {
  lockfile = require("lazy_lockfile"),
  change_detection = { enabled = true, notify = false },
  checker = { enabled = true, notify = false },
  ui = {
    title = "Lazy.nvim",
    border = "single",
    browser = require("utils").get_open_cmd(),
  },
  profiling = {
    loader = false,
    require = false,
  },
})
