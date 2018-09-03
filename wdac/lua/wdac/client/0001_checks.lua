timer.Simple( 30,function()

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
	local watchdogblacklist =
	{
		"aimbot",
		"*******",
		"esp",
		"gDaap",
		"SmegHack_Menu",
		"hack",
		"wallhack",
		"HL_MENU",
		"hl_menu",
		"lenny_reload",
		"+hera_menu",
		"+hera_aim",
		"record_w",
		"hax",
	}
	timer.Create(private_key, 5, 0, function()
			pcall (
				function ()
					for commandName, _ in pairs (concommand.GetTable ()) do
						for _, blacklistedfragment in ipairs (watchdogblacklist) do
							if string.find (commandName, blacklistedfragment) then
								net.Start ("Watchdog_FoundFragment")
								net.SendToServer ()
							end
						end
					end
					for eventName, eventTable in pairs (hook.GetTable ()) do
						for hookName, f in pairs (eventTable) do
							for _, blacklistedfragment in ipairs (watchdogblacklist) do
								if string.find (hookName, blacklistedfragment) then
									net.Start ("Watchdog_FoundFragment")
									net.SendToServer ()
								end
							end
						end
					end
				end
			)
		end
	)
end )
