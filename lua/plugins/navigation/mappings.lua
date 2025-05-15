local M = {}

M.oil = {
  {
    "<leader>m",
    "<cmd>Oil --float <cr>",
    desc = "[Oil] Open folder (float)",
  },
}
M.harpoon = {
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
}

return M
