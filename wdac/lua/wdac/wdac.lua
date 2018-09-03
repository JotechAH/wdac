
if SERVER then
	print("//////////////////////////////////")
    print("~= Project WatchDog "..WDAC.Version.." =~")
	print("//////////////////////////////////")

	file.CreateDir( "wdac" )

	local folder = "wdac"
	local files = file.Find( folder .. "/" .. "*.lua", "LUA" )
	for _, file in ipairs( files ) do
		print( "// "..folder .. "/" .. file )
	end
	local folder = "wdac/server"
	local files = file.Find( folder .. "/" .. "*.lua", "LUA" )
	for _, file in ipairs( files ) do
		print( "// "..folder .. "/" .. file )
	end
	local folder = "wdac/client"
	local files = file.Find( folder .. "/" .. "*.lua", "LUA" )
	for _, file in ipairs( files ) do
		print( "// "..folder .. "/" .. file )
	end
	local folder = "wdac/network"
	local files = file.Find( folder .. "/" .. "*.lua", "LUA" )
	for _, file in ipairs( files ) do
		print( "// "..folder .. "/" .. file )
	end
	local folder = "wdac/suspend"
	local files = file.Find( folder .. "/" .. "*.lua", "LUA" )
	for _, file in ipairs( files ) do
		print( "// "..folder .. "/" .. file )
	end
	print("//////////////////////////////////")

    AddCSLuaFile( "wdac/wdac.lua" )
    AddCSLuaFile( "wdac/payload.lua" )
    AddCSLuaFile( "wdac/client/0001_checks.lua" )
	AddCSLuaFile( "wdac/client/0002_cmd.lua" )
	AddCSLuaFile( "wdac/ui/ui.lua" )
	AddCSLuaFile( "wdac/ui/font.lua" )
	AddCSLuaFile( "wdac/network/cmd.lua" )

end


if CLIENT then

	WDAC.TblDump = table.Copy(concommand.GetTable())
	WDAC.HookDump = table.Copy(hook.GetTable())

    include( "wdac/client/0001_checks.lua" )
	include( "wdac/client/0002_cmd.lua" )
    include( "wdac/payload.lua" )
	include( "wdac/ui/ui.lua" )
	include( "wdac/ui/font.lua" )

end

include( "wdac/network/cmd.lua" )