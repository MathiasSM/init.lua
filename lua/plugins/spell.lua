---@module "lazy"
---@type LazyPluginSpec[]
return {
  {
    "psliwka/vim-dirtytalk",
    build = ":DirtytalkUpdate",
    event = "VeryLazy",
    config = function() vim.cmd("set spelllang+=programming") end,
  },
}
