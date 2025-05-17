---@type LazyPluginSpec[]
return {
  {
    -- These are supposed to be fallbacks to LSPs for the most part
    "mfussenegger/nvim-lint",
    event = { "BufWritePost", "BufRead" },
    config = function()
      require("lint").linters_by_ft = {
        bash = { "shellcheck" },
        cfn = { "cfn_lint", "cfn_nag" },
        css = { "stylelint" },
        dotenv = { "dotenv_linter" },
        gitcommit = { "commitlint", "gitlint" },
        help = {},
        html = { "htmlhint" },
        java = { "checkstyle" },
        javascript = { "eslint_d" },
        latex = { "chktex" },
        markdown = { "alex", "proselint", "vale", "write_good" },
        sql = { "sqlfluff" },
        typescript = { "eslint_d" },
        vim = { "vint" },
        zsh = { "zsh" },
        ["*"] = { "blocklint", "typos", "woke" },
      }
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufRead" }, {
        callback = function() require("lint").try_lint() end,
      })

      vim.api.nvim_create_user_command("LintProgress", function()
        local linters = require("lint").get_running()
        if #linters == 0 then
          print("󰦕 Nothing running")
          return
        end
        print("󱉶 " .. table.concat(linters, ", "))
      end, { desc = "[Linters] Display current status" })
    end,
  },

  {
    "chrisgrieser/nvim-rulebook",
    keys = {
      {
        "<leader>ri",
        function() require("rulebook").ignoreRule() end,
        desc = "[Rules] Ignore",
      },
      {
        "<leader>rl",
        function() require("rulebook").lookupRule() end,
        desc = "[Rules] Lookup",
      },
      {
        "<leader>ry",
        function() require("rulebook").yankDiagnosticCode() end,
        desc = "[Rules] Yank code",
      },
    },
    config = true,
  },
}
