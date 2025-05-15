local M = {}

function M.setup()
  local harpoon = require("harpoon")
  local harpoon_default_list = require("harpoon"):info().default_list_name
  harpoon:setup({
    settings = {
      save_on_toggle = true,
      sync_on_ui_close = true,
      key = vim.uv.cwd, -- Grouping key for lists,
    },
  })
  local get_list_name = function(name)
    if name == harpoon_default_list then return "" end
    return "[" .. name .. "]"
  end
  harpoon:extend({
    SELECT = function(ctx)
      vim.notify(
        get_list_name(ctx.list.name) .. " ⥤  " .. ctx.idx .. ": " .. ctx.item.value
      )
    end,
    ADD = function(ctx)
      vim.notify(get_list_name(ctx.list.name) .. "  " .. ctx.item.value)
    end,
    REMOVE = function(ctx)
      vim.notify(get_list_name(ctx.list.name) .. " 󰍴 " .. ctx.item.value)
    end,
    REORDER = function() end,
  })

  local harpoon_extensions = require("harpoon.extensions")
  harpoon:extend(harpoon_extensions.builtins.highlight_current_file())

  vim.keymap.set("n", "<leader>0", function()
    local title = "Harpoon ⥤ " .. harpoon.config.settings.key()
    harpoon.ui:toggle_quick_menu(harpoon:list(), { title = title })
  end, { desc = "[Harpoon] Project files" })


  vim.keymap.set("n", "<leader>9", function()
    vim.notify("Not implemented!", vim.diagnostic.severity.ERROR)
  end)
end

return M
