--- Integration with external tools
--
-- @module tooling


--- Language servers. Used with native LSP client
-- Ideally one per language, but sometimes it's useful to have multiple
-- stylua: ignore
local mason_tools_lsp = {
	-- Specific languages
	"awk-language-server",             -- AWK
	"bash-language-server",            -- Bash
	"clangd",                          -- C++
	"cmake-language-server",           -- CMake
	"css-lsp",                         -- CSS, SCSS & LESS
	"csharp-language-server",          -- Csharp
	"dhall-lsp",                       -- Dhall
	"docker-compose-language-service", -- Docker compose
	"dockerfile-language-server",      -- Dockerfiles
	"dot-language-server",             -- Dot
	"gopls",                           -- Go
	"graphql-language-service-cli",    -- GraphQL
	"html-lsp",                        -- HTML
	"haskell-language-server",         -- Haskell (Required for haskell-tools)
	"json-lsp",                        -- JSON (Required for SchemaStore)
	"jdtls",                           -- Java
	"texlab",                          -- LaTeX
	"lua-language-server",             -- Lua (Required for neodev)
	"remark-language-server",		   -- Markdown/commonmark
	"mutt-language-server",            -- Mutt's muttrc
	"perl-navigator",                  -- Perl
	"purescript-language-server",      -- Purescript
	"rust-analyzer",                   -- Rust
	"taplo",                           -- TOML
	-- "typescript-language-server",   -- PERF Using typescript-tools instead
	"vim-language-server",             -- Vimscript
	"custom-elements-languageserver",  -- WebComponents
	"lemminx",                         -- XML
	"yaml-language-server",            -- YAML
	"jsonnet-language-server",         -- jsonnet

	-- Specific tools
	"sonarlint-language-server", -- Java, JS, TS, CSS, HTML, Python, C#, PHP, Go, Ruby, VB, Kotlin
	"harper-ls",                 -- Prose. Grammar checker Linter-as-LSP
	"vale-ls",                   -- Prose. Style Linter-as-LSP
	"typos-lsp", 				 -- Typos.
	"autotools-language-server", -- Makefiles (make, automake, autoconf)
	"eslint-lsp",                -- JS/TS Linter-as-LSP. TODO: Consider eslint_d?
	"stylelint-lsp",             -- CSS Linter-as-LSP
	"gradle-language-server",    -- Gradle (Java) build configurations
	"htmx-lsp",                  -- HTMX
	"jq-lsp",                    -- JQ queries
	"sqlls",                     -- SQL (MySQL, PostgreSQL, SQLite3 and others)
	"sqls",                      -- SQL (MySQL, PostgreSQL, SQLite3)
	"codeql",                    -- Github CodeQL
}

--- Linters that are not LSPs. Used with nvim-lint
-- stylua: ignore
local mason_tools_linters = {
	"codespell",            -- All. Spell checker
	"cspell",               -- All. Spell checker
	"editorconfig-checker", -- All. Check files against .editorconfig
	"gitleaks",             -- All. Checks no secrets leaked across the codebase
	"woke",                 -- All. Non-inclusive language
	"cfn-linter",           -- Cloudformation templates.
	"commitlint",           -- Git commits (chosen over gitlint)
	"actionlint",           -- Github Actions workflow files
	"gdtoolkit",            -- Godot's GDScript
	"htmlhint",             -- HTML
	"checkstyle",           -- Java
	"djlint",               -- Jinja, Nunjucks, Django, Twig, Liquid (chosen over curvylint)
	"luacheck",             -- Lua (extra diagnostic)
	"markdownlint-cli2",    -- Markdown.
	"alex",                 -- Prose. Insensitive writing
	"textlint",             -- Prose. Plugins
	"proselint",            -- Prose. Style
	"write-good",           -- Prose. Avoid weasel words, passive voice, etc.
	"pydocstyle",           -- Python pydoc style
	"sqlfluff",             -- SQL
	"shellcheck",           -- Shell (Bash, zsh, etc.) [Auto-used by bash-language-server]
	"vint",                 -- Vimscript
}

