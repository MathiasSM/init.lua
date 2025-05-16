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

  ---@param action "⥤" | "" | "󰍴"
  local function get_notification(action)
    return function(ctx)
      local name = ctx.list.name == harpoon_default_list and "" or string.format("[%s] ", ctx.list.name)
      vim.notify(string.format("%s(%s) %s %s", name, ctx.idx, action, ctx.item.value))
    end
  end

  harpoon:extend({
    SELECT = get_notification("⥤"),
    ADD = get_notification(""),
    REMOVE = get_notification("󰍴"),
    REORDER = function() end,
  })

  local harpoon_extensions = require("harpoon.extensions")
  harpoon:extend(harpoon_extensions.builtins.highlight_current_file())

  vim.keymap.set("n", "<leader>0", function()
    local title = "Harpoon ⥤ " .. harpoon.config.settings.key()
    harpoon.ui:toggle_quick_menu(harpoon:list(), { title = title })
  end, { desc = "[Harpoon] Project files" })

  vim.keymap.set("n", "<leader>9", function() vim.notify("Not implemented!", vim.diagnostic.severity.ERROR) end)
end

return M
