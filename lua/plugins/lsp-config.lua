
--- Builds the handlers for each LSP server
--
-- As required by mason-lspconfig.setup({handlers})
--
-- Requires (lazily?) lspconfig, schemastore, cmp_nvim_lsp
local function get_handler_setups()
	local completion_capabilities = require("cmp_nvim_lsp").default_capabilities()
	return {
		-- [1]: Default handler
		function(server_name)
			require("lspconfig")[server_name].setup({
				capabilities = completion_capabilities,
			})
		end,
		-- [*] Specific handlers
		["jsonls"] = function(server_name)
			require("lspconfig")[server_name].setup({
				capabilities = completion_capabilities,
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
					},
				},
			})
		end,
		["tsserver"] = function()
			-- Handled by typescript-tools
		end,
		["bashls"] = function(server_name)
			require("lspconfig")[server_name].setup({
				capabilities = completion_capabilities,
				filetypes = { "sh", "bash", "zsh" },
			})
		end,
		["custom_elements_ls"] = function(server_name)
			require("lspconfig")[server_name].setup({
				capabilities = completion_capabilities,
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
					},
				},
				filetypes = {
					"html",
					"typescript",
					"javascript",
					"typescriptreact",
					"javascriptreact",
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
			{ "folke/neodev.nvim", opts = {} },
			{ "j-hui/fidget.nvim", opts = {} },
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			require("mason-lspconfig").setup({
				handlers = get_handler_setups(),
			})
		end,
	},
}
