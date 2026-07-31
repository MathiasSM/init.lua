local M = {}

---@module "oil"
---@type oil.Config
M.opts = { ---@diagnostic disable-line: missing-fields
  default_file_explorer = true,
  skip_confirm_for_simple_edits = true,
  constrain_cursor = "editable",
  columns = {
    "icon",
    { "size", highlight = "Special" },
    { "permissions", highlight = "Comment" },
  },
  lsp_file_methods = { ---@diagnostic disable-line: missing-fields
    -- Autosaved unmodified buffers after a LSP rename action
    autosave_changes = "unmodified",
  },
  float = { ---@diagnostic disable-line: missing-fields
    max_width = 0.8,
    max_height = 0.8,
    preview_split = "below",
    border = "rounded",
  },
  confirmation = { ---@diagnostic disable-line: missing-fields
    border = "rounded"
  },
  progress = { ---@diagnostic disable-line: missing-fields
    border = "rounded"
  },
  ssh = { ---@diagnostic disable-line: missing-fields
    border = "rounded"
  },
  keymaps_help = { ---@diagnostic disable-line: missing-fields
    border = "rounded"
  },
  preview_win = { ---@diagnostic disable-line: missing-fields
    disable_preview = function(filename)
      -- stylua: ignore
      return (filename:find("secret", 1, true) ~= nil)
          or (filename:find(".env", 1, true) ~= nil)
    end,
  },
  view_options = { ---@diagnostic disable-line: missing-fields
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
}

return M
