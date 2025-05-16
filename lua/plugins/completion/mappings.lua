local M = {}

local mapping = require("cmp.config.mapping")
local confirm_behavior = require("cmp.types").cmp.ConfirmBehavior.Replace

M.global = mapping.preset.insert({
  ["<C-b>"] = { i = mapping.scroll_docs(-4) },
  ["<C-f>"] = { i = mapping.scroll_docs(4) },
  ["<CR>"] = { i = mapping.confirm({ select = true, behavior = confirm_behavior }) },
})

M.cmdline = mapping.preset.cmdline({
  ["<C-b>"] = { c = mapping.scroll_docs(-4) },
  ["<C-f>"] = { c = mapping.scroll_docs(4) },
  ["<C-n>"] = {
    c = function()
      local cmp = require("cmp")
      if cmp.visible() then
        cmp.select_next_item()
      else
        cmp.complete()
      end
    end,
  },
  ["<C-p>"] = {
    c = function()
      local cmp = require("cmp")
      if cmp.visible() then
        cmp.select_prev_item()
      else
        cmp.complete()
      end
    end,
  },
})

return M
