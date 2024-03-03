local diagnostic = {
	underline = true,
	update_in_insert = false,
	virtual_text = true,
	severity_sort = true,
	float = {
		header = "Diagnostics",
		focusable = false,
		wrap = true,
	}
}

vim.diagnostic.config(vim.deepcopy(diagnostic))
-- TODO: Change severities shown
--

vim.cmd[[
	function! BrazilWorkspaceRoot()
	  let l:working_directory = getcwd()
	  let l:workspace_root = split(l:working_directory, "/")[0:4]
	  return "/" . join(l:workspace_root, "/")
	endfunction

	function! BrazilOpenJDKLocation()
	  let l:workspace_directory=BrazilWorkspaceRoot()
	  let l:jdk_path=""
	  if (isdirectory(l:workspace_directory."/env/OpenJDK8-1.1"))
		  let l:jdk_path=l:workspace_directory."/env/OpenJDK8-1.1"
	  elseif (isdirectory(l:workspace_directory."/env/JDK8-1.0"))
		  let l:jdk_path=l:workspace_directory."/env/JDK8-1.0"
	  endif
	  
	  if (empty(l:jdk_path))
		return "/apollo/env/JavaSE11/jdk-11/"
	  else
		return l:jdk_path . "/runtime/jdk1.8/"
	  endif
	endfunction

	function! SetBrazilJDKHome()
	  let $JDK_HOME=BrazilOpenJDKLocation()
		echo "JDK_HOME=" . $JDK_HOME
	endfunction
]]

return {
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		build = ":MasonUpdate",
		config = true,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		lazy = true,
		dependencies = "williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"hls", -- Required for haskell-tools
				"jsonls", -- Required for SchemaStore
				"lua_ls", -- Required for neodev
				"tsserver", -- Required for typescript-tools
				"bashls",
				"cssls",
				"dotls",
				"eslint",
				"graphql",
				"html",
				"htmx",
				"jdtls", -- java
				"marksman", -- markdown
				"jqls", -- jq
				"stylelint_lsp",
				"sqls", -- SQL (Postgres and more)
				"texlab", -- Latex
				"vimls",
			},
			automatic_installation = true,
		},
	},

	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		dependencies = {
			{ "folke/neodev.nvim", opts = {} }, -- Must run before lspconfig
		},
		config = function()
			require("mason-lspconfig").setup_handlers({
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
			})

			-- Global mappings.
			vim.keymap.set(
				"n",
				"<space>e",
				vim.diagnostic.open_float,
				{ desc = "[Diagnostics] Open float" }
			)
			vim.keymap.set(
				"n",
				"[d",
				vim.diagnostic.goto_prev,
				{ desc = "[Diagnostics] Go to prev" }
			)
			vim.keymap.set(
				"n",
				"]d",
				vim.diagnostic.goto_next,
				{ desc = "[Diagnostics] Go to next" }
			)

			-- Use LspAttach autocommand to only map the following keys
			-- after the language server attaches to the current buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "Enable mappings for LSP functionality",
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

					-- Buffer local mappings.
					vim.keymap.set(
						"n",
						"gD",
						vim.lsp.buf.declaration,
						{ buffer = ev.buf, desc = "[LSP] Go to declaration" }
					)
					vim.keymap.set(
						"n",
						"gd",
						vim.lsp.buf.definition,
						{ buffer = ev.buf, desc = "[LSP] Go to definition" }
					)
					vim.keymap.set(
						"n",
						"gi",
						vim.lsp.buf.implementation,
						{ buffer = ev.buf, desc = "[LSP] Go to implementation" }
					)
					vim.keymap.set(
						"n",
						"gs",
						vim.lsp.buf.type_definition,
						{
							buffer = ev.buf,
							desc = "[LSP] Go to type definition",
						}
					)
					vim.keymap.set(
						"n",
						"gr",
						vim.lsp.buf.references,
						{ buffer = ev.buf, desc = "[LSP] Show references" }
					)

					vim.keymap.set(
						"n",
						"<space>k",
						vim.lsp.buf.hover,
						{
							buffer = ev.buf,
							desc = "[LSP] Show hover information",
						}
					)
					vim.keymap.set(
						"n",
						"<space>K",
						vim.lsp.buf.signature_help,
						{ buffer = ev.buf, desc = "[LSP] Show signature help" }
					)

					-- (w*)orkspace (wa)dd, (wr)emove, (wl)ist
					vim.keymap.set(
						"n",
						"<space>wa",
						vim.lsp.buf.add_workspace_folder,
						{ buffer = ev.buf, desc = "[LSP] Add workspace folder" }
					)
					vim.keymap.set(
						"n",
						"<space>wr",
						vim.lsp.buf.remove_workspace_folder,
						{
							buffer = ev.buf,
							desc = "[LSP] Remove workspace folder",
						}
					)
					vim.keymap.set(
						"n",
						"<space>wl",
						function()
							print(
								vim.inspect(
									vim.lsp.buf.list_workspace_folders()
								)
							)
						end,
						{
							buffer = ev.buf,
							desc = "[LSP] List workspace folders",
						}
					)

					-- (r)ename, (c)ode action, (f)ormat
					vim.keymap.set(
						"n",
						"<space>r",
						vim.lsp.buf.rename,
						{
							buffer = ev.buf,
							desc = "[LSP] Rename all references",
						}
					)
					vim.keymap.set(
						{ "n", "v" },
						"<space>c",
						vim.lsp.buf.code_action,
						{
							buffer = ev.buf,
							desc = "[LSP] Select code action to execute",
						}
					)
					vim.keymap.set(
						"n",
						"<space>f",
						function() vim.lsp.buf.format({ async = true }) end,
						{ buffer = ev.buf, desc = "[LSP] Format buffer" }
					)
				end,
			})
		end,
	},

	{
		"b0o/schemastore.nvim",
		ft = { "json", "jsonc", "yaml" },
	},

	{
		"mrcjkb/haskell-tools.nvim",
		version = "^3", -- Recommended
		ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
		config = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "haskell", "lhaskell", "cabal", "cabalproject" },
				desc = "Attach haskell-language-server on haskell files",
				group = vim.api.nvim_create_augroup("UserLspConfigHaskell", {}),
				callback = function()
					require("telescope").load_extension("ht")
					local ht = require("haskell-tools")
					local bufnr = vim.api.nvim_get_current_buf()
					local keyOpts = function(desc)
						return {
							noremap = true,
							silent = true,
							buffer = bufnr,
							desc = desc,
						}
					end
					vim.keymap.set(
						"n",
						"<space>hl",
						vim.lsp.codelens.run,
						keyOpts("[LSP] Run code lens")
					)
					vim.keymap.set(
						"n",
						"<space>hs",
						ht.hoogle.hoogle_signature,
						keyOpts("[LSP] Haskel: Show hoogle signature")
					)
					vim.keymap.set(
						"n",
						"<space>he",
						ht.lsp.buf_eval_all,
						keyOpts("[LSP] Haskell: Evaluate all")
					)
					vim.keymap.set(
						"n",
						"<leader>hp",
						ht.repl.toggle,
						keyOpts("[LSP] Haskell: Toggle REPL for package")
					)
					vim.keymap.set(
						"n",
						"<leader>hr",
						function() ht.repl.toggle(vim.api.nvim_buf_get_name(0)) end,
						keyOpts("[LSP] Haskell: Toggle REPL for buffer")
					)
					vim.keymap.set(
						"n",
						"<leader>hrq",
						ht.repl.quit,
						keyOpts("[LSP] Haskell: Quit REPL")
					)
				end,
			})
		end,
	},
}
