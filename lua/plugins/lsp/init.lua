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
        },
      },
    },
  },

  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvimtools/none-ls.nvim" },
    keys = {
      {
        "<leader>p",
        function() vim.lsp.buf.format({ async = true }) end,
        desc = "[Format] Run",
        mode = { "n", "v" },
      },
    },
    config = function()
      require("null-ls").setup({ border = "rounded" })
      -- Auto-register sources installed via mason
      require("mason-null-ls").setup({
        ensure_installed = {},
        handlers = {}, -- Auto-register every source installed via Mason
        automatic_installation = false, -- Install tools explicitly via :Mason
      })
    end,
  },
}

---@type LazyPluginSpec[]
return require("utils").concat_tables(
  BASE, -- 
  require("plugins.lsp.servers"),
  require("plugins.lsp.rulebook")
)
