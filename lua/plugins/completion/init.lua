---@type LazyPluginSpec[]
return {
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter" },
    dependencies = require("plugins.completion.dependencies"),
    config = require("plugins.completion.config"),
  },

  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    lazy = true,
    config = function()
      require("luasnip").setup({
        region_check_events = { "CursorMoved", "CursorHold", "InsertEnter" },
        delete_check_events = "TextChanged",
      })
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
}
