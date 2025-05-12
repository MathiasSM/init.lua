---@module "lazy"
---@type LazyPluginSpec[]
return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    keys = {
      {
        "<leader>bu",
        function() require("dapui").toggle({}) end,
        desc = "[Debug] DAPUI Toggle",
      },
      {
        "<leader>be",
        function() require("dapui").eval() end,
        desc = "[Debug] DAPUI Eval",
        mode = { "n", "v" },
      },
    },
    opts = {},
    config = function(_, opts)
      -- setup dap config by VsCode launch.json file
      -- require("dap.ext.vscode").load_launchjs()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup(opts)
      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open({}) end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close({}) end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close({}) end
    end,
  },

  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "mfussenegger/nvim-dap",
    },
    cmd = { "DapVirtualTextToggle" },
    keys = {
      { "<leader>bv", "<cmd>DapVirtualTextToggle<cr>", desc = "[Debug] Toggle virtual text" },
    },
    opts = {},
  },
}
