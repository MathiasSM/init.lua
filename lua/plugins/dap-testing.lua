--- Plugins for running tests
--
-- Some interact with the DAP
--
-- @module testing

return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- Used adapters
      "nvim-neotest/neotest-jest",
      "mrcjkb/neotest-haskell",
      "rcasia/neotest-java",
      "rcasia/neotest-bash",
      "nvim-neotest/neotest-plenary",
      { "nvim-neotest/neotest-vim-test", dependencies = "vim-test/vim-test" },
    },
    keys = {
      {
        "<leader>tt",
        function() require("neotest").run.run() end,
        desc = "[Test] Run Nearest",
      },
      {
        "<leader>td",
        ---@diagnostic disable-next-line: missing-fields
        function() require("neotest").run.run({ strategy = "dap" }) end,
        desc = "[Test] Debug Nearest",
      },
      {
        "<leader>tT",
        function() require("neotest").run.run(vim.fn.expand("%")) end,
        desc = "[Test] Run File",
      },
      {
        "<leader>tD",
        ---@diagnostic disable-next-line: missing-fields
        function() require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap" }) end,
        desc = "[Test] Debug File",
      },
      {
        "<leader>ta",
        function() require("neotest").run.run(vim.loop.cwd()) end,
        desc = "[Test] Run Project",
      },
      {
        "<leader>ts",
        function() require("neotest").summary.toggle() end,
        desc = "[Test] Toggle Summary",
      },
      {
        "<leader>to",
        function() require("neotest").output.open({ enter = true, auto_close = true }) end,
        desc = "[Test] Show Output",
      },
      {
        "<leader>tO",
        function() require("neotest").output_panel.toggle() end,
        desc = "[Test] Toggle Output Panel",
      },
      { "<leader>tS", function() require("neotest").run.stop() end, desc = "[Test] Stop" },
    },
    opts = { ---@diagnostic disable-line: missing-fields
      quickfix = {
        open = function() require("trouble").open({ mode = "quickfix", focus = false }) end,
        enabled = true,
      },
      output = { open_on_run = true, enabled = true },
      status = { virtual_text = true, signs = true, enabled = true },
      icons = {
        failed = "󰅙",
        passed = "",
        running = "",
        running_animated = { "⡿", "⢿", "⣻", "⣽", "⣾", "⣷", "⣯", "⣟" },
        skipped = "",
        unknown = "",
        watching = "",
      },
    },
    config = function(_, opts)
      local brazilPathCmd = {"brazil-path", "[JUnit5]all.classpath"}
      local junitDeps = vim.split(vim.system(brazilPathCmd):wait().stdout, ":")
      local junit_jar = nil
      for _, jar in ipairs(junitDeps) do
        if string.match(jar, "junit-platform-console") then
          junit_jar = jar
          break
        end
      end

      opts.adapters = {
        require("neotest-jest"),
        require("neotest-haskell"),
        require("neotest-java")({ junit_jar = junit_jar }),
        require("neotest-bash"),
        require("neotest-plenary"),
        require("neotest-vim-test")({
          -- Must ignore filetypes handled by other adapters
          ignore_file_types = {
            "typescript",
            "typescriptreact",
            "javascript",
            "javascriptreact",
            "haskell",
            "java",
            "bash",
            "lua",
          },
        }),
      }

      require("neotest").setup(opts)
    end,
  },

  {
    "andythigpen/nvim-coverage",
    dependencies = "nvim-lua/plenary.nvim",
    cmd = { "Coverage", "CoverageSummary", "CoverageToggle" },
    opts = {
      auto_reload = true,
      summary = {
        min_coverage = 80.0,
      },
    },
  },
}
