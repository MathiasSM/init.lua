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

--- Merges second table into first table recursively (overwrites numbered keys!)
function M.absorb_object(t1, t2)
	for k, t2k in pairs(t2) do
		local v1 = t1[k]
		if (type(v1) == "table") and (type(v2) == "table") then
			M.absorb_object(t1[k], t2[k])
		else
			t1[k] = v
		end
	end
end

function M.merge_tables(...)
	local result = {}

	for _, tbl in ipairs({ ... }) do
		M.absorb_object(result, tbl)
	end

	return result
end

function M.concat_tables(...)
	local result = {}

	for _, tbl in ipairs({ ... }) do
		for k, v in pairs(tbl) do
			if type(k) ~= "number" then
				notify_once(
					"Found table member with non-number key, ingoring.",
					vim.log.levels.WARN
				)
			end
			table.insert(result, v)
		end
	end

	return result
end

return M
