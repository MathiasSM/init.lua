--- Telescope plugins for searching
--
-- * Telescope itself
-- * FZF: For faster fuzzy find files
-- * Ag: For grepping files
-- * Undo: For undo tree
-- * Nerdy: For searching nerdicons
--
-- Some plugins outside of this module may include other telescope extensions
-- if they are mainly _not_ for searching.
--
-- @module telescope

return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    cmd = "Telescope",
    keys = {
      {
        "<leader>ff",
        require("telescope.builtin").find_files,
        desc = "[Telescope] Find files (fzf)",
      },
      {
        "<leader>fb",
        require("telescope.builtin").buffers,
        desc = "[Telescope] Buffers",
      },
      {
        "<leader>fh",
        require("telescope.builtin").help_tags,
        desc = "[Telescope] Help tags",
      },
    },
    opts = {},
    config = function()
      require("telescope").setup({})
      require("telescope").load_extension("fzf")
    end,
  },

  {
    "kelly-lin/telescope-ag",
    build = function()
      if vim.fn.executable("ag") ~= 1 then
        vim.notify("Did not find `ag` executable!", vim.log.levels.ERROR)
        return
      end
    end,
    dependencies = { "nvim-telescope/telescope.nvim" },
    keys = {
      {
        "<leader>fg",
        require("telescope.builtin").live_grep,
        desc = "[Telescope] Live grep (Ag)",
      },
    },
    config = function() require("telescope").load_extension("ag") end,
  },

  {
    "debugloop/telescope-undo.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    keys = {
      {
        "<leader>fu",
        "<cmd>Telescope undo<cr>",
        desc = "[Telescope] Undo History",
      },
    },
    config = function()
      require("telescope").setup({
        extensions = {
          undo = {
            use_delta = false,
            side_by_side = false,
            layout_strategy = "vertical",
            layout_config = {
              preview_height = 0.6,
            },
          },
        },
      })
      require("telescope").load_extension("undo")
    end,
  },

  {
    "tsakirist/telescope-lazy.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    keys = { { "<leader>fl", "<cmd>Telescope lazy<cr>", desc = "[Telescope] Lazy plugins" } },
    config = function() require("telescope").load_extension("lazy") end,
  },

  {
    "benfowler/telescope-luasnip.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    keys = { { "<leader>fs", "<cmd>Telescope luasnip<cr>", desc = "[Telescope] Snippets" } },
    config = function() require("telescope").load_extension("luasnip") end,
  },

  {
    "chip/telescope-software-licenses.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    keys = {
      {
        "<leader>fc",
        "<cmd>Telescope software-licenses find<cr>",
        desc = "[Telescope] Software Licenses",
      },
    },
    config = function() require("telescope").load_extension("software-licenses") end,
  },
}
