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
    version = "^3", -- Recommended
    ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
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
          vim.keymap.set("n", "<leader>hR", ht.repl.quit, keyOpts("[LSP] Haskell: Quit REPL"))
        end,
      })
    end,
  },
  -- Typescript
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    opts = {
      settings = {
        expose_as_code_action = "all",
        on_attach = function()
          vim.keymap.set(
            "n",
            "<space>tio",
            "<cmd>TSToolsOrganizeImports<cr>",
            { desc = "[TypeScript] Imports: Sort+Clean" }
          )
          vim.keymap.set("n", "<space>tis", "<cmd>TSToolsSortImports<cr>", { desc = "[TypeScript] Imports: Sort" })
          vim.keymap.set(
            "n",
            "<space>tiu",
            "<cmd>TSToolsRemoveUnusedImports<cr>",
            { desc = "[TypeScript] Imports: Clean" }
          )
          vim.keymap.set(
            "n",
            "<space>tim",
            "<cmd>TSToolsAddMissingImports<cr>",
            { desc = "[TypeScript] Imports: Add missing" }
          )
          vim.keymap.set(
            "n",
            "<space>tu",
            "<cmd>TSToolsRemoveUnused<cr>",
            { desc = "[TypeScript] Clean unused statements" }
          )
          vim.keymap.set("n", "<space>tp", "<cmd>TSToolsFixAll<cr>", { desc = "[TypeScript] Fix all" })
          vim.keymap.set("n", "<space>tr", "<cmd>TSToolsRenameFile<cr>", { desc = "[TypeScript] Rename file" })
          vim.keymap.set(
            "n",
            "<space>tf",
            "<cmd>TSToolsFileReferences<cr>",
            { desc = "[TypeScript] List references to file" }
          )
          vim.keymap.set(
            "n",
            "<space>ts",
            "<cmd>TSToolsGoToSourceDefinition<cr>",
            { desc = "[TypeScript] Go to source" }
          )
        end,
      },
    },
  },
  -- Schemastore
  { "b0o/schemastore.nvim", ft = { "json", "jsonc", "yaml" } },
}
