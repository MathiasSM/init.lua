--- Documentation-related plugins
--
-- * Generation of documentation tags
-- * Generation of HTML/other documentation pages from comment tags
-- * Find documentation
--
-- @module documentation

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
    "luc-tielen/telescope_hoogle",
    dependencies = { "nvim-telescope/telescope.nvim" },
    build = function()
      if vim.fn.executable("hoogle") ~= 1 then
        vim.notify(
          "Did not find `hoogle` executable!\nInstall it with `cabal install hoogle`",
          vim.log.levels.ERROR
        )
        return
      end
      vim.notify("Running `hoogle generate &`", vim.log.levels.INFO)
      vim.fn.system("hoogle generate &")
    end,
    keys = { { "<leader>dh", "<cmd>Telescope hoogle<cr>", desc = "[Telescope] Hoogle" } },
    config = function() require("telescope").load_extension("hoogle") end,
  },

  {
    "barrett-ruth/http-codes.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    keys = {
      { "<leader>fa", "<cmd>HTTPCodes<cr>", desc = "[Telescope] HTTP codes" },
    },
    config = true
  },
}
