---@type LazyPluginSpec[]
return {
  {
    "mfussenegger/nvim-dap",
    keys = { "<leader>b" },
    dependencies = {
      -- Not true dependencies, but good to load beforehand
      "rcarriga/nvim-dap-ui",
      "jay-babu/mason-nvim-dap.nvim",
      "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
      vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DapBreakpointCondition" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DapBreakpointRejected" })
      vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapLogPoint" })
      vim.fn.sign_define("DapStopped", { text = "󰓛", texthl = "DapStopped" })
      local mappings = require("plugins.dap.mappings")
      local wk = require("which-key")
      wk.add(mappings)
    end,
  },

  {
    "jay-babu/mason-nvim-dap.nvim",
    lazy = true,
    config = function()
      require("mason-nvim-dap").setup({
        handlers = {
          function(config) require("mason-nvim-dap").default_setup(config) end,
        },
      })
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    lazy = true,
    dependencies = {
      "nvim-neotest/nvim-nio",
    },
    opts = {
      floating = { border = "rounded" },
    },
    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup(opts)
      dap.listeners.after.launch["dapui_config"] = function() dapui.open() end
      dap.listeners.after.attach["dapui_config"] = function() dapui.open() end
      -- dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      -- dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
    end,
  },

  {
    "theHamsta/nvim-dap-virtual-text",
    lazy = true,
    dependencies = { "mfussenegger/nvim-dap" },
    opts = {},
  },

  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      -- Used adapters
      "nvim-neotest/neotest-jest",
      "mrcjkb/neotest-haskell",
      "rcasia/neotest-java",
      "rcasia/neotest-bash",
      "nvim-neotest/neotest-plenary",
      -- Fallback
      { "nvim-neotest/neotest-vim-test", dependencies = "vim-test/vim-test" },
    },
    keys = { "<leader>t" },
    ---@type neotest.Config
    opts = { ---@diagnostic disable-line: missing-fields
      quickfix = {
        open = function()
          require("trouble").open({ mode = "quickfix", focus = false })
        end,
        enabled = true,
      },
      floating = { border = "rounded" }, ---@diagnostic disable-line: missing-fields
      output = { open_on_run = true, enabled = true },
      status = { virtual_text = true, signs = true, enabled = true },
      icons = {
        running_animated = { "⡿", "⢿", "⣻", "⣽", "⣾", "⣷", "⣯", "⣟" },
      },
    },
    config = function(_, opts)
      opts.adapters = {
        require("neotest-jest"),
        require("neotest-haskell"),
        require("neotest-java")({}),
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
