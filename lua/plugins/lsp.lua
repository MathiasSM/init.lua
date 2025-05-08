--- @module "mason-lspconfig"
--- @module "lspconfig"

--- @alias Handlers MasonLspconfigSettings["handlers"]

--- Builds the handlers for each LSP server
---
--- As required by mason-lspconfig.setup({handlers})
--- @return Handlers
local function get_handler_setups()
	local completion_capabilities = require("cmp_nvim_lsp").default_capabilities()

	local default_handler = function(server_name)
		require("lspconfig")[server_name].setup({
			capabilities = completion_capabilities,
		})
	end

	local handlers = { default_handler }

	-- These are setup by a separate plugin
	for _, ls in ipairs({"hls", "ts_ls", "jdtls"}) do
		-- Return true to avoid duplicate servers 
		handlers[ls] = function() return true end
	end

	function handlers.bashls(server_name)
		require("lspconfig")[server_name].setup({
			capabilities = completion_capabilities,
			filetypes = { "sh", "bash", "zsh" },
		})
	end

	function handlers.custom_elements_ls(server_name)
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
	end

	function handlers.jsonls(server_name)
		require("lspconfig")[server_name].setup({
			capabilities = completion_capabilities,
			settings = {
				json = {
					schemas = require("schemastore").json.schemas(),
					validate = { enable = true },
				},
			},
		})
	end
	return handlers
end

--- @type LazySpec
return {
	{
		"neovim/nvim-lspconfig",
        lazy = true,
		dependencies = {
			"j-hui/fidget.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			require("mason-lspconfig").setup({ handlers = get_handler_setups() })
		end,
	},

	{
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                "luvit-meta/library",
                "lazy.nvim"
            },
        },
    },

    { "Bilal2453/luvit-meta", lazy = true },

	{ "j-hui/fidget.nvim", evetn = "VeryLazy", opts = {} },

	{
		"adoyle-h/lsp-toggle.nvim",
        keys = {
            { "<space><cr>", ":LspStart<cr>", desc = "[LSP] Start LSP(s)" }
        },
		dependencies = { "neovim/nvim-lspconfig" },
		opts = { autostart = false, telescope = false, create_cmds = false }
	},
}
