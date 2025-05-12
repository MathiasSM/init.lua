--- Navigation between files and across directories/projects
-- Directories/file visualization definedin other files

---@module "lazy"
---@type LazyPluginSpec[]
return {
  {
    "ThePrimeagen/harpoon", -- NOTE: Consider cbochs/grapple.nvim or desdic/marlin.nvim
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "Harpoon" },
    keys = {
       -- First few are defined in config
      "<C-e>",
      {
        "<leader>9",
        desc = "[Harpoon] Select List",
      },
      {
        "<leader>0",
        desc = "[Harpoon] Project Files",
      },
      {
        "<leader>=",
        function() require("harpoon"):list():add() end,
        desc = "[Harpoon] Add current to list",
      },
      {
        "<leader>-",
        function() require("harpoon"):list():remove() end,
        desc = "[Harpoon] Remove current from list",
      },

      {
        "<leader>1",
        function() require("harpoon"):list():select(1) end,
        desc = "[Harpoon] Go to 1",
      },
      {
        "<leader>2",
        function() require("harpoon"):list():select(2) end,
        desc = "[Harpoon] Go to 2",
      },
      {
        "<leader>3",
        function() require("harpoon"):list():select(3) end,
        desc = "[Harpoon] Go to 3",
      },
      {
        "<leader>4",
        function() require("harpoon"):list():select(4) end,
        desc = "[Harpoon] Go to 4",
      },

      -- Toggle previous & next buffers stored within harpoon list
      {
        "<leader>[",
        function() require("harpoon"):list():prev({ ui_nav_wrap = true }) end,
        desc = "[Harpoon] Go to previous",
      },
      {
        "<leader>]",
        function() require("harpoon"):list():next({ ui_nav_wrap = true }) end,
        desc = "[Harpoon] Go to next",
      },
    },
    config = function()
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


      local lists_list = harpoon:list("LISTS")

      vim.keymap.set("n", "<leader>9", function()
        vim.notify("Not implemented!", vim.diagnostic.severity.ERROR)
      end)
    end,
  },
}
