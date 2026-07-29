-- Default query group: textobjects

-- Select
local function map_select()
  local to_select = require("nvim-treesitter-textobjects.select").select_textobject
  local mode = { "x", "o" }
  local letter_to_query = {
    A = "@assignment",
    B = "@block",
    a = "@parameter", -- argument
    c = "@class",
    f = "@function",
    m = "@function", -- method
    P = "@parameter",
    l = "@loop",
    r = "@regex",
  }
  for letter, value in pairs(letter_to_query) do
    vim.keymap.set(mode, "i" .. letter, function() to_select(value .. ".inner") end, { desc = "inner " .. value })
    vim.keymap.set(mode, "a" .. letter, function() to_select(value .. ".outer") end, { desc = "outer " .. value })
  end
  vim.keymap.set(mode, "i/", function() to_select("@comment.inner") end, { desc = "inner @comment" })
  vim.keymap.set(mode, "a/", function() to_select("@comment.outer") end, { desc = "outer @comment" })
end

-- Go To
local function map_move()
  local ts_to_move = "nvim-treesitter-textobjects.move"
  local goto_next_start = require(ts_to_move).goto_next_start
  local goto_next_end = require(ts_to_move).goto_next_end
  local goto_previous_start = require(ts_to_move).goto_previous_start
  local goto_previous_end = require(ts_to_move).goto_previous_end
  -- local function goto_next() return require(ts_to_move).goto_next end
  -- local function goto_previous() return require(ts_to_move).goto_previous end
  local mode = { "n", "x", "o" }
  local letter_to_query = {
    f = { query = "@function.outer", group = "textobjects" },
    c = { query = "@class.outer", group = "textobjects" },
    o = { query = { "@loop.inner", "@loop.outer" }, group = "textobjects" },
    s = { query = "@local.scope", group = "locals" },
    z = { query = "@fold", group = "folds" },
  }
  for letter, value in pairs(letter_to_query) do
    local query = value.query
    local group = value.group
    if type(query) == "table" then query = table.concat(query, " || ") end
    vim.keymap.set(mode, "]" .. letter, function() goto_next_start(query, group) end, { desc = query .. " start" })
    vim.keymap.set(mode, "]" .. letter:upper(), function() goto_next_end(query, group) end, { desc = query .. " end" })
    vim.keymap.set(mode, "[" .. letter, function() goto_previous_start(query, group) end, { desc = query .. " start" })
    vim.keymap.set(
      mode,
      "[" .. letter:upper(),
      function() goto_previous_end(query, group) end,
      { desc = query .. " end" }
    )
  end
end

-- Swap
local function map_swap()
  local swap_next = require("nvim-treesitter-textobjects.swap").swap_next
  local swap_previous = require("nvim-treesitter-textobjects.swap").swap_previous
  vim.keymap.set("n", "<leader>}p", function() swap_next("@parameter.inner") end, { desc = "parameter" })
  vim.keymap.set("n", "<leader>{p", function() swap_previous("@parameter.inner") end, { desc = "parameter" })
end

map_select()
map_move()
map_swap()
