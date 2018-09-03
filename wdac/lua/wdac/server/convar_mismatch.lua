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

timer.Create(private_key, 1, 0, function()
    for k, v in pairs(player.GetAll()) do
        v:SendLua([[if GetConVar("sv_cheats"):GetBool() == true && GetConVar("sv_cheats"):GetFloat() == 0 then net.Start("Watchdog_convar_mismatch") net.SendToServer() end]])
        v:SendLua([[if GetConVar("sv_allowcslua"):GetBool() == true && GetConVar("sv_allowcslua"):GetFloat() == 0 then net.Start("Watchdog_convar_mismatch") net.SendToServer() end]])
        v:SendLua([[if GetConVar("r_drawothermodels"):GetInt() == 2 && GetConVar("sv_cheats"):GetFloat() == 0 then net.Start("Watchdog_convar_mismatch") net.SendToServer() end]])
		v:SendLua([[if not ConVarExists( "sv_allowcslua" ) then net.Start("Watchdog_convar_mismatch") net.SendToServer() end]])
		v:SendLua([[if not ConVarExists( "sv_cheats" ) then net.Start("Watchdog_convar_mismatch") net.SendToServer() end]])
	end
end)
