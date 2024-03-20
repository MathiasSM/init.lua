--- Linters that are not LSPs. Used with nvim-lint
--
-- If there's an LSP that covers the usecase, prefer that over a linter.
-- Be aware some linters specialize in best-practices along with correctness, though.
--
-- stylua: ignore
return {
	"write-good",           -- All Prose.      Style: Weasel words, passive voice, etc.
	"alex",                 -- All Prose.      Insensitive writing
	"textlint",             -- All Prose.      Plugin-based
	"proselint",            -- All Prose.      Prose style
	"editorconfig-checker", -- All.            Check files against .editorconfig
	"gitleaks",             -- All.            Checks no secrets leaked across the codebase
	"woke",                 -- All.            Non-inclusive language
	"codespell",            -- All.            Spell checker
	"cspell",               -- All.            Spell checker
	"cfn-linter",           -- Cloudformation. Templates
	"gdtoolkit",            -- GDScript.       Godot's scripting language
	"commitlint",           -- Git commits.    (chosen over gitlint)
	"actionlint",           -- Github Actions. Workflow files
	"htmlhint",             -- HTML.           Supplements LSP
	"checkstyle",           -- Java.           Provides style guidance
	"djlint",               -- Many.           Jinja, Nunjucks, Django, Twig, Liquid
	"shellcheck",           -- Many.           Shell (Bash, zsh, etc.) [Auto-used by bash LSP]
	"markdownlint-cli2",    -- Markdown.       Testing capabilities alongside LSP.
	"pydocstyle",           -- Python.         Provides pydoc style guidance
	"sqlfluff",             -- SQL.            Testing capabilities alongside LSP.
	"vint",                 -- Vimscript.      Supplements LSP
}
