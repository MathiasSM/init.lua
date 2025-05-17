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

vim.keymap.set("n", "<space><space>", function()
  -- Defaults
  vim.lsp.config("*", {
    root_markers = { ".git", ".hg" },
    capabilities = require("plugins.lsp.configs").get_capabilities(),
  })
  for ls_name, ls_config in pairs(require("plugins.lsp.configs").get()) do
    vim.lsp.config(ls_name, ls_config)
  end
  require("mason-lspconfig").setup()
  vim.cmd("doautocmd BufReadPost") -- HACK: Without this, it doesn't attach
end, { desc = "[LSP] Turn on LSPs" })


---@type LazyPluginSpec[]
return require("utils").concat_tables(
  BASE, --
  require("plugins.lsp.servers"),
  require("plugins.lsp.fallback")
)
