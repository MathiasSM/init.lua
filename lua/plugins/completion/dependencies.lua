local sources = {
  -- Snippets
  "saadparwaiz1/cmp_luasnip",   -- snippets

  -- Buffers / Built-in
  "hrsh7th/cmp-buffer",         -- buffer
  "f3fora/cmp-spell",           -- Vim's spellsuggest
  "hrsh7th/cmp-calc",           -- calc

  -- LSP
  "hrsh7th/cmp-nvim-lsp",       -- LSP
  "hrsh7th/cmp-nvim-lsp-signature-help",
  "hrsh7th/cmp-nvim-lsp-document-symbol",

  -- Filesystem
  "hrsh7th/cmp-path",           -- Path

  -- Git
  { "petertriho/cmp-git", opts = {} }, -- git (commits, issues, PRs...)
  { "Dynge/gitmoji.nvim", opts = {} }, -- gitmoji
  "davidsierradz/cmp-conventionalcommits", 

  -- Command Line
  "hrsh7th/cmp-cmdline",

  -- Fuzzy finding
  -- - Overkill

  -- Shell
  "andersevenrud/cmp-tmux",

  -- Icons, Symbols and Emoji
  "hrsh7th/cmp-emoji",          -- emoji
  "max397574/cmp-greek",        -- greek
  "chrisgrieser/cmp-nerdfont",  -- nerdfont

  -- AI
  -- - nope
  --
  -- CSS / Colors and Fonts
  "nat-418/cmp-color-names.nvim",

  -- Note-Taking and Academic Writing
  {
    "aspeddro/cmp-pandoc.nvim", -- cmp_pandoc
    dependencies = "jbyuki/nabla.nvim",
    opts = { crossref = { enable_nabla = true } }
  },
  "kdheepak/cmp-latex-symbols", -- latex_symbols

  -- Miscellaneus
  "rcarriga/cmp-dap",
  {
    "yehuohan/cmp-im",        -- IM
    dependencies = "MathiasSM/ZFVimIM_japanese_base",
    opts = {
      enable = true,
      tables = {
        vim.fn.stdpath("data") .. "/lazy/ZFVimIM_japanese_base/misc/japanese.txt",
      },
    }
  },
}

local M = {
  -- Base
  "L3MON4D3/LuaSnip",           -- Engine
}

-- Sources
for _, source in ipairs(sources) do
    table.insert(M, source)
end

-- Nice to haves
table.insert(M, "nvim-tree/nvim-web-devicons")
table.insert(M, "onsails/lspkind.nvim")

return M
