---@type LazyPluginSpec[]
return {
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true,
    cmd = { "Neogen" },
    keys = {
      { "<leader>da", "<cmd>Neogen<cr>", desc = "[Neogen] Add docstrings" },
    },
  },
}
