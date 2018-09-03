if SERVER then
    
    if !file.Exists( "wdac", "DATA" ) then print("WatchDog wdac folder does not exist. Creating!") file.CreateDir( "wdac" ) end
    if !file.Exists( "wdac/wdacbans.txt", "DATA" ) then print("\n~=WatchDog Anti-Cheat first time setup=~\nWatchDog ban file does not exist. Creating!") file.Write( "wdac/wdacbans.txt", "" ) end
    if !file.Exists( "wdac/incidents.txt", "DATA" ) then print("WatchDog incidents file does not exist. Creating!") file.Write( "wdac/incidents.txt", "" ) end
    if !file.Exists( "wdac/cmdwhitelist.txt", "DATA" ) then print("WatchDog CMD Whitelist does not exist. Creating!\nTo whitelist commands, Just place your whitelisted commands in 'data/wdac/cmdwhitelist.txt'") file.Write( "wdac/cmdwhitelist.txt", "+menu\n-menu\n" ) end

end