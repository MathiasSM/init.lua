local M = {}

--- LSPs custom configurations
---@return table<string, vim.lsp.Config>
function M.get()
  ---@type table<string, vim.lsp.Config>
  return {
    ["jsonls"] = {
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    },
    -- https://luals.github.io/wiki/settings/
    ["lua_ls"] = {
      settings = {
        Lua = {
          completion = {
            callSnippet = "Both",
            showWord = "Disable",
          },
          -- Prefer stylua. Needs on_attach to disable the server capabilities
          format = { enable = false },
          hint = {
            enable = true,
            paramName = "Literal",
            setType = true,
          },
        },
      },
      on_attach = function(client, _)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      end,
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

M.source_translations = {
  -- lua_ls
  ["Lua Syntax Check."] = "lua_ls 󰬴 ",
  ["Lua Diagnostics."] = "lua_ls 󱎸 ",
}

return M
