local M = {}

function M.brazil_jdk_location(workspace_directory)
	local jdk_path = ""

	if vim.fn.isdirectory(workspace_directory .. "/env/JDK21-1.0") == 1 then
		jdk_path = workspace_directory .. "/env/JDK21-1.0"
		return "JavaSE-21", jdk_path .. "/runtime/jdk-21/"
	elseif vim.fn.isdirectory(workspace_directory .. "/env/OpenJDK8-1.1") == 1 then
		jdk_path = workspace_directory .. "/env/OpenJDK8-1.1"
		return "JavaSE-1.8", jdk_path .. "/runtime/jdk1.8/"
	elseif vim.fn.isdirectory(workspace_directory .. "/env/JDK8-1.0") == 1 then
		jdk_path = workspace_directory .. "/env/JDK8-1.0"
		return "JavaSE-1.8", jdk_path .. "/runtime/jdk1.8/"
	end

	return "JavaSE-11", "/apollo/env/JavaSE11/jdk-11/"
end

function M.get_lombok_path()
	local home = os.getenv("HOME")
	local lombok_path = home .. "/lombok.jar"
	-- Disabled until https://github.com/eclipse-jdtls/eclipse.jdt.ls/issues/2985
	-- Maybe fixed on 1.18.32, but unclear
	-- local local_lombok = root_dir .. "/env/Lombok-1.18.x/runtime/lib/lombok-1.18.30.jar"
	-- local jar = io.open(local_lombok)
	-- if jar then
	--     lombok_path = local_lombok
	--     jar:close()
	-- end
	return lombok_path
end

function M.get_jdtls_settings_path()
	local home = os.getenv("HOME")
	return home .. "/.config/jdtls/compiler.ini"
end

function M.get_eclipse_workspace(root_dir)
	local home = os.getenv("HOME")
	return home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
end

function M.get_bemol_workspace_folders(root_dir)
	if not root_dir then return {} end

	local ws_folders_jdtls = {}
	local file = io.open(root_dir .. "/.bemol/ws_root_folders")
	if file then
		for line in file:lines() do
			table.insert(ws_folders_jdtls, "file://" .. line)
		end
		file:close()
	end
	return ws_folders_jdtls
end

return M
