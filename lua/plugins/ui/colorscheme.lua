local M = {}

---@type CatppuccinOptions
local catppuccin_opts = {
  styles = {
    conditionals = {}, -- I don't like the default (italics)
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
    notify = true,
    snacks = true,
    treesitter = true,
    treesitter_context = true,
    which_key = true,
    native_lsp = true,
  },
  custom_highlights = function(colors)
    local utils = require('catppuccin.utils.colors')
    local dim = function(fg, bg)
      return {
        fg = utils.darken(fg, .5),
        bg = bg
      }
    end
    return {
      DiagnosticVirtualTextOk = dim(colors.text, colors.base),
      DiagnosticVirtualTextHint = dim(colors.text, colors.base),
      DiagnosticVirtualTextInfo = dim(colors.blue, colors.base),
      DiagnosticVirtualTextWarn = dim(colors.yellow, colors.base),
      DiagnosticVirtualTextError = dim(colors.red, colors.base)
    }
  end
}
function M.catppuccin()
  require("catppuccin").setup(catppuccin_opts)
  vim.cmd([[colorscheme catppuccin]])
end

return M
