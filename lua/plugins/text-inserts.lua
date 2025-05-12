--- Special actions that insert text into the buffer
--
-- These do not manipulate the buffer in any other way.
---@module "lazy"
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
