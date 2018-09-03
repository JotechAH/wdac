if SERVER then

    util.AddNetworkString("Watchdog_Sendcmd")
    util.AddNetworkString("Watchdog_createDumpcmd")
    local wdac_cmdget = {}
    net.Receive("Watchdog_Sendcmd", function(len, ply)
        local wdac_cmdget = net.ReadTable()
        if not string.match(file.Read("wdac/cmdwhitelist.txt", "DATA"), wdac_cmdget[2]) then
            print("\nWatchDog Anti-Cheat: Cheat detection for player: "..ply:Nick())
            print(ply:Nick().."("..ply:SteamID()..") executed the command: "..wdac_cmdget[2])
            print("\n")
            net.Start ("Watchdog_createDumpcmd")
            net.WriteTable( {ply:Nick(), wdac_cmdget[2], ply:SteamID()} )
            for k, v in pairs(player.GetAll()) do 
                if v:IsAdmin() then
                    net.Send( v )
                else
                    
                end
            end
        end
    end)
    
end

if CLIENT then

    net.Receive("Watchdog_createDumpcmd", function(len, ply)
        local Tbl = net.ReadTable()
        local wdacCreatedumpcmduser = Tbl[1]
        local wdacCreatedumpcmdcommand = Tbl[2]
        local wdacCreatedumpcmdsteamid = Tbl[3]
        chat.AddText( Color( 255, 142, 142 ), "WatchDog Anti-Cheat: ", Color( 255, 255, 255 ), Tbl[1].."("..Tbl[3]..")\nexecuted the command: "..Tbl[2] )
    end)

end