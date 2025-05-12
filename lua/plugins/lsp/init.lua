local formatting_utils = require('plugins.lsp.formatting')

---@module "lazy"
---@type LazyPluginSpec[]
return {
  {
    "neovim/nvim-lspconfig",
    keys = {
      {
        "<space><cr>",
        function() end,
        desc = "[LSP] Turn on LSPs",
      },
    },
    dependencies = { "adoyle-h/lsp-toggle.nvim" },
    config = function()
      require("lsp-toggle").setup({ create_cmds = true, telescope = false })

      local capabilities = vim.tbl_deep_extend("force",
        vim.lsp.protocol.make_client_capabilities(),
        require('cmp_nvim_lsp').default_capabilities()
      )

      -- Defaults
      vim.lsp.config('*', {
        root_markers = { '.git', '.hg' },
        capabilities = capabilities
      })

      for ls_name, ls_config in pairs(require('plugins.lsp.configs').get()) do
        vim.lsp.config(ls_name, ls_config)
      end

      require("mason-lspconfig")

      vim.cmd("doautocmd BufReadPost") -- HACK: Without this, it doesn't attach
    end,
  },

  {
    "mason-org/mason-lspconfig.nvim",
    lazy = true,
    opts = {
      automatic_enable = true
    }
  },

  { "folke/lazydev.nvim", ft = "lua", config = true },
  { "Bilal2453/luvit-meta", ft = "lua" },
  { "b0o/schemastore.nvim", ft = { "json", "jsonc", "yaml" } },
  { "mfussenegger/nvim-jdtls", ft = "java" },

  {
    "mhartington/formatter.nvim",
    keys = {
      {
        "<leader>p",
        formatting_utils.format_buffer,
        desc = "[Format] Run",
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

