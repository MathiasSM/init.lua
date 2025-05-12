local M = {}
--- Formatting for the completion menu items
--
-- Adds the item type icon and source name. Requires lspkind.
function M.format_completion_popup(entry, vim_item)
  -- Add filetype icons to path
  if vim.tbl_contains({ 'path' }, entry.source.name) then
    local icon, hl_group = require('nvim-web-devicons').get_icon(entry:get_completion_item().label)
    if icon then
      vim_item.kind = icon
      vim_item.kind_hl_group = hl_group
      return vim_item
    end
  end
  -- Add lspkind icons to all
  local kind = require("lspkind").cmp_format({
    show_labelDetails = true,
    mode = "symbol",
    -- stylua: ignore
    menu = {
      buffer                  = "[buffer]",
      calc                    = "[calc]",
      cmp_pandoc              = "[pandoc]",
      emoji                   = "[emoji]",
      git                     = "[git]",
      gitmoji                 = "[git󰞅]",
      greek                   = "[greek]",
      latex_symbols           = "[latex]",
      luasnip                 = "[luasnip]",
      nerdfont                = "[nerd]",
      nvim_lsp                = "[LSP]",
      nvim_lsp_signature_help = "[LSP+]",
      path                    = "[path]",
      spell                   = "[spell]",
    },
  })(entry, vim_item)
  return kind
end

return M
