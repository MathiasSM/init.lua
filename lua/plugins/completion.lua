--- (Auto)completion configuration (`nvim-cmp`)
--
-- @module completion

--- Formatting for the completion menu items
--
-- Adds the item type icon and source name. Requires lspkind.
local function format_completion_popup(entry, vim_item)
  return require("lspkind").cmp_format({
    with_text = true,
    -- stylua: ignore
    menu = {
      buffer                  = "[Buffer]",
      calc                    = "[=]",
      cmp_pandoc              = "[Pandoc]",
      emoji                   = "[Emoji]",
      git                     = "[Git]",
      gitmoji                 = "[Gitmoji]",
      greek                   = "[Greek]",
      latex_symbols           = "[LaTeX]",
      luasnip                 = "",
      nerdfont                = "[Nerd]",
      nvim_lsp                = "[LSP]",
      nvim_lsp_signature_help = "[LSP]",
      omni                    = "[Omni]",
      path                    = "[Path]",
      spell                   = "[Spell]",
    },
  })(entry, vim_item)
end

--- True if the cursor follows an alphanumeric character
local function has_words_before()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  if col == 0 then return false end
  local prev_char = vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col)
  local is_alphanumeric = prev_char:match("%w") ~= nil
  return is_alphanumeric
end



return {
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    -- stylua: ignore
    dependencies = {
      -- Base
      "L3MON4D3/LuaSnip",           -- Engine
      -- Sources
      "hrsh7th/cmp-buffer",         -- buffer
      "hrsh7th/cmp-calc",           -- calc
      {
        "aspeddro/cmp-pandoc.nvim", -- cmp_pandoc
        dependencies = "jbyuki/nabla.nvim"
      },
      "hrsh7th/cmp-emoji",          -- emoji
      "Dynge/gitmoji.nvim",         -- gitmoji
      "petertriho/cmp-git",         -- git
      "max397574/cmp-greek",        -- greek
      "kdheepak/cmp-latex-symbols", -- latex_symbols
      {
        "yehuohan/cmp-im",        -- IM
        dependencies = "MathiasSM/ZFVimIM_japanese_base"
      },
      "chrisgrieser/cmp-nerdfont",  -- nerdfont
      "hrsh7th/cmp-nvim-lsp",       -- LSP
      "hrsh7th/cmp-nvim-lsp-signature-help", -- nvim_lsp_signature_help
      "hrsh7th/cmp-omni",           -- omni
      "hrsh7th/cmp-path",           -- path
      "saadparwaiz1/cmp_luasnip",   -- snippets
      "f3fora/cmp-spell",           -- spell
      -- Nice to have
      "nvim-tree/nvim-web-devicons",
      "onsails/lspkind.nvim",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      -- Minimum configuration: Setup snippets engine
      cmp.setup({
        snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
      })

      -- UI
      cmp.setup({
        ---@diagnostic disable-next-line: missing-fields
        formatting = {
          format = format_completion_popup,
          expandable_indicator = true,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      })

      -- Config/Setup Sources
      require('plugins.completion.sources').setup_sources(cmp)

      -- Mappings
      local select_behavior = require('cmp.types').cmp.SelectBehavior.Select
      local confirm_behavior = require('cmp.types').cmp.ConfirmBehavior.Replace
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ['<C-n>'] = {
            i = function()
              local cmp = require('cmp') ---@diagnostic disable-line: redefined-local
              if cmp.visible() then
                cmp.select_next_item({ behavior = select_behavior })
              else
                cmp.complete()
              end
            end,
          },
          ['<C-p>'] = {
            i = function()
              local cmp = require('cmp') ---@diagnostic disable-line: redefined-local
              if cmp.visible() then
                cmp.select_prev_item({ behavior = select_behavior })
              else
                cmp.complete()
              end
            end,
          },
          ['<C-l>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              return cmp.complete_common_string()
            end
            fallback()
          end, { 'i', 'c' }),
          ['<Enter>'] = {
            i = cmp.mapping.confirm({ select = false, behavior = confirm_behavior }),
          },
          ['<C-y>'] = {
            i = cmp.mapping.confirm({ select = false, behavior = confirm_behavior }),
          },
          ['<Esc>'] = {
            i = cmp.mapping.abort()
          },
        }),
      })
    end,
  },

  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    lazy = true,
    config = function()
      require("luasnip").setup({
        region_check_events = { "CursorMoved", "CursorHold", "InsertEnter" },
        delete_check_events = "TextChanged",
      })
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
}
