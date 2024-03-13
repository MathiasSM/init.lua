local function get_handlers()
	local completion_capabilities = require("cmp_nvim_lsp").default_capabilities()
	return {
		-- [1]: Default handler
		function(server_name)
			require("lspconfig")[server_name].setup({
				capabilities = completion_capabilities,
			})
		end,
		-- [*] Specific handlers
		["jdtls"] = function() end, -- Set in private
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
		["tsserver"] = function(server_name)
			local capabilities = vim.deepcopy(completion_capabilities)
			-- Disable tsserver as formatter
			completion_capabilities.documentFormattingProvider = false
			completion_capabilities.documentRangeFormattingProvider = false
			require("lspconfig")[server_name].setup({
				capabilities = capabilities,
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
					},
				},
			})
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
			-- Neodev must run before lspconfig
			"folke/neodev.nvim",
			-- TODO. Want it to run when LSP runs
			{
				"j-hui/fidget.nvim",
				opts = {},
			},
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			require("neodev").setup({}) -- Neodev must run before lspconfig
			require("mason-lspconfig").setup({
				handlers = get_handlers(),
			})
		end,
	},
}
