---@type LazyPluginSpec[]
return {
  {
    "saghen/blink.compat",
    version = "2.*",
    lazy = true,
    opts = { impersonate_nvim_cmp = true },
  },

  {
    "saghen/blink.cmp",
    version = "1.*",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "rafamadriz/friendly-snippets",
      -- Bridged nvim-cmp sources
      "hrsh7th/cmp-calc",
      "andersevenrud/cmp-tmux",
      {
        "aspeddro/cmp-pandoc.nvim",
        dependencies = "jbyuki/nabla.nvim",
        opts = { crossref = { enable_nabla = true } },
      },
      {
        "yehuohan/cmp-im",
        dependencies = "MathiasSM/ZFVimIM_japanese_base",
        opts = {
          enable = true,
          tables = {
            vim.fn.stdpath("data") .. "/lazy/ZFVimIM_japanese_base/misc/japanese.txt",
          },
        },
      },
      "nvim-tree/nvim-web-devicons",
    },
    config = require("plugins.completion.config"),
  },
}
