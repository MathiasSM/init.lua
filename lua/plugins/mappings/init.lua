---@module "lazy"
---@type LazyPluginSpec[]
return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup({
        preset = "modern",
      })
      require("which-key").add({
        -- Personal (leader)
        { "<leader>",           group = "[Personal]" },
        { "<leader>v",          group = "[Vim Toggle]" },
        { "<leader><leader>",   group = "[My Toggles]" },
        { "<leader>d", group = "[Docs]",      icon = { icon = "󰈙", color = "cyan" } },
        { "<leader>b", group = "[Debug]" },
        { "<leader>f", group = "[Find]" },
        { "<leader>g", group = "[Git]",       icon = { icon = "󰊢", color = "red" } },
        { "<leader>h", group = "[Git hunk]",  icon = { icon = "󰊢", color = "red" } },
        { "<leader>r", group = "[Rules]",     icon = { icon = "", color = "cyan" } },
        { "<leader>t", group = "[Test]",      icon = { icon = "󰙨", color = "blue" } },
        { "<leader>x", group = "[Trouble]",   icon = { icon = "󱖫", color = "red" } },
        -- LSP (space)
        { "<space>",   group = "[LSP]",         icon = { icon = "󰛨", color = "azure" } },
        { "<space>s",  group = "[Symbols]",     icon = "" },
        { "<space>h",  group = "[Haskell]",     icon = "" },
        { "<space>t",  group = "[Typescript]",  icon = "󰛦" },
        { "<space>ti", group = "[TS:Imports]",  icon = "󰛦" },
        { "<space>w",  group = "[Workspace]",   icon = "󰙅" },
      })
    end,
  },
}
