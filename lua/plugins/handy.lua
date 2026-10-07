---@module "lazy"
---@type LazyPluginSpec[]
return {
  {
    -- Provides treesitter-aware `commentstring` for the built-in `gc`/`gcc` operators
    "JoosepAlviste/nvim-ts-context-commentstring",
    event = "VeryLazy",
    config = function()
      require("ts_context_commentstring").setup({
        enable_autocmd = true,
      })
    end,
  },

  {
    "junegunn/vim-easy-align",
    cmd = { "EasyAlign" },
  },

  {
    "nat-418/boole.nvim",
    keys = {
      { "<C-a>", desc = "Switch/increment" },
      { "<C-x>", desc = "Switch/decrement" },
    },
    config = function()
      require("boole").setup({
        mappings = {
          increment = "<C-a>",
          decrement = "<C-x>",
        },
        additions = {},
        allow_caps_additions = {
          { "enable", "disable" }, -- Enable → Disable, ENABLE → DISABLE, ...
          { "error", "warn", "info", "hint", "debug" },
          { "high", "low" },
          { "left", "right" },
        },
      })
    end,
  },

  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    keys = {
      {
        "<leader>j",
        "<cmd>TSJToggle<cr>",
        desc = "[TreeSJ] Toggle join/split code",
      },
    },
    config = function()
      require("treesj").setup({
        max_join_length = 1200,
        use_default_keymaps = false,
      })
    end,
  },
}
