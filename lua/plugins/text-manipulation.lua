--- Text manipulation
--
-- Special actions to manipulate the current buffer
-- * Toggle code comments
-- * EasyAlign magic
-- * Drawing diagrams
--
-- @module text-manipulation

return {
	{
		"numToStr/Comment.nvim",
		event = "InsertEnter",
		keys = {
			{ "gc", mode = "v", desc = "[Comment] Line" },
			{ "gb", mode = "v", desc = "[Comment] Block" },
			{ "gcc", desc = "[Comment] Line" },
			{ "gbc", desc = "[Comment] Block" },
		},
		opts = {
			mappings = { extra = false },
		},
	},

	{
		"junegunn/vim-easy-align",
		cmd = { "EasyAlign" },
	},

	{
		"jbyuki/venn.nvim",
		cmd = "VBox",
		keys = { "<leader>v" },
		config = function() -- venn.nvim: enable or disable keymappings
			local function buf_map(m, lhs, rhs)
				vim.keymap.set(m, lhs, rhs, { noremap = true, buffer = 0 })
			end
			local function toggle_venn()
				local venn_enabled = vim.b[0].venn_enabled
				if not venn_enabled then
					vim.b[0].venn_enabled = true
					vim.opt_local.virtualedit = "all"
					-- draw a line on HJKL keystokes
					buf_map("n", "H", "<C-v>h:VBox<CR>")
					buf_map("n", "J", "<C-v>j:VBox<CR>")
					buf_map("n", "K", "<C-v>k:VBox<CR>")
					buf_map("n", "L", "<C-v>l:VBox<CR>")
					-- draw a box by pressing "f" with visual selection
					buf_map("v", "f", ":VBox<CR>")
				else
					vim.opt_local.virtualedit = nil -- Use global value
					vim.b[0].venn_enabled = false
					vim.api.nvim_buf_del_keymap(0, "n", "H")
					vim.api.nvim_buf_del_keymap(0, "n", "J")
					vim.api.nvim_buf_del_keymap(0, "n", "K")
					vim.api.nvim_buf_del_keymap(0, "n", "L")
					vim.api.nvim_buf_del_keymap(0, "v", "f")
				end
			end
			-- toggle keymappings for venn using <leader>v
			vim.keymap.set(
				"n",
				"<leader>v",
				toggle_venn,
				{ desc = "[Venn] Toggle" }
			)
		end,
	},
}
