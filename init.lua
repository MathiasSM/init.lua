-- External PRE
--------------------------------------------------------------------------------

-- Basic settings
--------------------------------------------------------------------------------

vim.o.fileformats="unix,dos,mac"      -- Use Unix even in Windows
vim.o.exrc = false -- Explicitly disallow project-specifc config files

-- title
-- titlestring
-- guitablabel

vim.o.cmdheight = 2 -- Command separated from output

-- Splits
vim.o.splitbelow = true -- Predictable
vim.o.splitright = true -- Predictable

-- Numbers
vim.o.number = true
vim.o.relativenumber = true

vim.o.foldmethod="indent" -- Good enough for most languages I use

vim.o.scrolljump = 5 -- Autoscroll when going out of screen
vim.o.sidescroll = 5 -- Autoscroll when going out of screen

vim.o.wildoptions = "pum,tagfile,fuzzy" -- Add fuzzy to defaults

vim.o.wildignore = vim.o.wildignore .. "*/.DS_Store,*/._*" -- macOS
vim.o.wildignore = vim.o.wildignore .. "*/.git,*/.hg,*/.svn" -- Versioning
vim.o.wildignore = vim.o.wildignore .. "*/node_modules" -- Big vendors
vim.o.wildignore = vim.o.wildignore .. "*.png,*.jpg,*.jpeg,*.webp" -- Images
vim.o.wildignore = vim.o.wildignore .. "*.pdf" -- Tecnically text but not useful
vim.o.wildignore = vim.o.wildignore .. "*.ttf,*.otf,*.woff,*.woff2,*.eot" -- Fonts
vim.o.wildignore = vim.o.wildignore .. "*.class,*.0,*.pyc,*.hi,*.o" -- Compiled code
vim.o.wildignore = vim.o.wildignore .. "*.stack-work,*/__pycache__/" -- Compiled code directories

vim.o.confirm = true -- Ask instead of failing
vim.o.showmatch = true -- Matching brackets highlighting

vim.o.virtualedit = "block" -- Allow editing past actual characters in visual mode

-- Wrap
vim.o.wrap = false              -- No soft wrap by default
vim.o.linebreak = true           -- Be smart about where to wrap lines
vim.o.display = "lastline" -- Display part of those wrapped. Avoid jumps

-- Indentation
vim.o.expandtab = true         -- Use spaces instead of tabs
vim.o.shiftwidth=2      -- I like short tabs
vim.o.tabstop=2
vim.o.breakindent =true
vim.o.smartindent = true       -- Insert or remove indentation automatically

-- Format options
vim.o.formatoptions = ""  -- No auto-wrap code or comments
vim.o.formatoptions = vim.o.formatoptions .. "n" -- Number list items
vim.o.formatoptions = vim.o.formatoptions .. "r" -- Add comment leader on enter
vim.o.formatoptions = vim.o.formatoptions .. "o" -- Add comment leader on o/O
vim.o.formatoptions = vim.o.formatoptions .. "/" -- Add comment leader on o/O BUT NOT after partially commented lines
vim.o.formatoptions = vim.o.formatoptions .. "j" -- Remove comments on line merges

if vim.api.nvim_get_option('encoding') == 'utf-8' then
  vim.o.listchars = 'tab:▸ ,extends:❯,precedes:❮,nbsp:±'
else
  vim.o.listchars = 'tab:> ,extends:>,precedes:<,nbsp:.'
end

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.mouse = "a"

vim.o.backup = true
vim.o.backupdir = vim.fn.stdpath('state') .. "/backup//" -- No '.': no sibling files
vim.o.updatecount = 50 -- Lower threshold to write to swap
vim.o.undofile = true
vim.o.undolevels = 5000
vim.o.shada = "!,'100,r/tmp,r/media,r/mnt,r/Volumes"
vim.o.verbosefile = vim.fn.stdpath('log') .. "/verbose.log"

vim.o.spelllang = "en,es,fr,cjk" -- TODO: Add programming dictionary
vim.o.spelloptions = "camel" -- Separate words in camelCase



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
require("lazy").setup("plugins") 



-- Custom appearance
--------------------------------------------------------------------------------

vim.cmd[[colorscheme tokyonight]]

-- Custom functions/commands
--------------------------------------------------------------------------------

-- Custom Keymappings
--------------------------------------------------------------------------------

-- Filetype handling
--------------------------------------------------------------------------------

-- Miscellaneuous
--------------------------------------------------------------------------------

-- External POST
--------------------------------------------------------------------------------

