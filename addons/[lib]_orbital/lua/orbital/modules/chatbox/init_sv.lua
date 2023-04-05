util.AddNetworkString("os.ToggleChat")
	net.Receive("os.ToggleChat", function(_, ply)
		local status = net.ReadBool()
		ply:SetNWBool("IsTyping", status)
		ply:SetNetVar("IsTyping", status)

	end)