local mason_tools_to_install = require("utils").concat_tables(
  require('plugins.tools.lsp'),
  require('plugins.tools.linters'),
  require('plugins.tools.formatters'),
  require('plugins.tools.debugging'),
  require('plugins.tools.other')
)

return {
  {
    "williamboman/mason.nvim",
    lazy = false, -- So path is up to date
    build = ":MasonUpdate",
    opts = {}
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "jay-babu/mason-nvim-dap.nvim",
    },
    cmd = {
      "MasonToolsInstall",
      "MasonToolsUpdate",
      "MasonToolsClean",
      -- For headless mode:
      "MasonToolsUpdateSync",
      "MasonToolsInstallSync",
    },
    opts = {
      ensure_installed = mason_tools_to_install,
      auto_update = false,
      run_on_start = false,
    }
  },

  { "neovim/nvim-lspconfig", lazy = true },
}
