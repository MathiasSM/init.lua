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
		["hls"] = function()
			-- Handled by haskell-tools
            return true -- Avoid duplicate servers
		end,
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
            return true -- Avoid duplicate servers
		end,
	}
end

return {
	{
		"neovim/nvim-lspconfig",
		keys = {
			{
				"<space><cr>",
				function()
					vim.keymap.del("n", "<space><cr>") -- TODO: PR so whichkey can remove keys!
					require("lsp-toggle").setup({ create_cmds = true, telescope = true })
					vim.cmd("doautocmd BufReadPost") -- HACK: Without this, it doesn't attach
					vim.notify("Loaded. Use `:ToggleLSP` to turn any client on/off on each buffer")
				end,
				desc = "[LSP] Turn on LSPs",
			},
		},
		dependencies = {
			{ "j-hui/fidget.nvim", opts = {} },
			"williamboman/mason-lspconfig.nvim",
			-- For my custom logic:
			{
				"adoyle-h/lsp-toggle.nvim",
				dependencies = {
					"nvim-telescope/telescope.nvim",
					"neovim/nvim-lspconfig",
					"keyvchan/telescope-find-pickers.nvim",
				},
			},
		},
		config = function()
			require("mason-lspconfig").setup({
				handlers = get_handler_setups(),
			})
		end,
	},

	{
		"folke/lazydev.nvim",
		ft = "lua",
		config = true,
	},
}
