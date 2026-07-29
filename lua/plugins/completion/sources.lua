--- Source definitions for reuse
---@type table<string, cmp.SourceConfig>
-- stylua: ignore
local S = {
  -- NOTE: Sources sorted by https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources
  -- Snippets
  -- -
  -- Builtin vim functionality
  buffer                  = { name = "buffer" },
  calc                    = { name = "calc" },
  spell                   = { name = "spell" },
  spell__comments_only    = {
    name = "spell",
    option = {
      keep_all_entries  = false,
      enable_in_context = function()
        return require("cmp.config.context").in_treesitter_capture("spell")
      end,
    },
  },
  -- LSP
  nvim_lsp                = { name = "nvim_lsp", priority = 999 },
  nvim_lsp_signature_help = { name = "nvim_lsp_signature_help" },
  -- Filesystem
  path                    = { name = "path", options = { trailing_slash = true } },
  -- Git
  git                     = { name = "git" },
  gitmoji                 = { name = "gitmoji" },
  conventionalcommits     = { name = "conventionalcommits" },
  -- Command line
  cmdline                 = { name = "cmdline" },
  -- Fuzzy
  -- -
  -- Shell
  tmux                    = {
    name = 'tmux',
    option = {
      all_panes = false,
      trigger_characters = { '.' },
      trigger_characters_ft = {},
      keyword_pattern = [[\w\+]],
      capture_history = false,
    },
    priority = -9999
  },
  -- -
  -- Symbols and Icons
  emoji                   = { name = "emoji" },
  greek                   = { name = "greek" },
  latex_symbols           = { name = "latex_symbols" },
  nerdfont                = { name = "nerdfont" },
  -- AI
  -- -
  -- CSS, Colors and Font
  color_names             = { name = 'color_names'},
  -- Dependencies
  -- -
  -- Note-taking and academic writing
  pandoc                  = { name = "cmp_pandoc" },
  -- -
  -- Ruby on Rails
  -- -
  -- Miscellaneous
  im                      = { name = "IM" },
  dap                     = { name = "dap" },
  -- Other (not in list)
  lazydev                 = { name = "lazydev", group_index = 0 },
}

local function custom(source, extra_opts) return vim.tbl_extend("force", {}, source, extra_opts or {}) end

--- Copies the list and appends each xarg to the copy
local function extend(list, ...)
  local res = vim.deepcopy(list)
  vim.list_extend(res, { ... })
  return res
end

--- Config: filetypes to add markup-specific sources
local MARKUP_FILETYPES = {
  "asciidoc",
  "html",
  "markdown",
  "gitcommit", -- Technically prose
  "rst",
  "tex",
  "text",
}

--- Basic sources that should work anywhere
local BASE_VIM_SOURCES = { S.buffer, S.path, S.calc }

--- Basic sources plus native lsp
local LSP_SOURCES = extend(BASE_VIM_SOURCES, S.nvim_lsp, S.nvim_lsp_signature_help)

--- Lsp sources with extra sources for markup/prose
local MARKUP_SOURCES = extend(LSP_SOURCES, S.tmux, S.spell, S.emoji, S.greek, S.pandoc, S.im)

--- Lsp sources with extra sources for non-markup/prose
local NON_MARKUP_SOURCES = extend(LSP_SOURCES, S.tmux, S.spell__comments_only)

---@class SourcesConfigMap
---@field global cmp.SourceConfig[]
---@field cmdline table<":" | "/" | "?", cmp.SourceConfig[]>
---@field ft table<string, cmp.SourceConfig[]>

---@return SourcesConfigMap
local DEFAULT_BASE_SOURCES_CONFIG = {
  global = NON_MARKUP_SOURCES, 
  ft = {},
  cmdline = {
    [":"] = { S.path, S.cmdline },
    ["/"] = { S.buffer },
    ["?"] = { S.buffer },
  },
}

local function add_markup_defaults(sources_per_ft)
  for _, ft in ipairs(MARKUP_FILETYPES) do
    sources_per_ft[ft] = MARKUP_SOURCES
  end
end

local function add_ft_overrides(sources_per_ft)
  local function extend_ft(default_sources, ft, ...)
    if type(ft) == "string" then ft = { ft } end
    for _, filetype in ipairs(ft) do
      local prev = sources_per_ft[filetype]
      local base = prev and prev or default_sources
      sources_per_ft[filetype] = extend(base, ...)
    end
  end
  -- Extras:
  -- Commits
  extend_ft(MARKUP_SOURCES, "gitcommit", S.conventionalcommits, S.gitmoji, S.git)
  -- Latex symbols (should I add them to pandoc?)
  extend_ft(NON_MARKUP_SOURCES, "tex", S.latex_symbols)
  -- Lua
  extend_ft(NON_MARKUP_SOURCES, "lua", S.lazydev)
  -- Nerdfonts: Only when configuring (n)vim UI
  extend_ft(NON_MARKUP_SOURCES, { "lua", "vim" }, S.nerdfont, S.emoji)
  -- Web colors: Only while editing stylesheets
  extend_ft(NON_MARKUP_SOURCES, { "css", "scss", "sass" }, S.color_names)
  -- DAP: Only in dap windows
  extend_ft(BASE_VIM_SOURCES, { "dap-repl", "dapui_watches", "dapui_hover" }, S.dap)
end

local M = {}

--- Setup global and specifc sources
---@return SourcesConfigMap
function M.get_sources()
  local cmp = require("cmp")

  local sources_config = vim.deepcopy(DEFAULT_BASE_SOURCES_CONFIG)
  add_markup_defaults(sources_config.ft)
  add_ft_overrides(sources_config.ft)

  local fallback = vim.deepcopy(BASE_VIM_SOURCES)

  local function map(obj)
    local mapped = {}
    for key, sources in pairs(obj) do
      mapped[key] = cmp.config.sources(sources, fallback)
    end
    return mapped
  end

  return {
    global = cmp.config.sources(sources_config.global, fallback),
    cmdline = map(sources_config.cmdline),
    ft = map(sources_config.ft),
  }
end

return M
