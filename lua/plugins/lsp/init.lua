local Utils = require("utils")

local lsp = Utils.concat_tables(
	require("plugins.lsp.base"),
	require("plugins.lsp.haskell"),
	require("plugins.lsp.other")
)
return lsp
