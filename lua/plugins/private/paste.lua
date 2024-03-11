return {
	{
		name = "paste",
		dir = "~/.config/nvim/lua/plugins/private/noop.lua",
		dependencies = "scat",
		lazy = true,
		config = function()
			local paste = require("scat.paste")

			vim.keymap.set(
				{ "n", "x" },
				"<leader>as",
				paste.send_to_pastebin,
				{ desc = "[Paste] Send to paste.amazon.com" }
			)
			vim.keymap.set("n", "<leader>asl", paste.list_my_pastes, { desc = "[Paste] List My Pastes" })
		end,
	},
}
