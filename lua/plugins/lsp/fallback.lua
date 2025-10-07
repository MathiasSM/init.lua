local function lint_using(item)
  print("Linting using: " .. item.name)
  require('lint').try_lint(item.name)
end

local function select_linter_action(item, idx)
  if not idx then
    print("No linter selected")
    return
  end
  return lint_using(item)
end

--- Hack-ish way to list all linters provided by nvim-lint
local function get_available_linters()
  local linters = {}

  local linters_path = package.searchpath('lint.linters', package.path)
  if not linters_path then
    return linters
  end

  local dir_path = linters_path:match("(.+)/[^/]+$")
  local handle = io.popen('ls "' .. dir_path .. '"')
  if not handle then
    return linters
  end

  for filename in handle:lines() do
    local linter_name = filename:match("^(.+)%.lua$")
    if linter_name then
      table.insert(linters, { name = linter_name })
    end
  end

  handle:close()
  return linters
end

local function pick_linter()
  local linters = get_available_linters()
  if #linters == 0 then
    vim.notify("No linters available")
    return
  end
  vim.ui.select(linters, { prompt = "Select a linter" }, select_linter_action)
end

local function display_status()
  local linters = require("lint").get_running()
  if #linters == 0 then
    print("󰦕 Nothing running")
    return
  end
  print("󱉶 " .. table.concat(linters, ", "))
end


local function remap_severity(linter_name, severity)
  local lint = require('lint')
  return require("lint.util").wrap(lint.linters[linter_name], function(diagnostic)
    diagnostic.severity = severity
    return diagnostic
  end)
end

local function setup_linters()
  local lint = require("lint")
  lint.linters_by_ft = {}
  -- Programming
  lint.linters_by_ft.bash       = { "bash", "shellcheck" }
  lint.linters_by_ft.cfn        = { "cfn_lint", "cfn_nag" }
  lint.linters_by_ft.css        = { "stylelint" }
  lint.linters_by_ft.dotenv     = { "dotenv_linter" }
  lint.linters_by_ft.help       = { }
  lint.linters_by_ft.hledger    = { "hledger" }
  lint.linters_by_ft.java       = { } -- Checkstyle is too annoying to configure
  lint.linters_by_ft.javascript = { }
  lint.linters_by_ft.latex      = { "chktex" }
  lint.linters_by_ft.make       = { "checkmake" }
  lint.linters_by_ft.sql        = { "sqlfluff" }
  lint.linters_by_ft.systemd    = { "systemdlint" }
  lint.linters_by_ft.typescript = { }
  lint.linters_by_ft.vim        = { "vint" }
  lint.linters_by_ft.zsh        = { "zsh" } -- ShellCheck doesn't work with zsh
  -- Markup/prose
  local prose = { "alex", "proselint", "vale", "write_good" }
  lint.linters_by_ft.markdown = prose
  lint.linters_by_ft.text = prose
  -- Others (incl. prose+programming)
  lint.linters_by_ft.gitcommit = { "commitlint", "gitlint" }
  lint.linters_by_ft.html = { "htmlhint" }
  lint.linters_by_ft["*"] = { "cspell", "blocklint", "typos", "woke" }
  -- Linters configuration
  lint.linters.eslint_d.env = { ESLINT_D_MISS = 0 }
  lint.linters.cspell = remap_severity("alex", vim.diagnostic.severity.HINT)
  lint.linters.cspell = remap_severity("cspell", vim.diagnostic.severity.HINT)
  lint.linters.cspell = remap_severity("proselint", vim.diagnostic.severity.HINT)
  lint.linters.cspell = remap_severity("woke", vim.diagnostic.severity.HINT)
  lint.linters.cspell = remap_severity("write_good", vim.diagnostic.severity.HINT)
end

---@type LazyPluginSpec[]
return {
  {
    -- These are supposed to be fallbacks to LSPs for the most part
    "mfussenegger/nvim-lint",
    event = { "BufWritePost", "BufRead" },
    cmd = { "Lint", "LintProgress" },
    config = function()
      setup_linters()

      -- Run on save/read
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufRead" }, {
        callback = function() require("lint").try_lint() end,
      })

      -- Create commands
      vim.api.nvim_create_user_command(
        "LintProgress",
        display_status,
        { desc = "[Linters] Display current status" }
      )
      vim.api.nvim_create_user_command(
        "Lint",
        pick_linter,
        { desc = "[Linters] Try one" }
      )
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
