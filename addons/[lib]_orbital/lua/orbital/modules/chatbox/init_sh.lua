
if CLIENT then
	--fuck me ass hole
else
	util.AddNetworkString('sayRaw')
	net.Receive('sayRaw', function(len, pl)
		if (pl.nextSay and pl.nextSay > CurTime()) then
			return
		end

		pl.nextSay = CurTime() + 1

		local bTeam = net.ReadBool()
		local msg = string.Trim(net.ReadString() or "")

		if (msg == "") then return end

		hook.Run("PlayerSay", pl, msg, bTeam)
	end)
end



nw.Register 'IsTyping'
	:Write(net.WriteBool)
	:Read(net.ReadBool)
	:SetPlayer()
	:SetNoSync()


function PLAYER:IsTyping()
	return (self:GetNetVar('IsTyping') == true)
end
