--- Small autocommands that replace former tiny plugins
--- (remember.nvim and smartcolumn.nvim)

local M = {}

-- reopen files at their last edit position
vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("config.last_position", {}),
  desc = "Jump to the last edit position",
  callback = function()
    local exclude = { "commit", "rebase" }
    if vim.tbl_contains(exclude, vim.bo.filetype) then return end
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local line_count = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- per-filetype `colorcolumn`
local colorcolumn_default = "80"
local colorcolumn_by_ft = {
  java = "120",
  lua = "100",
  haskell = "100",
}
local colorcolumn_disabled = {
  "help",
  "lazy",
  "lspinfo",
  "markdown",
  "mason",
  "neo-tree",
  "netrw",
  "noice",
  "oil",
  "qf",
  "text",
  "trouble",
}
vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
  group = vim.api.nvim_create_augroup("config.colorcolumn", {}),
  desc = "Set colorcolumn per filetype",
  callback = function()
    if vim.tbl_contains(colorcolumn_disabled, vim.bo.filetype) then
      vim.opt_local.colorcolumn = ""
    else
      vim.opt_local.colorcolumn = colorcolumn_by_ft[vim.bo.filetype] or colorcolumn_default
    end
  end,
})

return M
