return {
  {
      "catppuccin/nvim",
      name = "catppuccin",
      lazy = false,
      priority = 1000,
      opts = require('plugins.ui.colorscheme').catppuccin
  },
  {
    "laytan/cloak.nvim",
    lazy = false, -- Plugin loads before text file is displayed
    opts = {
      highlight_group = "Comment",
      cloak_length = 8,
      cloak_telescope = true,
      patterns = {
        {
          file_pattern = { ".env*" },
          cloak_pattern = { "=.+", ":.+" },
        },
      },
    },
  },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
    opts = {
      signs = true,
      sign_priority = 8,
      highlight = {
        multiline = false,
      },
      keywords = {
        -- FIX: fix
        -- TODO: todo
        -- HACK: hack
        -- WARN: warn
        -- PERF: perf
        -- NOTE: note
        -- TEST: test
        FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = "󰶯 ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = {
          icon = "󰑮 ",
          color = "hint",
          alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" },
        },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        TEST = { icon = "󰙨 ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
    },
  },

  {
    "m4xshen/smartcolumn.nvim",
    event = "VeryLazy",
    opts = {
      colorcolumn = "80",
      disabled_filetypes = {
        "Trouble",
        "help",
        "lazy",
        "lspinfo",
        "markdown",
        "mason",
        "neo-tree",
        "netrw",
        "noice",
        "oil",
        "qf",
        "text",
      },
      custom_colorcolumn = {
        java = "120",
        lua = "100",
        haskell = "100",
      },
    },
  },

  {
    "nmac427/guess-indent.nvim",
    event = "VeryLazy",
    opts = {
      filetype_exclude = {
        "netrw",
        "tutor",
        "neo-tree",
        "oil",
      },
    },
  },

  {
    "norcalli/nvim-colorizer.lua",
    cmd = { "ColorizerAttachToBuffer" },
    ft = { "css" }, -- Autoload automatically
    opts = {
      "*", -- Highlight all files, but customize some others.
      css = { css = true }, -- Enable parsing rgb(...) functions in css.
      html = { names = false },
    },
  },
}
