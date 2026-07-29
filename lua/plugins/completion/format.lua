-- stylua: ignore
local custom_menu_icon = {
  -- Snippets
  luasnip                 = { menu = "[luasnip]" },
  -- Builtin vim functionality
  buffer                  = { menu = "[buffer]" },
  calc                    = { menu = "[calc]", icon = "󰃬", kind = "Calc" },
  spell                   = { menu = "[spell]" },
  -- LSP
  nvim_lsp                = { menu = "[LSP]" },
  nvim_lsp_signature_help = { menu = "[LSP+]" },
  -- Filesystem
  path                    = { menu = "[path]" },
  -- Git
  git                     = { menu = "[git]" },
  gitmoji                 = { menu = "[gitmoji]" },
  conventionalcommits     = { menu = "[convention]" },
  -- Command line
  -- -
  -- Fuzzy
  -- -
  -- Shell
  tmux                    = { menu = "" --[[  Already added  ]] },
  -- Symbols and Icons
  emoji                   = { menu = "[emoji]" },
  greek                   = { menu = "[greek]" },
  latex_symbols           = { menu = "[latex]" },
  nerdfont                = { menu = "[nerd]" },
  -- AI
  -- -
  -- CSS, Colors and Font
  color_names             = { menu = "[webcolor]" },
  -- Dependencies
  -- -
  -- Note-taking and academic writing
  cmp_pandoc              = { menu = "[pandoc]" },
  -- Ruby on Rails
  -- -
  -- Miscellaneous
  IM                      = { menu = "[IM]" },
  dap                     = { menu = "[dap]" },
  -- Other (not in list)
  lazydev                 = { menu = "[lazy]" },
}

local M = {}

--- Formatting for the completion menu items
--
-- Adds the item type icon and source name. Requires lspkind.
function M.format_completion_popup(entry, vim_item)
  -- Add filetype icons to path
  if vim.tbl_contains({ "path" }, entry.source.name) then
    local icon, hl_group = require("nvim-web-devicons").get_icon(entry:get_completion_item().label)
    if icon then
      vim_item.kind = icon
      vim_item.kind_hl_group = hl_group
      return vim_item
    end
  end

  -- Build custom source strings into menu
  local menu = {}
  for key, value in pairs(custom_menu_icon) do
    if value.menu ~= nil then menu[key] = value.menu end
  end

  -- Add lspkind icons to all
  local kind = require("lspkind").cmp_format({
    show_labelDetails = true,
    mode = "symbol",
    menu = menu,
  })(entry, vim_item)

  -- Override icon/kind from custom
  if custom_menu_icon[entry.source.name] ~= nil then
    vim_item.icon = custom_menu_icon[entry.source.name].icon or vim_item.icon
    vim_item.kind = custom_menu_icon[entry.source.name].kind or vim_item.kind
  end
  return kind
end

return M
