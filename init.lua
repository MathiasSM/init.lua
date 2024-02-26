-- External PRE
-------------------------------------------------------------------------------

-- Basic settings
-------------------------------------------------------------------------------

-- Integration
vim.go.mouse = "a"
-- vim.o.title
-- vim.o.titlestring
-- vim.o.guitablabel

-- UI
vim.go.confirm = true -- Ask instead of failing
vim.go.termguicolors = true -- Enable good colors
vim.go.cmdheight = 2 -- Command separated from output

-- IO
vim.go.fileformats = "unix,dos,mac" -- Use Unix even in Windows
vim.go.exrc = false -- Explicitly disallow project-specific config

-- Splits
vim.go.splitbelow = true -- Predictable
vim.go.splitright = true -- Predictable

-- Signcolumn
vim.go.signcolumn = "yes"
vim.go.number = true
vim.go.relativenumber = true

-- Scrolling
vim.go.scrolljump = 5 -- Autoscroll when going out of screen
vim.go.sidescroll = 5 -- Autoscroll when going out of screen

-- Wild* stuff
vim.go.wildoptions = "pum,tagfile" -- Add fuzzy to defaults

local also_ignore = {
	-- macOS
	"*/.DS_Store",
	"*/._*",
	-- Versioning
	"*/.git",
	"*/.hg",
	"*/.svn",
	-- Big vendors
	"*/node_modules",
	-- Images
	"*.png",
	"*.jpg",
	"*.jpeg",
	"*.webp",
	-- Fonts
	"*.ttf",
	"*.otf",
	"*.woff",
	"*.woff2",
	"*.eot",
	-- Compiled code
	"*.class",
	"*.0",
	"*.pyc",
	"*.hi",
	"*.o",
	"*.stack-work",
	"*/__pycache__/",
	-- Other binaries
	"*.pdf",
}
vim.go.wildignore = vim.o.wildignore .. "," .. table.concat(also_ignore, ",")

-- Searching
vim.go.showmatch = true -- Matching brackets highlighting
vim.go.ignorecase = true
vim.go.smartcase = true

-- Wrap
vim.go.wrap = false -- No soft wrap by default
vim.go.linebreak = true -- Be smart about where to wrap lines
vim.go.display = "lastline" -- Display part of those wrapped. Avoid jumps

-- Indentation
vim.go.expandtab = true -- Use spaces instead of tabs
vim.go.shiftwidth = 4
vim.go.tabstop = 4
vim.go.breakindent = true
vim.go.smartindent = true -- Insert or remove indentation automatically

-- Format options
local formatoptions = {
	"n", -- Number list items
	"r", -- Add comment leader on enter
	"o", -- Add comment leader on o/O
	"/", -- ^ when line is <100% comment
	"j", -- Remove comments on Joins
	-- No auto-wrap code or comments
}
vim.go.formatoptions = table.concat(formatoptions, "")

-- Non-printable characters
if vim.go.encoding == "utf-8" then
	vim.go.listchars = "tab:▸ ,extends:❯,precedes:❮,nbsp:±"
else
	vim.go.listchars = "tab:> ,extends:>,precedes:<,nbsp:."
end

-- Special vim files
vim.go.backup = true
vim.go.backupdir = vim.fn.stdpath("state") .. "/backup//"
vim.go.updatecount = 50 -- Lower threshold to write to swap
vim.go.undofile = true
vim.go.undolevels = 5000
vim.go.shada = "!,'100,r/tmp,r/media,r/mnt,r/Volumes"
vim.go.verbosefile = vim.fn.stdpath("log") .. "/verbose.log"

-- Spelling
vim.go.spelllang = "en,es,fr,cjk"
vim.go.spelloptions = "camel" -- Separate words in camelCase

-- Other
vim.go.virtualedit = "block" -- Allow editing past actual characters in VISUAL

-- Plugin manager
--------------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Plugins definitions in CONFIG/lua/plugins.lua
require("lazy").setup("plugins", {
	change_detection = { notify = false }, -- Gets annoying fast
})

-- Custom functions/commands
--------------------------------------------------------------------------------

vim.api.nvim_create_user_command(
	"Netrw",
	"Lexplore",
	{ desc = "Open Netrw for current file directory" }
)
vim.api.nvim_create_user_command(
	"NetrwW",
	"Lexplore",
	{ desc = "Open Netrw for current workspace directory" }
)

-- Custom Keymappings
--------------------------------------------------------------------------------

local map = vim.keymap.set

map("n", "<leader><CR>", ":nohlsearch<cr>", { desc = "Turn off hl" })

-- Keep cursor centered on movements
map("n", "<C-d>", "<C-d>zz", { desc = "<C-d> and center cursor" })
map("n", "<C-u>", "<C-u>zz", { desc = "<C-u> and center cursor" })

map("n", "n", "nzzzv", { desc = "Search forward and center cursor" })
map("n", "N", "Nzzzv", { desc = "Search back and center cursor" })

-- Keep cursor position on edits
map("n", "J", "mzJ`z", { desc = "J but keep cursor in place" })

-- Text manipulation
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

map("x", "<leader>p", '"_dP', { desc = "Paste preserving register" })

-- Meta
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Copy to system clipboard" })
map("n", "<leader>Y", '"+Y', { desc = "Copy line to system clipboard" })

-- External POST
--------------------------------------------------------------------------------
