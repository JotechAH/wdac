if SERVER then
    
    util.AddNetworkString( "wdac_setupcmd_table" )

    hook.Add( "PlayerSay", "wdac_autosetup_cmd", function( ply, text, public )
        if string.lower( text ) == "!wdac_cmdsetup" && ply:IsSuperAdmin() then
            ply:SendLua([[chat.AddText( Color( 255, 142, 142 ), "WatchDog Anti-Cheat: ", Color( 255, 255, 255 ), "This may take a moment depending on the amount of addons that are on the server!" )]])
            ply:SendLua([[local Tbl = {concommand.GetTable()} net.Start("wdac_setupcmd_table") net.WriteString(table.ToString(Tbl)) net.SendToServer()]])
            return ""
        
        end
    end )

    net.Receive("wdac_setupcmd_table", function(len, ply)

        if ply:IsSuperAdmin() then
    
            local Tbl = net.ReadString()
            file.Write( "wdac/cmdwhitelist.txt", Tbl )

            ply:SendLua([[chat.AddText( Color( 255, 142, 142 ), "WatchDog Anti-Cheat: ", Color( 255, 255, 255 ), "All default commands has now been saved & whitelisted!" )]])

        end

    end)

    util.AddNetworkString( "wdac_setuphook_table" )

    hook.Add( "PlayerSay", "wdac_autosetup_hook", function( ply, text, public )
        if string.lower( text ) == "!wdac_hooksetup" && ply:IsSuperAdmin() then
            ply:SendLua([[chat.AddText( Color( 255, 142, 142 ), "WatchDog Anti-Cheat: ", Color( 255, 255, 255 ), "This may take a moment depending on the amount of addons that are on the server!" )]])
            ply:SendLua([[local Tbl = {hook.GetTable()} net.Start("wdac_setuphook_table") net.WriteString(table.ToString(Tbl)) net.SendToServer()]])
            return ""
        
        end
    end )

    net.Receive("wdac_setuphook_table", function(len, ply)

        if ply:IsSuperAdmin() then
    
            local Tbl = net.ReadString()
            file.Write( "wdac/hookwhitelist.txt", Tbl )

            ply:SendLua([[chat.AddText( Color( 255, 142, 142 ), "WatchDog Anti-Cheat: ", Color( 255, 255, 255 ), "All default hooks has now been saved & whitelisted!" )]])

        end

    end)
    

end