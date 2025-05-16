--- Copies the list and appends each xarg to the copy
local function extend(list, ...)
  local res = vim.deepcopy(list)
  vim.list_extend(res, { ... })
  return res
end

--- Source definitions for reuse
---@type table<string, cmp.SourceConfig>
-- stylua: ignore
local S = {
  buffer                  = { name = "buffer" },
  calc                    = { name = "calc" },
  cmdline                 = { name = "cmdline" },
  path                    = { name = "path", options = { trailing_slash = true } },
  nvim_lsp                = { name = "nvim_lsp" },
  nvim_lsp_signature_help = { name = "nvim_lsp_signature_help" },
  spell                   = { name = "spell" },
  emoji                   = { name = "emoji" },
  greek                   = { name = "greek" },
  pandoc                  = { name = "cmp_pandoc" },
  cjk                     = { name = "IM" },
  -- Alternatives
  spell__comments_only    = {
    name = "spell",
    option = {
      keep_all_entries  = false,
      enable_in_context = function()
        return require("cmp.config.context").in_treesitter_capture("spell")
      end,
    },
  },
}

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
local MARKUP_SOURCES = extend(LSP_SOURCES, S.spell, S.emoji, S.greek, S.pandoc, S.cjk)

--- Lsp sources with extra sources for non-markup/prose
local NON_MARKUP_SOURCES = extend(LSP_SOURCES, S.spell__comments_only)

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
    local prev = sources_per_ft[ft]
    local base = prev and prev or default_sources
    sources_per_ft[ft] = extend(base, ...)
  end
  extend_ft(MARKUP_SOURCES, "gitcommit", { name = "conventionalcommits" }, { name = "gitmoji" }, { name = "git" })
  extend_ft(NON_MARKUP_SOURCES, "tex", { name = "latex_symbols" })
  extend_ft(NON_MARKUP_SOURCES, "vim", { name = "nerdfont" })
  extend_ft(NON_MARKUP_SOURCES, "lua", { name = "nerdfont" }, { name = "lazydev", group_index = 0 })
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
