if SERVER then
    
    util.AddNetworkString( "wdac_setupcmd_table" )

    hook.Add( "PlayerSay", "wdac_autosetup_cmd", function( ply, text, public )
        if string.lower( text ) == "!wdac_cmdsetup" && ply:IsSuperAdmin() then
            
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

end