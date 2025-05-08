-- Code
vim.keymap.set(
	"n",
	"<leader>aup",
	function() require("scat.brazil").display_current_package_url() end,
	{ desc = "[Code] Display URL for Current Package" }
)
vim.keymap.set(
	"n",
	"<leader>auP",
	function() require("scat.brazil").display_package_under_cursor_url() end,
	{ desc = "[Code] Display URL for Package under Cursor" }
)
vim.keymap.set(
	"n",
	"<leader>auR",
	function() require("scat.brazil").display_release_under_cursor_url() end,
	{ desc = "[Code] Display URL for Release under Cursor" }
)
vim.keymap.set(
	{ "n", "x" },
	"<leader>auf",
	function() require("scat.brazil").display_current_file_url() end,
	{ desc = "[Code] Display URL for Current File" }
)
vim.keymap.set(
	"n",
	"<leader>aro",
	function() require("scat.cr").open_cr() end,
	{ desc = "[CRUX] Open CR" }
)
vim.keymap.set(
	"n",
	"<leader>arp",
	function() require("scat.cr").fetch_active_crs() end,
	{ desc = "[CRUX] Fetch Active CRs" }
)

vim.keymap.set(
	"n",
	"<leader>aru",
	function() require("scat.cr").update_existing_cr() end,
	{ desc = "[CRUX] Update Existing CR" }
)
vim.keymap.set(
	"n",
	"<leader>art",
	function() require("scat.cr.local_manager").toggle_cr_overview() end,
	{ desc = "[CRUX] Toggle CR Overview" }
)
-- Display
vim.keymap.set(
    "n",
    "<leader>al",
    function() require("scat.brazil").list_all_packages() end,
    { desc = "[Brazil] List All Packages" }
)
vim.keymap.set(
    "n",
    "<leader>auv",
    function() require("scat.brazil").display_current_version_set_url() end,
    { desc = "[Brazil] Display URL for Current Version Set" }
)

-- Prepare
vim.keymap.set(
    "n",
    "<leader>ai",
    function() require("scat.brazil").install_current_jdt_package() end,
    { desc = "[Brazil] Install Current JDT Package" }
)

-- Build
vim.keymap.set(
    "n",
    "<leader>abb",
    function() require("scat.brazil").build_current_package() end,
    { desc = "[Brazil] bb (current package)" }
)
vim.keymap.set(
    "n",
    "<leader>abr",
    function() require("scat.brazil").build_current_package_recursively() end,
    { desc = "[Brazil] bb (current package recursively)" }
)

-- Paste
vim.keymap.set(
    { "n", "x" },
    "<leader>ap",
    function() require("scat.paste").send_to_pastebin() end,
    { desc = "[Paste] Send to paste.amazon.com" }
)
vim.keymap.set(
    "n",
    "<leader>asl",
    function() require("scat.paste").list_my_pastes() end,
    { desc = "[Paste] List My Pastes" }
)

-- Other Tasks
vim.keymap.set(
    "n",
    "<leader>abt",
    function()
        require("scat.brazil").pick_brazil_task_inside_current_package({
            callback = function(task) vim.g.test_replacement_command = task end
        }) end,
    { desc = "[Brazil] bb <task> (pick task)" }
)
vim.keymap.set(
    "n",
    "<leader>abl",
    function() require("scat.brazil").run_prev_brazil_task() end,
    { desc = "[Brazil] bb <task> (last task)" }
)
vim.keymap.set(
    "n",
    "<leader>ac",
    function() require("scat.brazil").run_command_inside_current_package() end,
    { desc = "[Brazil] <any cmd>" }
)
vim.keymap.set(
    "n",
    "<leader>aw",
    function() require("scat.brazil").switch_workspace_package_info() end,
    { desc = "[Brazil] Change packageInfo in Current Workspace" }
)
vim.keymap.set(
    "n",
    "<leader>aC",
    function() require("scat.brazil.utils").run_checkstyle() end,
    { desc = "[Brazil] Checkstyle" } -- TODO: Confirm is this or lint is better
)

return {}
