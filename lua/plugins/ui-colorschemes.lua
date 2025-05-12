--- Colorschemes I like
-- The default one must have lazy=false, priority=1000
-- The others should have lazy=true
--

---@module "lazy"
---@type LazyPluginSpec[]
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        styles = {
          conditionals = {}, -- Defaults to italics
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        integrations = {
          cmp = true,
          dap = true,
          dap_ui = true,
          gitgutter = true,
          gitsigns = true,
          harpoon = true,
          headlines = true,
          lsp_trouble = true,
          markdown = true,
          mason = true,
          neotest = true,
          notify = true,
          snacks = { enabled = true },
          treesitter = true,
          treesitter_context = true,
          which_key = true,
          native_lsp = {
            enabled = true,
            underlines = {
              errors = { "underline" },
              warnings = { "underline" },
              -- Disabling the following
              hints = {},
              information = {},
            },
          },
        },
      })
      vim.cmd([[colorscheme catppuccin]])
    end,
  },
}
