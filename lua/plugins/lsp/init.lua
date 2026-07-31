local formatting_utils = require("plugins.lsp.formatting")

---@type LazyPluginSpec[]
local BASE = {
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    lazy = true,
    opts = {
      automatic_enable = {
        exclude = {
          "jdtls", -- nvim-jdtls triggers the start already
          "ts_ls", -- typescript-tools takes priority
          "hls", -- haskell-tools handles it
        }
      }
    }
  },

  {
    "mhartington/formatter.nvim",
    keys = {
      {
        "<leader>p",
        formatting_utils.format_buffer, -- TODO: Move, since this uses LSP as well
        desc = "[Format] Run",
        mode = { "n", "v" },
      },
    },
    config = function()
      require("formatter").setup({
        logging = true,
        log_level = vim.log.levels.WARN,
        filetype = formatting_utils.get_formatters_by_ft(),
      })
    end,
  },
}


---@type LazyPluginSpec[]
return require("utils").concat_tables(
  BASE, --
  require("plugins.lsp.servers"),
  require("plugins.lsp.fallback")
)
