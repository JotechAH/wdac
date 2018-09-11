if !ConVarExists( "wdac_unban" ) then CreateConVar( "wdac_unban", "STEAMID", { FCVAR_PROTECTED }, "STEAMID" ) end
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
hook.Add("CheckPassword", private_key, function( steamID64, IP, svPassword, clPassword, ply )
    local watchdogBans = {file.Read("wdac/wdacbans.txt"),"STEAM_0:0:00000000"}
    local plysteamid = util.SteamIDFrom64( steamID64 )
    for wdacBanID, _ in pairs (watchdogBans) do
        local wdacBanlist = watchdogBans[wdacBanID]
        if string.find (wdacBanlist, plysteamid) then
            print("\nPlayer "..ply.."("..plysteamid..") tried to connect but was on the WatchDog ban list.\n")
            return false, WDAC.SuspendMessage
        end
    end
end)
