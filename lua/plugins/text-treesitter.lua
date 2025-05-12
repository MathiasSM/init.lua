--- Treesitter and textobjs

-- stylua: ignore
local treesitter_grammars_to_install = {
  -- Markup
  "html", "css", "scss",
  "rst", "markdown", "markdown_inline", "latex", "bibtex",
  "mermaid", "gnuplot", "dot",
  -- Scripting
  "bash", "awk", "jq", "make", "cmake", "passwd", "regex", "printf",
  -- Data
  "sql", "jsonnet",
  "csv", "tsv", "xml", "json", "json5", "jsonc", "yaml",
  -- Programming
  "c", "cmake", "comment", "cpp", "cuda", "go", "graphql", "haskell",
  "java", "javascript", "kotlin", "lua", "matlab", "ocaml",
  "perl", "python", "ruby", "rust", "scala",
  "sql", "typescript", "vim",
  -- Documentation
  "doxygen", "jsdoc", "luadoc", "vimdoc",
  -- Configuration
  "dhall", "toml", "json", "yaml", "nix", "ini",
  "dockerfile", "requirements", "ssh_config", "readline", "tmux",
  "git_config", "gitignore", "gitattributes", "requirements",
  -- Specific tooling/work
  "diff", "git_rebase", "gitcommit",
  "regex", "printf",
  "gdscript", "godot_resource",
  "gpg",
  "http",
  "ledger",
  "muttrc",
  "hlsplaylist",
  -- Other
  "html",  -- Required for luckasRanarison/nvim-devdocs
  "http", "json", -- Both required for rest.nvim
  "query" -- Recommended for playground
}

---@module "lazy"
---@type LazyPluginSpec[]
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")

      vim.o.foldmethod = "expr"
      vim.o.foldexpr = "nvim_treesitter#foldexpr()"
      vim.o.foldenable = false

      ---@diagnostic disable-next-line missing-fields
      configs.setup({
        auto_install = true,
        sync_install = false,
        incremental_selection = { enable = true },
        indent = { enable = true },
        highlight = { enable = true },
        -- Grouped, some are purposely duplicated into multiple groups
        ensure_installed = treesitter_grammars_to_install,
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    config = function()
      require("nvim-treesitter.configs").setup({ ---@diagnostic disable-line: missing-fields
        textobjects = {
          select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = {
                query = "@class.inner",
                desc = "Select inner part of a class region",
              },
              -- You can also use captures from other query groups like `locals.scm`
              ["as"] = {
                query = "@scope",
                query_group = "locals",
                desc = "Select language scope",
              },
            },
            -- You can choose the select mode (default is charwise 'v')
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * method: eg 'v' or 'o'
            -- and should return the mode ('v', 'V', or '<c-v>') or a table
            -- mapping query_strings to modes.
            selection_modes = {
              ["@parameter.outer"] = "v", -- charwise
              ["@function.outer"] = "V", -- linewise
              ["@class.outer"] = "<c-v>", -- blockwise
            },
            -- If you set this to `true` (default is `false`) then any textobject is
            -- extended to include preceding or succeeding whitespace. Succeeding
            -- whitespace has priority in order to act similarly to eg the built-in
            -- `ap`.
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * selection_mode: eg 'v'
            -- and should return true or false
            include_surrounding_whitespace = true,
          },
        },
      })
    end,
  },

  {
    "chrisgrieser/nvim-various-textobjs",
    event = "VeryLazy",
    opts = {
      keymap = {
        useDefaults = true
      }
    },
  },

  {
    "RRethy/nvim-treesitter-textsubjects",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    config = function()
      require("nvim-treesitter.configs").setup({ ---@diagnostic disable-line: missing-fields
        textsubjects = {
          enable = true,
          prev_selection = ",", -- (Optional) keymap to select the previous selection
          keymaps = {
            ["."] = "textsubjects-smart",
            [";"] = "textsubjects-container-outer",
            ["i;"] = {
              "textsubjects-container-inner",
              desc = "Select inside containers (classes, functions, etc.)",
            },
          },
        },
      })
    end,
  },
}
