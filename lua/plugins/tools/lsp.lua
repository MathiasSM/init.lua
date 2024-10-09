--- Language servers. Used with native LSP client
-- Ideally one per language, but sometimes it's useful to have multiple
-- stylua: ignore
return {
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
	"lua-language-server",             -- Lua
	"remark-language-server",		   -- Markdown/commonmark
	"mutt-language-server",            -- Mutt's muttrc
	"perl-navigator",                  -- Perl
	"purescript-language-server",      -- Purescript
	"python-lsp-server", 			   -- Python
	"rust-analyzer",                   -- Rust
	"taplo",                           -- TOML
	"typescript-language-server",      -- TypeScript (used only indirectly by typescript-tools)
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
