if SERVER then
    
    concommand.Add("wdac_reset",function()
        if not ply:IsValid() then
            print("Are you sure you want to do this?\n\nThis will remove the following files:\nwdac/incidents.txt\nwdac/wdacbans.txt\n\nType 'wdac_reset' again to confirm.")
            concommand.Add("wdac_reset",function()
                print("Resetting WatchDog Anti-Cheat")
                file.Write( "wdac/incidents.txt", "" )
                file.Write( "wdac/wdacbans.txt", "" )
                print("Reset complete!")
                concommand.Remove( "wdac_reset" )
            end)
        end
    end)

end
