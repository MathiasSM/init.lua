-- External PRE
-------------------------------------------------------------------------------

-- Basic settings
-------------------------------------------------------------------------------

-- Integration
vim.o.mouse = "a"

-- UI
vim.o.confirm = true -- Ask instead of failing
vim.o.termguicolors = true -- Enable good colors
vim.o.cmdheight = 2 -- Command separated from output

-- IO
vim.o.fileformats = "unix,dos,mac" -- Use Unix even in Windows
vim.o.exrc = false -- Explicitly disallow project-specific config

-- Splits
vim.o.splitbelow = true -- Predictable
vim.o.splitright = true -- Predictable

-- Signcolumn
vim.o.signcolumn = "yes"
vim.o.number = true
vim.o.relativenumber = true

-- Scrolling
vim.o.scrolljump = 5 -- Autoscroll when going out of screen
vim.o.sidescroll = 5 -- Autoscroll when going out of screen

-- Wild* stuff
vim.o.wildoptions = "pum,tagfile" -- Add fuzzy to defaults

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
vim.o.wildignore = vim.o.wildignore .. "," .. table.concat(also_ignore, ",")

-- Searching
vim.o.showmatch = true -- Matching brackets highlighting
vim.o.ignorecase = true
vim.o.smartcase = true

-- Wrap
vim.o.wrap = false -- No soft wrap by default
vim.o.linebreak = true -- Be smart about where to wrap lines
vim.o.display = "lastline" -- Display part of those wrapped. Avoid jumps

-- Indentation
vim.o.expandtab = true -- Use spaces instead of tabs
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.breakindent = true
vim.o.smartindent = true -- Insert or remove indentation automatically

-- Format options
local formatoptions = {
	"n", -- Number list items
	"r", -- Add comment leader on enter
	"o", -- Add comment leader on o/O
	"/", -- ^ when line is <100% comment
	"j", -- Remove comments on Joins
	-- No auto-wrap code or comments
}
vim.o.formatoptions = table.concat(formatoptions, "")

-- Non-printable characters
if vim.o.encoding == "utf-8" then
	vim.o.listchars = "tab:▸ ,extends:❯,precedes:❮,nbsp:±"
else
	vim.o.listchars = "tab:> ,extends:>,precedes:<,nbsp:."
end

-- Special vim files
vim.o.backup = true
vim.o.backupdir = vim.fn.stdpath("state") .. "/backup//"
vim.o.updatecount = 50 -- Lower threshold to write to swap
vim.o.undofile = true
vim.o.undolevels = 5000
vim.o.shada = "!,'100,r/tmp,r/media,r/mnt,r/Volumes"
vim.o.verbosefile = vim.fn.stdpath("log") .. "/verbose.log"

-- Spelling
vim.o.spelllang = "en,es,fr,cjk"
vim.o.spelloptions = "camel" -- Separate words in camelCase

-- Other
vim.o.virtualedit = "block" -- Allow editing past actual characters in VISUAL



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
