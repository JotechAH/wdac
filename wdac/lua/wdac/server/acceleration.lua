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

hook.Add("OnPlayerHitGround", private_key, function(player)
	player:SetVelocity( - player:GetVelocity() / 10 )
end)