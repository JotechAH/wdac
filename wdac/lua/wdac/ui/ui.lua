
net.Receive("Watchdog_SendKickTimeout", function(len, ply)
    local Timeout = net.ReadTable()
    chat.AddText( Color( 255, 142, 142 ), "WatchDog Anti-Cheat: ", Color( 255, 255, 255 ), Timeout[1].."("..Timeout[2]..")\nis about to get kicked in 10 seconds due to a convar mismatch." )
end)

net.Receive("Watchdog_SendBanTimeout", function(len, ply)
    local Timeout = net.ReadTable()
    chat.AddText( Color( 255, 142, 142 ), "WatchDog Anti-Cheat: ", Color( 255, 255, 255 ), Timeout[1].."("..Timeout[2]..")\nis about to get banned in 10 seconds for loading a cheat." )
end)



local function wdacui()

    local gf = vgui.Create( "DFrame" )
    gf:SetSize( 1000, 600 )
    gf:Center()
    gf:SetTitle( "" )
    gf:ShowCloseButton( false )
    gf:SetDraggable( false )
    gf:MakePopup()
    gf.Paint = function( self, w, h )
        draw.RoundedBox( 0, 0, 0, w, h, Color( 236, 240, 241, 255 ) )
        draw.SimpleText("WatchDog Anti-Cheat", "wdac_title", 85, 12, Color(0,0,0,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    local sheet = vgui.Create( "DPropertySheet", gf )

	local closebutton = vgui.Create( 'DButton' )
	closebutton:SetParent( gf )
    closebutton:SetText( '' )
	closebutton:SetPos( 930, 5 )
	closebutton.Paint = function()
        if closebutton:IsHovered() then
            surface.SetDrawColor( 255, 0, 0, 255)
            surface.DrawRect( 0, 0, closebutton:GetWide(), closebutton:GetTall() )
            draw.SimpleText("X", "wdac_cbutton", 32, 10, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        else
            surface.SetDrawColor( 255, 255, 255, 255)
            surface.DrawRect( 0, 0, closebutton:GetWide(), closebutton:GetTall() )
            draw.SimpleText("X", "wdac_cbutton", 32, 10, Color(0,0,0,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
	end
	closebutton.DoClick = function ()
		gf:Close() 
	end



    local panel1 = vgui.Create( "DPanel", sheet )
    panel1.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, Color( 255, 255, 255, self:GetAlpha() ) ) end


    local panel2 = vgui.Create( "DPanel", sheet )
    panel2.Paint = function(s,w,h)
        draw.RoundedBox( 0, 0, 0, w, h, Color( 200, 200, 200, s:GetAlpha() ) )
        draw.RoundedBox( 0, 7, 10, 760, 410, Color( 250, 250, 250, s:GetAlpha() ) )


        draw.RoundedBox( 0, 148.9, 48.9, 504, 24, Color( 200, 200, 200, s:GetAlpha() ) )
        draw.RoundedBox( 0, 148.9, 48.9+30, 504, 24, Color( 200, 200, 200, s:GetAlpha() ) )
        draw.RoundedBox( 0, 148.9, 48.9+60, 504, 24, Color( 200, 200, 200, s:GetAlpha() ) )

        draw.RoundedBox( 0, 148.9+530, 48.9, 59, 24, Color( 200, 200, 200, s:GetAlpha() ) )
        draw.RoundedBox( 0, 148.9+530, 48.9+60, 59, 24, Color( 200, 200, 200, s:GetAlpha() ) )
    end

    --Sheet configuration
    sheet:Dock( FILL )

    sheet:AddSheet( "Players", panel1, "icon16/group_gear.png" )
    sheet:AddSheet( "Configuration", panel2, "icon16/cog_edit.png" )


    sheet:SetFadeTime( 0.2 )
    sheet.Paint = function(s,w,h)
    draw.RoundedBox(0,0,0,w,h,Color(255,255,255))
    end


end

concommand.Add("+wdac_menu", wdacui)