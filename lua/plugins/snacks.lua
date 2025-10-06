---@module "snacks"

---@module "lazy"
---@type LazyPluginSpec[]
return {
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>.", function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
      {
        "<leader>,",
        function() Snacks.scratch.select() end,
        desc = "Select Scratch Buffer",
      },
    },
    ---@type snacks.Config
    opts = { scratch = { name = "Scratchpad" } },
  },

  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1001,
    ---@type snacks.Config
    opts = {
      -- Overwrite vim UI defaults
      input = { enabled = true }, -- vim.ui.input
      picker = { enabled = true }, -- vim.ui.select
      notifier = { -- vim.notify
        enabled = true,
        top_down = false,
        margin = { top = 0, right = 1, bottom = 2 },
      },
      indent = { enabled = true, animate = { enabled = false } },
      styles = {
        input = {
          relative = "cursor",
        },
        notification = {
          wo = {
            wrap = true,
          },
        },
        notification_history = {
          width = 0.8,
          height = 0.8,
        },
      },
    },
  },

  {
    "folke/snacks.nvim",
    keys = {
      -- Find stuff
      {
        "<leader>f:",
        function() Snacks.picker.command_history() end,
        desc = "Command History",
      },
      { "<leader>fa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
      { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
      {
        "<leader>fC",
        function() Snacks.picker.colorschemes() end,
        desc = "Colorschemes",
      },
      {
        "<leader>fd",
        function() Snacks.picker.diagnostics_buffer() end,
        desc = "Buffer Diagnostics",
      },
      {
        "<leader>fD",
        function() Snacks.picker.diagnostics() end,
        desc = "Diagnostics",
      },
      {
        "<leader>ff",
        function() Snacks.picker.files() end,
        desc = "Find Files",
      },
      { "<leader>fg", function() Snacks.picker.grep() end, desc = "Grep" },
      {
        "<leader>fG",
        function() Snacks.picker.grep_buffers() end,
        desc = "Grep Open Buffers",
      },
      {
        "<leader>fh",
        function() Snacks.picker.help() end,
        desc = "Help Pages",
      },
      {
        "<leader>fH",
        function() Snacks.picker.highlights() end,
        desc = "Highlights",
      },
      { "<leader>fi", function() Snacks.picker.icons() end, desc = "Icons" },
      { "<leader>fk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
      {
        "<leader>fl",
        function() Snacks.picker.lazy() end,
        desc = "Lazy Plugin Specs",
      },
      { "<leader>fM", function() Snacks.picker.man() end, desc = "Man Pages" },
      { "<leader>fm", function() Snacks.picker.marks() end, desc = "Marks" },
      {
        "<leader>fn",
        function() Snacks.picker.notifications() end,
        desc = "Notification History",
      },
      { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
      {
        "<leader>fq",
        function() Snacks.picker.qflist() end,
        desc = "Quickfix List",
      },
      {
        "<leader>fr",
        function() Snacks.picker.resume() end,
        desc = "Resume last search",
      },
      {
        "<leader>fu",
        function() Snacks.picker.undo() end,
        desc = "Undo History",
      },
      {
        "<leader>fw",
        function() Snacks.picker.grep_word() end,
        desc = "Visual selection or word",
        mode = { "n", "x" },
      },
      { '<leader>f"', function() Snacks.picker.registers() end, desc = "Registers" },
      {
        "<leader>f/",
        function() Snacks.picker.search_history() end,
        desc = "Search History",
      },
      -- LSP
      {
        "<leader>ld",
        function() Snacks.picker.lsp_definitions() end,
        desc = "Goto Definition",
      },
      {
        "<leader>lD",
        function() Snacks.picker.lsp_declarations() end,
        desc = "Goto Declaration",
      },
      {
        "<leader>lr",
        function() Snacks.picker.lsp_references() end,
        nowait = true,
        desc = "References",
      },
      {
        "<leader>lI",
        function() Snacks.picker.lsp_implementations() end,
        desc = "Goto Implementation",
      },
      {
        "<leader>ly",
        function() Snacks.picker.lsp_type_definitions() end,
        desc = "Goto T[y]pe Definition",
      },
      { "<leader>ls", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
      {
        "<leader>lS",
        function() Snacks.picker.lsp_workspace_symbols() end,
        desc = "LSP Workspace Symbols",
      },
      -- Toggles
      {
        "<leader>H",
        function() Snacks.notifier.show_history() end,
        desc = "Show History",
      },
      { "<leader>z", function() Snacks.zen() end, desc = "Toggle Zen Mode" },
      { "<leader>Z", function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },
      { "<leader>:", function() Snacks.terminal() end, desc = "Toggle Terminal" },
      {
        "<leader><leader>n",
        function() Snacks.notifier.hide() end,
        desc = "Dismiss All Notifications",
      },
    },
    ---@type snacks.Config
    opts = {
      toggle = {
        color = {
          disabled = "grey",
        },
        wk_desc = {
          enabled = "",
          disabled = "",
        },
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...) Snacks.debug.inspect(...) end
          _G.bt = function() Snacks.debug.backtrace() end
          vim.print = _G.dd -- Override print to use snacks for `:=` command

          -- Create some toggle mappings
          local conceal_opts = {
            on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2,
            off = 0,
          }
          local background_opts = {
            on = "dark",
            off = "light",
          }
          Snacks.toggle.option("spell"):map("<leader>vs")
          Snacks.toggle.option("wrap"):map("<leader>vw")
          Snacks.toggle.line_number({ name = "number" }):map("<leader>vl")
          Snacks.toggle.option("relativenumber"):map("<leader>vL")
          Snacks.toggle.option("conceallevel", conceal_opts):map("<leader>vc")
          Snacks.toggle.option("background", background_opts):map("<leader>vb")
          Snacks.toggle.diagnostics():map("<leader><leader>d")
          Snacks.toggle.dim():map("<leader><leader>D")
          Snacks.toggle.inlay_hints():map("<leader><leader>h")
          Snacks.toggle.indent():map("<leader><leader>i")
          Snacks.toggle.treesitter():map("<leader><leader>t")

          Snacks.toggle({
            name = "TS Context",
            set = function() vim.cmd("TSContext toggle") end,
            get = require("treesitter-context").enabled,
          }):map("<leader><leader>c")
        end,
      })
    end,
  },
}
