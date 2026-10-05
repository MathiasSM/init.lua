---@type LazyPluginSpec[]
return {
  -- Lua
  { "Bilal2453/luvit-meta", ft = "lua", lazy = true },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = { library = { "lazy.nvim", "luvit-meta/library" } },
  },
  -- Haskell
  {
    "mrcjkb/haskell-tools.nvim",
    version = "^10", -- Recommended to pin a version
    lazy = false, -- Already lazy
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "haskell", "lhaskell", "cabal", "cabalproject" },
        desc = "Attach haskell-language-server on haskell files",
        group = vim.api.nvim_create_augroup("UserLspConfigHaskell", {}),
        callback = function()
          local ht = require("haskell-tools")
          local bufnr = vim.api.nvim_get_current_buf()
          local keyOpts = function(desc)
            return {
              noremap = true,
              silent = true,
              buffer = bufnr,
              desc = desc,
            }
          end
          vim.keymap.set("n", "<space>hs", ht.hoogle.hoogle_signature, keyOpts("[LSP] Haskell: Show hoogle signature"))
          vim.keymap.set("n", "<space>he", ht.lsp.buf_eval_all, keyOpts("[LSP] Haskell: Evaluate all"))
          vim.keymap.set("n", "<leader>hp", ht.repl.toggle, keyOpts("[LSP] Haskell: Toggle REPL for package"))
          vim.keymap.set(
            "n",
            "<leader>hr",
            function() ht.repl.toggle(vim.api.nvim_buf_get_name(0)) end,
            keyOpts("[LSP] Haskell: Toggle REPL for buffer")
          )
          vim.keymap.set("n", "<leader>hq", ht.repl.quit, keyOpts("[LSP] Haskell: Quit REPL"))
        end,
      })
    end,
  },
  {
    "mfussenegger/nvim-jdtls", -- TODO: try https://github.com/nvim-java/nvim-java
    dependencies = { "mfussenegger/nvim-dap", "mason-org/mason.nvim" },
    ft = { "java", "groovy" },
    config = function()
      local data = vim.fn.stdpath("data")
      -- NOTE: Requires these two installed via mason
      local jda = vim.fs.joinpath(data, "mason/share/java-debug-adapter")
      local jt = vim.fs.joinpath(data, "mason/share/java-test")
      local bundles = {
        vim.fn.glob(vim.fs.joinpath(jda, "com.microsoft.java.debug.plugin-*.jar")),
      }
      local java_test_bundles = vim.fn.glob(vim.fs.joinpath(jt, "*.jar"), false, true)
      local excluded = {
        "com.microsoft.java.test.runner-jar-with-dependencies.jar",
        "jacocoagent.jar",
      }
      for _, java_test_jar in ipairs(java_test_bundles) do
        local fname = vim.fn.fnamemodify(java_test_jar, ":t")
        if not vim.tbl_contains(excluded, fname) then table.insert(bundles, java_test_jar) end
      end
      vim.lsp.config("jdtls", {
        init_options = {
          bundles = bundles,
        },
      })
      vim.lsp.enable("jdtls")
    end,
  },
  -- Schemastore
  { "b0o/schemastore.nvim", ft = { "json", "jsonc", "yaml" } },
  -- Typescript
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
    config = function()
      require("typescript-tools").setup({
        settings = {
          publish_diagnostic_on = "insert_leave", -- or "change"
          expose_as_code_action = "all",
          complete_function_calls = false,
          include_completions_with_insert_text = true,
          -- WARNING: CodeLens are Experimental
          -- possible values: ("off"|"all"|"implementations_only"|"references_only")
          code_lens = "off",
          disable_member_code_lens = true, -- Enabled for performance
        },
      })
    end,
  },
}
