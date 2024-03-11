local diagnostic_config = {
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	virtual_text = {
		source = "always",
		prefix = "●",
	},
	float = {
		header = "Diagnostics",
		source = "always",
		focusable = false,
		wrap = true,
	},
}


return diagnostic_config
