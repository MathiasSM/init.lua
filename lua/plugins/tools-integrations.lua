--- Integration with external tools
--
-- @module

return {
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
      copy_sync = {
        redirect_to_clipboard = true,
      },
      navigation = {
        enable_default_keybindings = false,
      },
      resize = {
        enable_default_keybindings = false,
      },
      swap = {
        enable_default_keybindings = false,
      }
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
}
