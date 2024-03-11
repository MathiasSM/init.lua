local Utils = require("utils")

return Utils.merge(
	require("plugins.lsp.base"),
	require("plugins.lsp.haskell"),
	require("plugins.lsp.other")
)
