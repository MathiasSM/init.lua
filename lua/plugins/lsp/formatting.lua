local M = {}

---@class FormatterType
---@field name string
---@field type "LSP" | "Non-LSP"

--- Map filetype -> formatter list. Formatters use mason name
---@type table<string, string[]>
local FORMATTERS_BY_FT = {
  lua = { "stylua" },
  sh = { "shfmt" },
  sql = { "pgformat", "sqlfluff" },
}

--- Builds map<filetype -> formatter[]> expected by formatter.setup
-- All formatter configurations are opt-in (and so must be included here)
-- For each ft, formatters are applied in order.
-- The `*` applies to all filetypes.
function M.get_formatters_by_ft()
  local registered_formatters = {}
  local missing = nil
  for ft, formatters in pairs(FORMATTERS_BY_FT) do
    registered_formatters[ft] = {}
    for _, formatter_name in ipairs(formatters) do
      if require("mason-registry").is_installed(formatter_name) then
        table.insert(registered_formatters[ft], require("formatter.filetypes." .. ft)[formatter_name])
      else
        missing = missing or {}
        missing[ft] = missing[ft] or {}
        table.insert(missing[ft], formatter_name)
      end
    end
  end
  if missing ~= nil then
    local msg = "While setting up format, skipped missing formatters:"
    for ft, missing_formatters in pairs(missing) do
      msg = string.format("%s\n- %s:\t%s", msg, ft, table.concat(missing_formatters, ", "))
    end
    vim.notify(msg, vim.log.levels.WARN)
  end
  registered_formatters["*"] = { require("formatter.filetypes.any").remove_trailing_whitespace }
  return registered_formatters
end

---@param item FormatterType
local function format_using(item)
  print("Formatting using: " .. item.name .. " (" .. item.type .. ")")
  if item.type == "LSP" then
    vim.lsp.buf.format({ async = true, name = item.name })
  else
    vim.cmd("FormatWrite " .. item.name)
  end
end

---@param item FormatterType
---@param idx number
local function select_formatter_action(item, idx)
  if not idx then
    print("No formatter selected")
    return
  end
  return format_using(item)
end

--- Formats the current buffer by using the LSP or configured formatting tool
---
--- If more than one is available, shows a picker for the user
---
---@return nil
function M.format_buffer()
  local formatters = {}

  local lsp_clients = vim.lsp.get_clients()
  for _, c in pairs(lsp_clients) do
    if c.server_capabilities.documentFormattingProvider then
      table.insert(formatters, { name = c.name, type = "LSP" })
    end
  end

  local non_lsp_formatters = FORMATTERS_BY_FT[vim.bo.filetype] or {}
  for _, name in pairs(non_lsp_formatters) do
    table.insert(formatters, { name = name, type = "Non-LSP" })
  end

  if #formatters == 0 then
    vim.notify("No formatter available")
    return nil
  end

  if #formatters == 1 then return format_using(formatters[1]) end

  vim.ui.select(formatters, {
    prompt = "Select a formatter",
    format_item = function(item) return "[" .. item.type .. "] " .. item.name end,
  }, select_formatter_action)
end

return M
