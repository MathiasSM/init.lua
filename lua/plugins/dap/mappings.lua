local set_full_breakpoint = function()
  local cond = vim.fn.input("Breakpoint condition: ")
  local hits = vim.fn.input("Num. hits condition: ")
  local logs = vim.fn.input("Log message: ")
  cond = cond == "" and nil or cond
  hits = hits == "" and nil or tostring(hits)
  logs = logs == "" and nil or logs
  require("dap").set_breakpoint(cond, hits, logs)
end

local set_log_point = function()
  local logs = vim.fn.input("Log message: ")
  logs = logs == "" and nil or logs
  require("dap").set_breakpoint(nil, nil, logs)
end

local set_exception_breakpoint = function() require("dap").set_exception_breakpoints({ "all" }) end

local show_frames = function()
  local widgets = require("dap.ui.widgets")
  widgets.centered_float(widgets.frames)
end

local show_scopes = function()
  local widgets = require("dap.ui.widgets")
  widgets.centered_float(widgets.scopes)
end

local select_and_set_log_level = function()
  vim.ui.select({ "TRACE", "DEBUG", "INFO", "WARN", "ERROR" }, { prompt = "Log level: " }, function(level)
    require("dap").set_log_level(level)
    vim.notify("Log Level: " .. level, "info")
  end)
end

local virtual_text = Snacks.toggle.new({
  name = "DAP Virtual Text",
  get = function() return require("nvim-dap-virtual-text").is_enabled() end,
  set = function(state)
    if state then
      require("nvim-dap-virtual-text").enable()
    else
      require("nvim-dap-virtual-text").disable()
    end
  end,
})

---@type wk.Spec[]
return {
  -- Breakpoints
  { "<leader>bb", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
  { "<leader>bl", set_log_point, desc = "Set Log Point" },
  { "<leader>be", set_exception_breakpoint, desc = "Set Exception Breakpoint" },
  { "<leader>ba", set_full_breakpoint, desc = "Set Breakpoint (*)" },
  { "<leader>bB", function() require("dap").list_breakpoints() end, desc = "List breakpoints" },
  { "<leader>bC", function() require("dap").clear_breakpoints() end, desc = "Clear all breakpoints" },

  -- Session management
  { "<leader>bc", function() require("dap").continue() end, desc = "Continue / Start New" },
  { "<leader>bq", function() require("dap").terminate() end, desc = "Terminate" },

  -- Stepping
  { "<leader>bi", function() require("dap").step_into() end, desc = "Step Into" },
  { "<leader>bo", function() require("dap").step_out() end, desc = "Step Out" },
  { "<leader>bO", function() require("dap").step_over() end, desc = "Step Over" },
  { "<leader>bP", function() require("dap").pause() end, desc = "Pause" },

  -- REPL / UI
  { "<leader>br", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
  { "<leader>bu", function() require("dapui").toggle({}) end, desc = "UI Toggle" }, -- NOTE: Not using Snacks
  { "<leader>be", function() require("dapui").eval() end, desc = "Eval", mode = { "n", "v" } },

  -- Inspecting
  { "<leader>bh", function() require("dap.ui.widgets").hover() end, mode = { "n", "v" }, desc = "Hover" },
  { "<leader>bp", function() require("dap.ui.widgets").preview() end, mode = { "n", "v" }, desc = "Preview" },
  { "<leader>bf", show_frames, desc = "Show Frames" },
  { "<leader>bs", show_scopes, desc = "Show Scopes" },

  -- Diagnostics
  { "<leader>bL", select_and_set_log_level, desc = "Set log level" },
  { "<leader>bv", function() virtual_text:toggle() end, desc = "Toggle virtual text" },

  -- { "<leader>bl", function() require("dap").run_last() end, desc = "Run Last" },

  -- Testing
  { "<leader>tA", function() require("neotest").run.run(vim.loop.cwd()) end, desc = "Run Project" },
  { "<leader>tt", function() require("neotest").run.run() end, desc = "Run Nearest" },
  { "<leader>tT", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File" },
  ---@diagnostic disable-next-line: missing-fields
  { "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Debug Nearest" },
  ---@diagnostic disable-next-line: missing-fields
  { "<leader>tD", function() require("neotest").run.run({vim.fn.expand("%"), strategy = "dap"}) end, desc = "Debug File"},
  { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop" },

  { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary" },
  { "<leader>to", function() require("neotest").output.open({enter = true, auto_close = true}) end, desc = "Show Output"},
  { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel" },
}
