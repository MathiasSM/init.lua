---@module "lazy"
---@type LazyPluginSpec[]
return {
  {
    "nvim-treesitter/playground",
    dependencies = "nvim-treesitter/nvim-treesitter",
    cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
    config = function()
      ---@diagnostic disable-next-line missing-fields
      require("nvim-treesitter.configs").setup({
        playground = { enable = true },
      })
    end,
  },
}
