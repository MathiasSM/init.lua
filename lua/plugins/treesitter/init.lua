---@module "lazy"
---@type LazyPluginSpec[]
return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    main = "nvim-treesitter",
    build = ":TSUpdate",
    init = function()
      local ok, ts = pcall(require, "nvim-treesitter")
      if not ok then
        print("Treesitter is not available!")
        return
      end
      -- Install everything...
      all_available = ts.get_available()
      -- ts.install(all_available, { summary=true }):wait(300000)
      -- Enable features for available languages
      vim.api.nvim_create_autocmd("FileType", {
        pattern = all_available,
        callback = function(args)
          -- Enable treesitter highlighting and disable regex syntax
          vim.treesitter.start()
          -- Enable treesitter-based folding
          vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
          -- Enable treesitter-based indentation
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    cmd = "TSContext",
    keys = {
      {
        "[u",
        function() require("treesitter-context").go_to_context(vim.v.count1) end,
        desc = "[TS] Go to scope start",
      },
      {
        "<leader>c",
        ":TSContext toggle<CR>",
        desc = "[TS] Toggle TS Context",
      },
    },
    config = function()
      require("treesitter-context").setup({
        min_window_height = 30,
        multiline_threshold = 5,
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    main = "nvim-treesitter-textobjects",
    branch = "main",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    init = function()
      -- Disable entire built-in ftplugin mappings to avoid conflicts.
      -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
      vim.g.no_plugin_maps = true
    end,
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = {
          lookahead = true,
        },
      })
      require("plugins.treesitter.textobjects")
    end,
  },
}
