---@module "lazy"
---@type LazyPluginSpec[]
return {
  -- Reopen files on their last edit position
  { "vladdoster/remember.nvim", lazy = false, config = true },

  -- Add actions
  { "kevinhwang91/nvim-bqf", ft = "qf" },

  -- Add formatting
  {
    "yorickpeterse/nvim-pqf",
    config = true,
    lazy = false, -- Non-lazy so it works on the first quickfix I open
  },

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "Trouble" },
    event = { "LspAttach" },
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "[Trouble] Diagnostics",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "[Trouble] Buffer Diagnostics",
      },
      {
        "<leader>xs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "[Trouble] Symbols",
      },
      {
        "<leader>xl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "[Trouble] LSP Definitions / references / ...",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "[Trouble] Location List",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "[Trouble] Quickfix List",
      },
    },
    opts = {},
  },
}
