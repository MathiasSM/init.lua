local M = {}

--- LSPs custom configurations
---@return table<string, vim.lsp.Config>
function M.get()
  return {
    ["bashls"] = {
      filetypes = { "sh", "bash", "zsh" },
    },
    ["jsonls"] = {
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    },
  }
end

return M
