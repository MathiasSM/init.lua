local M = {}

local function get_select_behavior()
  local cmp_types = require("cmp.types")
  return cmp_types.cmp.SelectBehavior.Select
end

local function select_item(dir)
  if dir == 1 then
    return require("cmp").select_next_item
  elseif dir == -1 then
    return require("cmp").select_prev_item
  else
    error("Wrong dir: "..dir)
  end
end

-- This block allows me to disable the trigger to use completions (not cmp as a whole, though)
local is_enabled = true
local cmp_toggle = Snacks.toggle.new({
  name = "Completion",
  get = function() return is_enabled end,
  set = function(state)
    require("cmp").setup.buffer({ enabled = state })
    is_enabled = state
  end,
})
Snacks.keymap.set("n", "<leader><leader>n", function() cmp_toggle:toggle() end , { desc= "Toggle completion"})

local function get_handler(dir, is_tab)
  return function(fallback)
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    if not is_enabled then
      return
    end

    -- If visible, move selection
    if cmp.visible() then
      local behavior = get_select_behavior()
      return select_item(dir)({ behavior = behavior })
    end

    -- Otherwise, if tab and within a snippet, navigate it
    if is_tab and luasnip.locally_jumpable(dir) then
      return luasnip.jump(dir)
    end

    -- In any other case, tab should be just tab
    if is_tab then
      return fallback()
    end

    -- But if it was not a simple tab, enter completion
    return cmp.complete()
  end
end

M.get_global = function()
  local mapping = require("cmp.config.mapping")
  local confirm_insert = require("cmp.types").cmp.ConfirmBehavior.Insert

  return mapping.preset.insert({
    ["<C-b>"] = { i = mapping.scroll_docs(-4) },
    ["<C-f>"] = { i = mapping.scroll_docs(4) },
    ["<C-Space>"] = require("cmp").mapping.confirm({ behavior = confirm_insert, select = true }),
    ["<CR>"] = require("cmp").mapping.confirm({ behavior = confirm_insert, select = true }),
    ["<Tab>"] = require("cmp").mapping(get_handler(1, true), { "i", "s" }),
    ["<S-Tab>"] = require("cmp").mapping(get_handler(-1, true), { "i", "s" }),
    ["<C-n>"] = require("cmp").mapping(get_handler(1, false), { "i", "s" }),
    ["<C-p>"] = require("cmp").mapping(get_handler(-1, false), { "i", "s" }),
  })
end

M.get_cmdline = function()
  local mapping = require("cmp.config.mapping")
  return mapping.preset.cmdline({
    ["<C-b>"] = { c = mapping.scroll_docs(-4) },
    ["<C-f>"] = { c = mapping.scroll_docs(4) },
    ["<C-n>"] = require("cmp").mapping(get_handler(1, false), { "c" }),
    ["<C-p>"] = require("cmp").mapping(get_handler(-1, false), { "c" }),
  })
end

return M
