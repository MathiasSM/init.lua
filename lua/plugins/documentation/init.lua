---@module "lazy"
---@type LazyPluginSpec[]
return {
  {
    "Zeioth/dooku.nvim",
    cmd = {
      "DookuAutoSetup",
      "DookuGenerate",
      "DookuOpen",
    },
    keys = {
      { "<leader>dg", "<cmd>DookuGenerate<cr>", desc = "[Dooku] Generate docs" },
      { "<leader>do", "<cmd>DookuOpen<cr>", desc = "[Dooku] Open generated" },
    },
    opts = {
      browser_cmd = require("utils").get_open_cmd(),
    },
  },

  {
    "luckasRanarison/nvim-devdocs",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    cmd = {
      "DevdocsFetch",
      "DevdocsInstall",
      "DevdocsOpen",
      "DevdocsOpenCurrent",
      "DevdocsToggle",
      "DevdocsUpdateAll",
    },
    keys = {
      { "<leader>dd", "<cmd>DevdocsOpen<cr>", desc = "[DevDocs] Open all docs!" },
      { "<leader>dc", "<cmd>DevdocsOpenCurrent<cr>", desc = "[DevDocs] Open for current ft" },
    },
    opts = {
      wrap = true,
      -- stylua: ignore
      ensure_installed = {
        "c", "cpp", "css", "cypress",
        "docker", "dom",
        "esbuild", "eslint",
        "gcc-12", "git", "gnu_make", "gnuplot", "go",
        "handlebars", "haskell-9", "homebrew", "html", "html", "htmx", "http",
        "javascript", "jest", "jq", "jquery", "jsdoc",
        "latex", "lodash-4", "lua-5.3",
        "mocha", "moment", "moment_timezone",
        "nginx", "nix", "node", "npm",
        "openjdk-8",
        "postgresql-16", "python-3.11",
        "react", "react_native", "react_router", "redux", "rust",
        "sass", "sqlite", "svg",
        "terraform", "typescript",
        "web_extensions", "webpack-5",
      },
    },
    config = function(_, opts)
      require("nvim-devdocs").setup(opts)
      vim.schedule(function() vim.cmd("DevdocsFetch") end)
      vim.notify('You may update docs with `nvim --headless +"DevdocsUpdateAll"`')
    end,
  },

  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true,
    cmd = { "Neogen" },
    keys = {
      { "<leader>da", "<cmd>Neogen<cr>", desc = "[Neogen] Add docstrings" },
    },
  },
}
