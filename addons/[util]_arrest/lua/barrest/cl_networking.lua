hook.Add("HUDPaint", "ArrestReady", function()
	hook.Remove("HUDPaint", "ArrestReady")

	net.Start("ArrestReady")
	net.SendToServer()
end)

net.Receive("ArrestedPly", function(len,ply) 
	local player = net.ReadString()
	
	PromptArrester(player)

end )