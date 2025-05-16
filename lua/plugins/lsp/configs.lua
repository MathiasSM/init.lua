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

function M.get_capabilities()
  return vim.tbl_deep_extend(
    "force",
    vim.lsp.protocol.make_client_capabilities(),
    require("cmp_nvim_lsp").default_capabilities()
  )
end

return M
