timer.Simple( 30,function()

	local wdac_ccr = concommand.Run

	function concommand.Run(ply, cmd, args)
		if !IsValid(ply) then return wdac_ccr(ply,cmd,args) end
		if !cmd then return wdac_ccr(ply,cmd,args) end
		
		if not string.find( table.ToString(WDAC.TblDump), cmd) then
			if args and args ~= "" then
				net.Start ("Watchdog_Sendcmd")
				net.WriteTable( {ply:Nick(), cmd} )
				net.SendToServer ()
			end
		end

		return wdac_ccr(ply, cmd, args)

	end

end )