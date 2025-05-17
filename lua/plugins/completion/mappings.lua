local M = {}

local function get_buf_next(with_snippet)
  return function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    if cmp.visible() then
      cmp.select_next_item()
    elseif with_snippet and luasnip.locally_jumpable(1) then
      luasnip.jump(1)
    else
      cmp.complete()
    end
  end
end

local function get_buf_prev(with_snippet)
  return function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    if cmp.visible() then
      cmp.select_prev_item()
    elseif with_snippet and luasnip.locally_jumpable(-1) then
      luasnip.jump(-1)
    else
      cmp.complete()
    end
  end
end

M.get_global = function()
  local mapping = require("cmp.config.mapping")
  local confirm_insert = require("cmp.types").cmp.ConfirmBehavior.Insert

  return mapping.preset.insert({
    ["<C-b>"] = { i = mapping.scroll_docs(-4) },
    ["<C-f>"] = { i = mapping.scroll_docs(4) },
    -- Safe newline: select if selecting, newline if not
    ["<C-Space>"] = require("cmp").mapping.confirm({
      behavior = confirm_insert,
      select = true,
    }),
    ["<Tab>"] = require("cmp").mapping(get_buf_next(true), { "i", "s" }),
    ["<S-Tab>"] = require("cmp").mapping(get_buf_prev(true), { "i", "s" }),
    ["<C-n>"] = require("cmp").mapping(get_buf_next(false), { "i", "s" }),
    ["<C-p>"] = require("cmp").mapping(get_buf_prev(false), { "i", "s" }),
  })
end

M.get_cmdline = function()
  local mapping = require("cmp.config.mapping")
  return mapping.preset.cmdline({
    ["<C-b>"] = { c = mapping.scroll_docs(-4) },
    ["<C-f>"] = { c = mapping.scroll_docs(4) },
    ["<C-n>"] = require("cmp").mapping(get_buf_next(false), { "c" }),
    ["<C-p>"] = require("cmp").mapping(get_buf_prev(false), { "c" }),
  })
end

return M
