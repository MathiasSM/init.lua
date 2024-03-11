local template_content = [[
## Overview/Description

- SIM: [SIM_ID](SIM_URL)
- Other docs: [doc](doc_url

Depends on: [CR_ID](CR_URL), [CR_ID](CR_URL)

### What is the purpose of this change?

<Purpose_and_description>

### Changes:

- <Change1>
- <Change2>

-------------------------------------------------------------------------------

## Testing

- How was this tested?
- Have unit tests been added/modified?
- Have integration tests been added/modified?
- Have UI tests been added/modified?

-------------------------------------------------------------------------------

## Review

- How to run this CR code?
- What to review?
]]

return {
	{
		name = "crux",
		dir = "~/.config/nvim/lua/plugins/private/noop.lua",
		dependencies = "scat",
		lazy = true,
		config = function()
			local brazil = require("scat.brazil")
			local cr = require("scat.cr")
			local local_manager = require("scat.cr.local_manager")
			local scat = require("scat")
			scat.setup({
				cr = {
					template_path = nil,
					template_content = template_content,
					user = nil,
					executable = "cr",
				},
			})
			vim.keymap.set(
				"n",
				"<leader>ap",
				brazil.display_current_package_url,
				{ desc = "[Code] Display URL for Current Package" }
			)
			vim.keymap.set(
				"n",
				"<leader>aP",
				brazil.display_package_under_cursor_url,
				{ desc = "[Code] Display URL for Package under Cursor" }
			)
			vim.keymap.set(
				"n",
				"<leader>aR",
				brazil.display_release_under_cursor_url,
				{ desc = "[Code] Display URL for Release under Cursor" }
			)
			vim.keymap.set(
				{ "n", "x" },
				"<leader>af",
				brazil.display_current_file_url,
				{ desc = "[Code] Display URL for Current File" }
			)
			vim.keymap.set("n", "<leader>ar", cr.open_cr, { desc = "[CRUX] Open CR" })
			vim.keymap.set(
				"n",
				"<leader>arp",
				cr.fetch_active_crs,
				{ desc = "[CRUX] Fetch Active CRs" }
			)

			vim.keymap.set(
				"n",
				"<leader>aru",
				cr.update_existing_cr,
				{ desc = "[CRUX] Update Existing CR" }
			)
			vim.keymap.set(
				"n",
				"<leader>art",
				local_manager.toggle_cr_overview,
				{ desc = "[CRUX] Toggle CR Overview" }
			)
		end,
	},
}
