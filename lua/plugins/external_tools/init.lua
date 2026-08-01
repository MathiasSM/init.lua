---@type LazyPluginSpec[]
return {
  {
    "mason-org/mason.nvim",
    lazy = false, -- So path is up to date
    build = ":MasonUpdate",
    opts = { ui = { border = "rounded" } },
  },

  { "neovim/nvim-lspconfig", lazy = true },

  {
    "aserowy/tmux.nvim",
    event = "VeryLazy", -- So clipboard works
    keys = {
      { "<C-h>", function() require("tmux").move_left() end, desc = "[TMUX] Left" },
      { "<C-j>", function() require("tmux").move_bottom() end, desc = "[TMUX] Down" },
      { "<C-k>", function() require("tmux").move_top() end, desc = "[TMUX] Up" },
      { "<C-l>", function() require("tmux").move_right() end, desc = "[TMUX] Right" },
    },
    opts = {
      copy_sync = { redirect_to_clipboard = true },
      navigation = { enable_default_keybindings = false },
      resize = { enable_default_keybindings = false },
      swap = { enable_default_keybindings = false },
    },
  },

  {
    "tpope/vim-fugitive",
    cmd = {
      "Git",
      "Gedit",
      "Gdiffsplit",
      "Gvdiffsplit",
      "Gread",
      "Gwrite",
      "Ggrep",
      "GMove",
      "GDelete",
      "GBrowse",
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    keys = {
      -- Movement
      {
        "]h",
        function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            require("gitsigns").nav_hunk("next")
          end
        end,
        desc = "[Git] Next hunk",
      },

      {
        "[h",
        function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            require("gitsigns").nav_hunk("prev")
          end
        end,
        desc = "[Git] Previous hunk",
      },

      -- Actions
      { mode = "n", "<leader>hs", function() require("gitsigns").stage_hunk() end, desc = "Stage hunk" },
      {
        mode = "v",
        "<leader>hs",
        function() require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
        desc = "Stage hunk",
      },
      { mode = "n", "<leader>hr", function() require("gitsigns").reset_hunk() end, desc = "Reset hunk" },
      {
        mode = "v",
        "<leader>hr",
        function() require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
        desc = "Reset hunk",
      },
      { "<leader>hS", function() require("gitsigns").stage_buffer() end, desc = "Stage buffer" },
      { "<leader>hR", function() require("gitsigns").reset_buffer() end, desc = "Reset stage buffer" },
      { "<leader>hp", function() require("gitsigns").preview_hunk() end, desc = "Preview hunk" },
      { "<leader>hi", function() require("gitsigns").preview_hunk_inline() end, desc = "Preview hunk (inline)" },

      { "<leader>gb", function() require("gitsigns").blame_line() end, desc = "[Show] blame for line" },
      { "<leader>gB", function() require("gitsigns").blame() end, desc = "[Show] blame (vsp)" },

      { "<leader>gd", function() require("gitsigns").diffthis() end, desc = "[Show] diff" },

      { "<leader>gD", function() require("gitsigns").diffthis("~") end, desc = "[Show] diff (~)" },

      { "<leader>gQ", function() require("gitsigns").setqflist("all") end, desc = "[Run] setqflist: file hunks" },
      { "<leader>gq", function() require("gitsigns").setqflist() end, desc = "[Run] setqflist: workspace hunks" },

      -- Text object
      { mode = { "o", "x" }, "ih", function() require("gitsigns").select_hunk() end, desc = "inner hunk" },
    },
    opts = {
      attach_to_untracked = true,
      current_line_blame = false,
      current_line_blame_formatter = function(_, info)
        local time = os.date("%Y-%m-%d", info.author_time)
        local username = (info.author_mail or ""):match("<(.-)@")
        local line = " " .. username .. "@ " .. time .. ": " .. (info.summary or "")
        return { { line, "GitSignsCurrentLineBlame" } }
      end,
      current_line_blame_opts = {
        ignore_whitespace = true,
      },
    },
  },
}
