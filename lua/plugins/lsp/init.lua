local formatting_utils = require("plugins.lsp.formatting")

vim.keymap.set("n", "<space>", function()
  vim.notify("Enabling LSPs!")
  require("lsp-toggle").setup({ create_cmds = true, telescope = false })
  -- Defaults
  vim.lsp.config("*", {
    root_markers = { ".git", ".hg" },
    capabilities = require("plugins.lsp.configs").get_capabilities(),
  })
  for ls_name, ls_config in pairs(require("plugins.lsp.configs").get()) do
    vim.lsp.config(ls_name, ls_config)
  end
  require("mason-lspconfig").setup({})
  vim.cmd("doautocmd BufReadPost") -- HACK: Without this, it doesn't attach
end, { desc = "[LSP] Turn on LSPs" })

---@type LazyPluginSpec[]
local BASE = {
  {
    "neovim/nvim-lspconfig",
    lazy = false,
  },

  { "adoyle-h/lsp-toggle.nvim", lazy = true },

  {
    "mason-org/mason-lspconfig.nvim",
    lazy = true,
    opts = { automatic_enable = true },
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

return require("utils").concat_tables(
  BASE, --
  require("plugins.lsp.servers"),
  require("plugins.lsp.fallback")
)
