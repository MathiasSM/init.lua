---@module "lazy"
---@type LazyPluginSpec[]
return {
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
          vim.keymap.set(
            "n",
            "<space>tis",
            "<cmd>TSToolsSortImports<cr>",
            { desc = "[TypeScript] Imports: Sort" }
          )
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
          vim.keymap.set(
            "n",
            "<space>tp",
            "<cmd>TSToolsFixAll<cr>",
            { desc = "[TypeScript] Fix all" }
          )
          vim.keymap.set(
            "n",
            "<space>tr",
            "<cmd>TSToolsRenameFile<cr>",
            { desc = "[TypeScript] Rename file" }
          )
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
}