--- Formatters for specific languages
-- stylua: ignore
local mason_tools_formatters = {
	"beautysh",        -- Bash
	"bibtext-tidy",    -- BibTeX
	"csharpier",       -- C#
	"cpplint",         -- C++ (Google style)
	"clang-format",    -- C, C++, C#, Objective-C, Java
	"cmakelang",       -- CMake
	"fourmolu",        -- Haskell [Can be used by language server]
	"latexindent",     -- LaTeX
	"stylua",          -- Lua
	"mdformat",        -- Markdown (commonmark)
	"purescript-tidy", -- PureScript
	"sqlfmt",          -- SQL (chosen over sql-formatter)
	"shfmt",           -- Shell, bash, zsh
}

--- DAP tools for specific languages
-- stylua: ignore
local mason_tools_debugging = {
	"bash-debug-adapter",    -- Bash
	"go-debug-adapter",      -- Go
	"haskell-debug-adapter", -- Haskell
	"firefox-debug-adapter", -- JS (Web, Firefox extension, etc.)
	"js-debug-adapter",      -- JS (Web, Node, Chrome, Edge, etc.)
	"java-debug-adapter",    -- Java
	"java-test",             -- Java [Testing]
	"debugpy",               -- Python
}

--- Other external tools mason can install
-- stylua: ignore
local mason_tools_other = {
	"gh",              -- Github CLI
	"glow",            -- Pretty markdown in terminal
	"yq",              -- Manipulate YAML
	"jq",              -- Manipulate JSON
	"remark-cli",      -- Compile markdown (commonmark) with plugins
	"tectonic",        -- LaTeX compiler (improved XeTeX ?)
	"tree-sitter-cli", -- Treesitter
}

local mason_tools_to_install = require("utils").concat_tables(
	mason_tools_lsp,
	mason_tools_linters,
	mason_tools_formatters,
	mason_tools_debugging,
	mason_tools_other
)

return {
	{
		"williamboman/mason.nvim",
		lazy = false, -- So path is up to date
		build = ":MasonUpdate",
		opts = {
			ui = {
				border = "single",
				icons = {
					package_installed = "◍",
					package_pending = "◍",
					package_uninstalled = "◍",
				},
			},
		},
	},

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			{ "williamboman/mason-lspconfig.nvim", opts = {} }, -- To use lspconfig names directly
		},
		cmd = {
			"MasonToolsInstall",
			"MasonToolsUpdate",
			"MasonToolsClean",
			-- For headless mode:
			"MasonToolsUpdateSync",
			"MasonToolsInstallSync",
		},
		opts = {
			ensure_installed = mason_tools_to_install,
			auto_update = false,
			run_on_start = false,
		},
	},

	{
		"aserowy/tmux.nvim",
		opts = {
			copy_sync = {
				redirect_to_clipboard = true,
			},
		},
	},

	{
		"tpope/vim-fugitive",
		cmd = {
			"Git",
			"Gedit",
			"Gdiffsplit",
			"Gvdiffsplit",
			"Gread",
			"Gwrite",
			"Ggrep",
			"GMove",
			"GDelete",
			"GBrowse",
		},
	},

	{
		"rest-nvim/rest.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		cmd = { "RestNvim", "RestNvimPreview", "RestNvimLast" },
		keys = {
			{ "<leader>r", "<Plug>RestNvim<cr>", desc = "[RestNvim] Run", ft = "http" },
			{
				"<leader>rp",
				"<Plug>RestNvimPreview<cr>",
				desc = "[RestNvim] Preview",
				ft = "http",
			},
			{ "<leader>rl", "<Plug>RestNvimLast<cr>", desc = "[RestNvim] Run Last", ft = "http" },
		},
		config = true,
	},

	{
		"gennaro-tedesco/nvim-jqx",
		ft = { "json", "yaml" },
	},
}
