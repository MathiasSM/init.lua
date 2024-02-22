return {
  { 
    "folke/tokyonight.nvim",
    lazy = false, -- Main colorscheme
    priority = 1000,
    opts = {
      styles = {
        comments = { italic = true }
      },
      dim_inactive = true
    }
  },
  { 
    'nvim-lualine/lualine.nvim', 
    opts = {
      options = {
        theme = 'auto',
        icons_enabled = true,
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        globalstatus = true,
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {}
    }, 
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    }
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    }
  },
  {'gitsigns'},
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  { 
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    dependencies = {
      {
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
        dependencies = { 'nvim-lua/plenary.nvim' }
      }
    },
    config = function ()
      require('telescope').load_extension('fzf')
    end
  },
  { 
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function () 
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = { 
            "awk", "bash",
            "bibtex", "latex",
            "c", "cpp", "cmake", "cuda",
            "comment", "diff",
            "dockerfile", "dot", "doxygen", "gdscript",
          "git_config", "git_rebase", "gitcommit", "gitignore", "gitattributes",
          "gnuplot",
          "go",
          "godot_resource",
          "gpg",
          "graphql", "haskell",
          "http",
          "java",
          "json",
          "json5",
          "jsonc",
          "jsonnet",
          "jq",
          "jsdoc",
          "ledger",
          "luadoc",
          "make",
          "markdown",
          "matlab",
          "mermaid",
          "ocaml",
          "passwd",
          "perl",
          "printf",
          "prql",
            "python",
          "query",
          "readline",
          "regex",
          "requirements",
          "robot",
          "rst",
          "ruby",
          "rust",
          "scala",
          "scss",
          "sql",
          "swift",
          "todotxt",
          "toml",
          "tsv",
          "typescript","xml","yaml",
            "lua", "vim", "vimdoc", 
            "javascript", "html", "css",
            "csv", "tsv"
          },
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },  
        })
    end
  }
}
