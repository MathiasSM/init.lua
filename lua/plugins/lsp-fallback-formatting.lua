--- Formatting configuration
--
-- These formatters will be used if LSP provides no formatting capability
--
-- They should be installed first (via Mason or otherwise)
--
-- @module formatters

local formatters_by_filetype = {
  lua = { "stylua" },
  sh = { "shfmt" },
  sql = { "pgformat", "sqlfluff" },
}

--- Builds map<filetype -> formatter[]> expected by formatter.setup
-- All formatter configurations are opt-in (and so must be included here)
-- For each ft, formatters are applied in order.
-- The `*` applies to all filetypes.
local function get_formatters_by_ft()
  local registered_formatters = {}
  for ft, formatters in pairs(formatters_by_filetype) do
    registered_formatters[ft] = {}
    for _, formatter_name in ipairs(formatters) do
      table.insert(
        registered_formatters[ft],
        require("formatter.filetypes." .. ft)[formatter_name]
      )
    end
  end
  registered_formatters["*"] = { require("formatter.filetypes.any").remove_trailing_whitespace }
  return registered_formatters
end

local Utils = require("utils")





return {
  {
    "mhartington/formatter.nvim",
    keys = {
      {
        "<leader>p",
        function ()
          local lsp_clients = vim.lsp.get_clients()
          local formatters = {}

          for _, c in pairs(lsp_clients) do
            if c.server_capabilities.documentFormattingProvider then
              table.insert(formatters, { formatter = c.name, type = "LSP" })
            end
          end

          local non_lsp_formatters = formatters_by_filetype[vim.bo.filetype]
          for _, f in pairs(non_lsp_formatters) do
            table.insert(formatters, { formatter = f, type = "Non-LSP" })
          end

          if #formatters == 0 then
            vim.notify("No formatter available")
            return nil
          end

          -- if #formatters == 1 then
          --   local formatter = formatters[1]
          --   vim.notify("Formatting using active LSP: " .. formatter)
          --   vim.lsp.buf.format({ async = true, name = formatter })
          -- end

          vim.ui.select(
            formatters,
            {
              prompt = "Select a formatter",
              format_item = function(item) return "[" .. item.type .. "] " .. item.formatter end
            },
            function(item, idx)
              if not idx then
                vim.notify("No formatter selected")
                return
              end
              vim.notify("Formatting using: " .. item.formatter .. " (" .. item.type .. ")")
              if item.type == "LSP" then
                vim.lsp.buf.format({ async = true, name = item.formatter })
              else
                vim.cmd("FormatWrite " .. item.formatter)
              end
            end
          )
        end,
        desc = "[Format] Run",
      },
    },
    config = function()
      require("formatter").setup({
        logging = true,
        log_level = vim.log.levels.WARN,
        filetype = get_formatters_by_ft(),
      })
    end,
  },
}
