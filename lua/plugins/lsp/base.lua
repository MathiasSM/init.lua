local function get_handlers()
	return {
		-- [1]: Default handler
		function(server_name)
			require("lspconfig")[server_name].setup({
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
			})
		end,
		-- [*] Specific handlers
		["jsonls"] = function()
			require("lspconfig").jsonls.setup({
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
					},
				},
			})
		end,
	}
end

return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		dependencies = {
			{ "folke/neodev.nvim", opts = {} }, -- Neodev must run before lspconfig
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			require("mason-lspconfig").setup({
				handlers = get_handlers(),
			})
		end,
	},
}
