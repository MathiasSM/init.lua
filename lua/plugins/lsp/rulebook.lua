---@type LazyPluginSpec[]
return {
  {
    "chrisgrieser/nvim-rulebook",
    keys = {
      { "<leader>ri", function() require("rulebook").ignoreRule() end, desc = "Ignore rule" },
      { "<leader>rl", function() require("rulebook").lookupRule() end, desc = "Lookup rules" },
      { "<leader>ry", function() require("rulebook").yankDiagnosticCode() end, desc = "Yank diagnostic code" },
      {
        mode = { "n", "x", "v" },
        "<leader>rf",
        function() require("rulebook").suppressFormatter() end,
        desc = "Ignore formatter",
      },
    },
    config = function()
      ---@module "snacks"
      Snacks.keymap.set(
        "n",
        "<leader>rp",
        require("rulebook").prettifyError,
        { ft = { "typescript", "javascript" }, desc = "Show pretty error" }
      )
    end,
  },
}
