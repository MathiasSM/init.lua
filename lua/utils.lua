--- Some utility functions to use across my nvim configuration
-- @module utils

local M = {}

--- Converts an object into a string, recursing into tables
-- It doesn't handle indentation or any other prettification
-- @return the stringified object
function M.dump(o)
	if type(o) == "table" then
		local s = "{ "
		for k, v in pairs(o) do
			if type(k) ~= "number" then k = '"' .. k .. '"' end
			s = s .. "[" .. k .. "] = " .. M.dump(v) .. ","
		end
		return s .. "} "
	else
		return tostring(o)
	end
end

--- Prints the string representation of an object
function M.debug(o)
	local str = M.dump(o)
	print(str)
end

--- Gets the proper command to use to open an HTML/image file
-- @return `open` for macos, `xdg-open` for linux, `lynx` for terminals without UI
function M.get_browser_cmd()
	if vim.env.OS == "macos" then return "open" end
	if vim.env.DISPLAY == nil or vim.env.DISPLAY == "" then return "lynx" end
	return "xdg-open"
end

--- Merges second table into first table recursively
function M.absorb_table(t1, t2)
	for k, v in pairs(t2) do
		if (type(v) == "table") and (type(t1[k]) == "table") then
			M.absorb_table(t1[k], t2[k])
		else
			t1[k] = v
		end
	end
end

function M.merge(...)
	local result = {}

	for _, tbl in ipairs({ ... }) do
		M.absorb_table(result, tbl)
	end

	return result
end

return M
