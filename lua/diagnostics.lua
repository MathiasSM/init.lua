

local SOURCE_TRANSLATIONS = require('plugins.lsp.configs').source_translations

---@param diagnostic vim.Diagnostic
local function get_source(diagnostic)
  local source_translated = SOURCE_TRANSLATIONS[diagnostic.source]
  return source_translated and source_translated or diagnostic.source
end

---@param diagnostic vim.Diagnostic
---@param i integer
local function float_prefix(diagnostic, i, _)
  return string.format("%s. %s ", i, get_source(diagnostic))
end

---@param diagnostic vim.Diagnostic
local function float_suffix(diagnostic, _, _)
  return string.format(" [%s]", diagnostic.code)
end

local virtual_text_prefix = ""

---@param diagnostic vim.Diagnostic
local function virtual_text_suffix(diagnostic, _, _)
  return string.format(" [%s]  ", get_source(diagnostic))
end

local M = {}
---@type vim.diagnostic.Opts
M.opts = {
  update_in_insert = false,
  severity_sort = true,
  signs = {
    numhl = {
      [vim.diagnostic.severity.ERROR] = "ErrorMsg",
    },
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚",
      [vim.diagnostic.severity.WARN] = "󰀪",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "󰌶",
    },
  },
  underline = false,
  virtual_text = {
    source = false,
    prefix = virtual_text_prefix,
    suffix = virtual_text_suffix,
    severity = { min = vim.diagnostic.severity.WARN },
    virt_text_pos = 'eol_right_align',
  },
  virtual_lines = false,
  float = {
    scope = "line",
    source = false,
    prefix = float_prefix,
    suffix = float_suffix,
    severity_sort = true,
    border = "single",
  },
  jump = {
    wrap = true, -- loop around after last item
  },
}
return M
