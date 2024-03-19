--- Formatters for specific languages
--
-- Keep in mind LSPs can include format capabilities.
--
-- stylua: ignore
return {
	"beautysh",        -- Bash
	"bibtext-tidy",    -- BibTeX
	"csharpier",       -- C#
	"cpplint",         -- C++ (Google style)
	"clang-format",    -- C, C++, C#, Objective-C, Java
	"cmakelang",       -- CMake
	"fourmolu",        -- Haskell [Can be used by the lsp]
	"latexindent",     -- LaTeX
	"stylua",          -- Lua
	"mdformat",        -- Markdown (commonmark)
	"purescript-tidy", -- PureScript
	"sqlfmt",          -- SQL (chosen over sql-formatter)
	"shfmt",           -- Shell, bash, zsh
}
