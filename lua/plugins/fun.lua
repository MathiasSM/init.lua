--- A few funny or fun plugins, including games and jokes
--
-- No custom keymaps or anything, all lazy loaded **only** if requested.

---@module "lazy"
---@type LazyPluginSpec[]
return {
  {
    "eandrju/cellular-automaton.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    cmd = "CellularAutomaton",
  },

  {
    "giusgad/pets.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "edluffy/hologram.nvim" },
    cmd = { "PetsNew", "PetsNewCustom" },
    opts = {},
  },

  {
    "ThePrimeagen/vim-be-good",
    cmd = "VimBeGood",
  },

  {
    "seandewar/nvimesweeper",
    cmd = "Nvimesweeper",
  },

  {
    "seandewar/killersheep.nvim",
    cmd = "KillKillKill",
  },

  {
    "Febri-i/snake.nvim",
    dependencies = "Febri-i/fscreen.nvim",
    cmd = "SnakeStart",
    opts = {},
  },

}
