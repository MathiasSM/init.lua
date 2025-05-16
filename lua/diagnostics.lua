--- Diagnostic-related configurations
-- @script

local M = {}
---@type vim.diagnostic.Opts
M.opts = {
  update_in_insert = false,
  severity_sort = true,
  signs = {
    priority = 10,
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚",
      [vim.diagnostic.severity.WARN] = "󰀪",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "󰌶",
    },
  },
  underline = {
    severity = { min = vim.diagnostic.severity.ERROR },
  },
  virtual_text = {
    source = false,
    prefix = "●",
    severity = { min = vim.diagnostic.severity.WARN },
  },
  virtual_lines = false,
  float = {
    scope = "line",
    header = "Diagnostics",
    source = true,
    severity_sort = true,
    border = "single",
  },
  jump = {
    wrap = true, -- loop around after last item
  },
}
return M
