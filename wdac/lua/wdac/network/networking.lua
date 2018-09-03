if SERVER then

    util.AddNetworkString("Watchdog_convar_mismatch")
    util.AddNetworkString("Watchdog_FoundFragment")
    util.AddNetworkString("Watchdog_SendKickTimeout")
    util.AddNetworkString("Watchdog_SendBanTimeout")

    net.Receive("Watchdog_convar_mismatch", function(len, ply)
        if not timer.Exists( "wdac_cvar_timeout" ) then
            file.Append( "wdac/incidents.txt", "CONVAR MISMATCH:\r\nName: "..ply:Name().."\r\nSteamID: "..ply:SteamID().."\r\n"..os.date( "%d/%m/%Y %H:%M:%S" ).."\r\n\r\n" )
            net.Start ("Watchdog_SendKickTimeout")
            for k, v in pairs(player.GetAll()) do 
                if v:IsAdmin() then
                    net.WriteTable( {ply:Nick(), ply:SteamID()} )
                    net.Send( v )
                end
            end
            timer.Create("wdac_cvar_timeout", 10, 1,function()
                if ply:IsValid() then
                    print("\nSuccessfully WDAC kicked player: "..ply:Nick().."\n")
                    ply:Kick("\nWatchDog Anti-Cheat\n\nClient and server are out of sync.\nRestart your game without modifying your ConVars(Console Variables) if you think this is an error")
                else
                    print("WDAC Kick aborted: Player left")
                    print("More information was saved into incidents.txt")
                end
            end)
        end
    end)
    net.Receive("Watchdog_FoundFragment", function(len, ply)
        if not timer.Exists( "wdac_fragment_timeout" ) then
            file.Append("wdac/wdacbans.txt", '"'..ply:SteamID()..'"\r\n')
            file.Append( "wdac/incidents.txt", "CHEAT DETECTION:\r\nName: "..ply:Name().."\r\nSteamID: "..ply:SteamID().."\r\n"..os.date( "%d/%m/%Y %H:%M:%S" ).."\r\n\r\n" )
            net.Start ("Watchdog_SendBanTimeout")
            for k, v in pairs(player.GetAll()) do 
                if v:IsAdmin() then
                    net.WriteTable( {ply:Nick(), ply:SteamID()} )
                    net.Send( v )
                end
            end
            timer.Create("wdac_fragment_timeout", 10, 1,function()
                if ply:IsValid() then
                    print("\nSuccessfully WDAC banned player: "..ply:Nick().."\n")
                    ply:Kick("\nWatchDog Anti-Cheat\n\nWatchDog was monitoring your game and gained enough evidence to suspend your account.\nIf you belive this is an error contact your server administrator")
                else
                    print("WDAC Ban aborted: Player left.")
                    print("Player was successfully WDAC banned.")
                    print("More information was saved into incidents.txt")
                end
            end )

        end
    end)

end