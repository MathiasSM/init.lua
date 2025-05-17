---@module "lazy"
---@type LazyPluginSpec[]
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = function() require("nvim-treesitter.install").update({ with_sync = true })() end,
    config = function()
      local configs = require("nvim-treesitter.configs")

      vim.o.foldmethod = "expr"
      vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"

      ---@diagnostic disable-next-line missing-fields
      configs.setup({
        auto_install = true,
        sync_install = false,
        incremental_selection = { enable = true },
        indent = { enable = true },
        highlight = { enable = true },
        ensure_installed = {
          -- Snacks image
          "css",
          "html",
          "javascript",
          "latex",
          "norg",
          "scss",
          "svelte",
          "tsx",
          "typst",
          "vue",
          -- Snacks picker
          "markdown_inline",
          "markdown",
          "regex",
        }
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    cmd = "TSContextToggle",
    keys = {
      {
        "[u",
        function() require("treesitter-context").go_to_context(vim.v.count1) end,
        desc = "[TS] Go to scope start",
      },
    },
    config = function()
      require("treesitter-context").setup({
        min_window_height = 30,
        multiline_threshold = 5,
      })
      vim.cmd([[hi TreesitterContextBottom gui=underline guisp=Grey]])
      vim.cmd([[hi TreesitterContextLineNumberBottom gui=underline guisp=Grey]])
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("nvim-treesitter.configs").setup({
        textobjects = {
          select = { enable = true },
          move = { enable = true },
          swap = { enable = true },
          lsp_interop = { enable = true },
        },
      })
    end,
  },

  {
    "chrisgrieser/nvim-various-textobjs",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "VeryLazy",
    ---@module "various-textobjs"
    ---@type VariousTextobjs.Config
    opts = {
      keymaps = {
        useDefaults = true,
        disabledDefaults = { ".", ";", "i;", "," },
      },
    },
  },

  {
    "RRethy/nvim-treesitter-textsubjects",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    config = function()
      require("nvim-treesitter-textsubjects").configure({
        enable = true,
        prev_selection = ",",
        keymaps = {
          ["."] = {
            "textsubjects-smart",
            desc = "Select Smart",
          },
          [";"] = {
            "textsubjects-container-outer",
            desc = "Select outside containers (classes, functions, etc.)",
          },
          ["i;"] = {
            "textsubjects-container-inner",
            desc = "Select inside containers (classes, functions, etc.)",
          },
        },
      })
    end,
  },
}
