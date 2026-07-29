local M = {}

---@type CatppuccinOptions
local catppuccin_opts = {
  float = {
    transparent = true,
    solid = false,
  },
  styles = {
    conditionals = {}, -- I don't like the default (italics)
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
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
  end,
  transparent_background = true,
  float = {
    transparent = true
  },
  term_colors = true,
  auto_integrations = true
}
function M.catppuccin()
  require("catppuccin").setup(catppuccin_opts)
  vim.cmd.colorscheme("catppuccin-nvim")
end

return M
