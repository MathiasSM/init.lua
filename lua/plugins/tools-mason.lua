---@module "lazy"
---@type LazyPluginSpec[]
return {
  {
    "mason-org/mason.nvim",
    lazy = false, -- So path is up to date
    build = ":MasonUpdate",
    opts = {}
  },

  { "neovim/nvim-lspconfig", lazy = true },
}
