--- Central config for UI priority levels
-- For virtual text, signcolumn, etc.
--
-- @module ui-priorities

local M = {}

M.virtual_text = {
    diagnostic = 100,
    git_blame = 500,
}

return M
