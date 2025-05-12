return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    keys = {
      {
        "<leader>m",
        "<cmd>Oil --float <cr>",
        desc = "[Oil] Open folder (float)",
      },
    },
    opts = {
      default_file_explorer = true,
      skip_confirm_for_simple_edits = true,
      constrain_cursor = "editable",
      columns = {
        "icon",
        { "size", highlight = "Special" },
        { "permissions", highlight = "Comment" },
      },
      float = {
        max_width = .8,
        max_height = .8,
      },
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ["g?"] = "actions.show_help",
        ["s"] = "actions.select_vsplit",
        ["S"] = "actions.select_split",
        ["<esc>"] = "actions.close",
        ["q"] = "actions.close",
        ["R"] = "actions.refresh",
        ["<BS>"] = "actions.parent",
        ["H"] = "actions.toggle_hidden",
        ["<leader>m"] = "actions.close",
      },
    },
  },
}
