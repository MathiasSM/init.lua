
local function setup()
  local cmp = require("cmp")
  local luasnip = require("luasnip")
  local mappings = require('plugins.completion.mappings')
  local sources = require('plugins.completion.sources').get_sources()

  -- Minimum configuration: Setup snippets engine
  cmp.setup({
    enabled = true,
    snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
  })

  -- Global configuration
  cmp.setup.global({
    formatting = {
      fields = { 'kind', 'abbr', 'menu' },
      format = require('plugins.completion.format').format_completion_popup,
      expandable_indicator = true,
    },
    window = {
      completion = cmp.config.window.bordered({border = "rounded"}),
      documentation = {border = "single"},
    },
    completion = { autocomplete = { 'InsertEnter', 'TextChanged' }  },
    mapping = mappings.global,
    sources = sources.global
  })

  -- Command line configuration
  local common_cmdline = {
    matching = { disallow_symbol_nonprefix_matching = false },
    window = { completion = cmp.config.window.bordered() },
  }
  for _, t in ipairs({':', '/', '?'}) do
    local props = vim.tbl_deep_extend('force', {}, common_cmdline, {
      mapping = mappings.cmdline,
      sources = sources.cmdline[t]
    })
    cmp.setup.cmdline(t, props)
  end

  -- Filetype-specific configurations
  for ft, ft_sources in pairs(sources.ft) do
    cmp.setup.filetype(ft, {
      sources = ft_sources
    })
  end
end

return setup
