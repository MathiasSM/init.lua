---@type LazyPluginSpec[]
return {
  -- Build a custom index of files to easily jump between them
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "Harpoon" },
    keys = require("plugins.navigation.mappings").harpoon,
    config = require("plugins.navigation.harpoon").setup,
  },
  -- Editable file browser
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    keys = require("plugins.navigation.mappings").oil,
    opts = require("plugins.navigation.oil").opts,
  },
}
