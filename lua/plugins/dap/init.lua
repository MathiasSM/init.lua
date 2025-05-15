local dap = require('plugins.dap.dap')
local dap_ui = require('plugins.dap.dap-ui')
local dap_testing = require('plugins.dap.dap-testing')

local M = {}
for _, plugin_list in ipairs({ dap, dap_ui, dap_testing }) do
  for _, plugin in ipairs(plugin_list) do
    table.insert(M, plugin)
  end
end
return M
