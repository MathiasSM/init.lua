local encoding = {
  "encoding",
  cond = function() return "utf-8" ~= vim.opt.fileencoding:get() end,
}

local short_mode = {
  "mode",
  fmt = function(str) return str:sub(1, 1) end,
}

local filename = {
  "filename",
  newfile_status = true,
  path = 1,
  separator = "",
}

local get_lsp_status = function()
  return {
    require('plugins.statusline.lsp_status_simple'),
    display_mode = 'count'
  }
end


local treesitter_node = {
  function()
    local node = require("nvim-treesitter.ts_utils").get_node_at_cursor()
    if node == nil then return nil end
    return "[" .. node:type() .. "]"
  end,
  color = "lualine_c_inactive",
}

---@module "lazy"
---@type LazyPluginSpec[]
return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      local lualine_a = { short_mode }
      local inactive_a = {}
      local lualine_b = { "branch", "diff" }
      local inactive_b = lualine_b
      local lualine_c = { filename }
      local inactive_c = { filename }

      local lualine_x = {
        treesitter_node,
        "diagnostics",
        "filetype",
        get_lsp_status(),
        encoding,
        "fileformat",
      }
      local inactive_x = {
        "diagnostics",
        { "filetype", colored = false },
        encoding,
        "fileformat",
      }
      local lualine_y = { "selectioncount", "searchcount", "progress" }
      local inactive_y = { "progress" }
      local lualine_z = { "location" }
      local inactive_z = lualine_z
      require("lualine").setup({
        options = {
          theme = "auto",
          icons_enabled = true,
        },
        sections = {
          lualine_a = lualine_a,
          lualine_b = lualine_b,
          lualine_c = lualine_c,
          lualine_x = lualine_x,
          lualine_y = lualine_y,
          lualine_z = lualine_z,
        },
        inactive_sections = {
          lualine_a = inactive_a,
          lualine_b = inactive_b,
          lualine_c = inactive_c,
          lualine_x = inactive_x,
          lualine_y = inactive_y,
          lualine_z = inactive_z,
        },
        tabline = {
          -- NOTE: If I ever need a tabbar:
          -- lualine_b = {{ "tabs", mode = 2, path = 1, separator = {left='',right=''}}},
        },
        winbar = {},
        inactive_winbar = {},
        extensions = {
          "fugitive",
          --"fzf",
          "lazy",
          "man",
          "mason",
          --"nvim-dap-ui",
          "symbols-outline",
          "oil",
          "quickfix",
          "trouble",
        },
      })
    end,
  },
}
