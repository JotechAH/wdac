function string.Random( cryptbits )
	local cryptbits = tonumber( cryptbits )
	if cryptbits < 1 then return end
	local cryptkey = ""
	for i = 1, cryptbits do
		cryptkey = cryptkey .. string.char( math.random( 32, 126 ) )
	end
	return cryptkey
end
local private_key = string.Random( 128 )
hook.Add("Think", private_key, function()
    local watchdogunbancvar = GetConVar( "wdac_unban" ):GetString()
    local watchdogfileread = file.Read("wdac/wdacbans.txt")
    if watchdogunbancvar ~= "STEAMID" then
        if string.find (watchdogfileread, watchdogunbancvar) then
            print("\nWATCHDOG\nSteamID: "..watchdogunbancvar.." was successfully removed from the ban list.\nBan list has been updated.\n")
            local watchdogBanfileUPDATE = string.Replace( watchdogfileread, '"'..watchdogunbancvar..'"', '' )
            file.Write( "wdac/wdacbans.txt", watchdogBanfileUPDATE )
            GetConVar( "wdac_unban" ):SetString( "STEAMID" )
        else
            print("\nWATCHDOG\nSteamID: "..watchdogunbancvar.." was not found in the ban list.\n")
            GetConVar( "wdac_unban" ):SetString( "STEAMID" )
        end
    end
end)
