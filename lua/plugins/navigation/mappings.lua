local M = {}

---@type LazyKeysSpec[]
M.oil = {
  { "<leader>m", function() require("oil").toggle_float() end, desc = "[Oil] Open folder (float)" },
}

local function add() require("harpoon"):list():add() end
local function remove() require("harpoon"):list():remove() end
local function prev() require("harpoon"):list():prev({ ui_nav_wrap = true }) end
local function next() require("harpoon"):list():next({ ui_nav_wrap = true }) end

---@return LazyKeysSpec
local function number_map(num)
  return {
    string.format("<leader>%s", num),
    function() require("harpoon"):list():select(num) end,
    desc = string.format("[Harpoon] Go to %s", num),
  }
end

---@type LazyKeysSpec[]
M.harpoon = {
  { "<leader>9", desc = "[Harpoon] Select List" },
  { "<leader>0", desc = "[Harpoon] Project Files" },

  { "<leader>=", add, desc = "[Harpoon] Add current to list" },
  { "<leader>-", remove, desc = "[Harpoon] Remove current from list" },

  number_map(1),
  number_map(2),
  number_map(3),
  number_map(4),
  number_map(5),

  -- Toggle previous & next buffers stored within harpoon list
  { "<leader>[", prev, desc = "[Harpoon] Go to previous" },
  { "<leader>]", next, desc = "[Harpoon] Go to next" },
}

return M
