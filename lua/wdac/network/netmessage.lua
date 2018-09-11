if CLIENT then

    local wdac_cmdget = {}
    net.Receive("Watchdog_Dumpcmd", function(len)
        print("Hai")
    end)

    chat.AddText( Color( 255, 142, 142 ), "WATCHDOG: ", Color( 255, 255, 255 ), "test" )
end