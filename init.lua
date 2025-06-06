--- Mathias' NeoVim init.lua
-- This file sets the core/base options
-- @script

-- Leader
vim.g.mapleader = "\\"

-- Integration
vim.opt_global.mouse = "a"

-- UI
vim.opt_global.confirm = true -- Ask instead of failing
vim.opt_global.termguicolors = true -- Enable good colors
vim.opt_global.cmdheight = 2 -- Command separated from output
vim.opt_global.foldlevelstart = 5

-- pumheight
vim.opt_global.pumheight = 15 -- Initial max height (autocomplete)
vim.api.nvim_create_augroup("my.config", {})
vim.api.nvim_create_autocmd("VimResized", {
  group = "my.config",
  callback = function()
    local pumheight_pct = 0.4
    local win_height = vim.api.nvim_win_get_height(0)
    vim.opt_global.pumheight = math.floor(win_height * pumheight_pct)
  end,
})

-- IO
vim.opt_global.fileformats = { "unix", "dos", "mac" } -- Use Unix even in Windows
vim.opt_global.exrc = false -- Explicitly disallow project-specific config

-- Splits
vim.opt_global.splitbelow = true -- Predictable
vim.opt_global.splitright = true -- Predictable

-- Scrolling
vim.opt_global.scrolljump = 5 -- Autoscroll when going out of screen
vim.opt_global.sidescroll = 5 -- Autoscroll when going out of screen

-- Wild*
-- stylua: ignore
vim.opt_global.wildignore:append({
  "*/.DS_Store", "*/._*", -- macOS
  "*/.git", "*/.hg", "*/.svn", -- Versioning
  "*/node_modules", -- Big vendors
  "*.png", "*.jpg", "*.jpeg", "*.webp", -- Images
  "*.ttf", "*.otf", "*.woff", "*.woff2", "*.eot", -- Fonts
  "*.class", "*.0", "*.pyc", "*.hi", "*.o", "*.stack-work", "*/__pycache__/", -- Compiled code
  "*.pdf", -- Other binaries
})
-- vim.opt_global.wildmode = "longest:full,full"

-- Searching
vim.opt_global.showmatch = true -- Matching brackets highlighting
vim.opt_global.ignorecase = true
vim.opt_global.smartcase = true

-- Other
vim.opt_global.virtualedit = "block" -- Allow editing past actual characters in VISUAL

-- Non-printable characters
vim.opt_global.listchars = { tab = "▸ ", extends = "❯", precedes = "❮", nbsp = "±" }

-- Special vim files
vim.opt_global.backup = true
vim.opt_global.backupdir = vim.fn.stdpath("state") .. "/backup//"
vim.opt_global.updatecount = 50 -- Lower threshold to write to swap
vim.opt_global.shada = "!,'100,r/tmp,r/media,r/mnt,r/Volumes"
vim.opt_global.verbosefile = vim.fn.stdpath("log") .. "/verbose.log"
vim.opt_global.undolevels = 5000
vim.opt.undofile = true

-- Signcolumn
vim.opt.signcolumn = "yes"
vim.opt.number = true
vim.opt.relativenumber = true

-- Wrap
vim.opt.wrap = false -- No soft wrap by default
vim.opt.linebreak = true -- Be smart about where to wrap lines

-- Indentation
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.breakindent = true
vim.opt.autoindent = true -- Insert or remove indentation automatically
vim.opt.smartindent = true -- Insert or remove indentation autosmartically

-- Format options
vim.opt.formatoptions = table.concat({
  "n", -- Recognize lists for formatting
  "r", -- Add comment leader on enter
  "o", -- Add comment leader on o/O
  "/", -- Add comment leader on o/O when line is not 100% comment
  "j", -- Remove comments on Joins
  -- No auto-wrap of text with "t"
  -- No auto-wrap of comments with "c"
}, "")

-- Spelling
vim.opt.spelllang = "en,es,fr,cjk"
vim.opt.spelloptions = "camel" -- Separate words in camelCase

vim.diagnostic.config(require("diagnostics").opts)

require("mappings.overrides")
require("mappings.personal")
require("mappings.lsp")
require("lazy_config")
