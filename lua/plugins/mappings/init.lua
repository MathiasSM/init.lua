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
        { "<leader>", group = "[Personal]" },
        { "<leader>v", group = "[Vim Toggle]" },
        { "<leader><leader>", group = "[My Toggles]" },
        { "<leader><leader>g", group = "[Git]", icon = { icon = "󰊢", color = "red" }  },
        { "<leader>d", group = "[Docs]", icon = { icon = "󰈙", color = "cyan" } },
        { "<leader>b", group = "[Debug]" },
        { "<leader>f", group = "[Find]" },
        { "<leader>g", group = "[Git]", icon = { icon = "󰊢", color = "red" } },
        { "<leader>h", group = "[Hunks]", icon = { icon = "󰊢", color = "red" } },
        { "<leader>l", group = "[LSP] Pickers", icon = { icon = "󰛨", color = "azure" } },
        { "<leader>r", group = "[Rules]", icon = { icon = "", color = "cyan" } },
        { "<leader>t", group = "[Test]", icon = { icon = "󰙨", color = "blue" } },
        { "<leader>x", group = "[Trouble]", icon = { icon = "󱖫", color = "red" } },
        -- LSP (space)
        { "<space>", group = "[LSP]", icon = { icon = "󰛨", color = "azure" } },
        { "<space>w", group = "[Workspace]", icon = "󰙅" },
        { "<space>h", group = "[Haskell]", icon = "" },
      })
      -- Renaming...
      require("which-key").add({
        { "[d", desc = "[Diagnostics] Previous" },
        { "]d", desc = "[Diagnostics] Next" },
        { "[D", desc = "[Diagnostics] First" },
        { "]D", desc = "[Diagnostics] Last" },
      })
    end,
  },
}
