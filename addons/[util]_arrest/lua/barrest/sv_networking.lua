util.AddNetworkString("ArrestPositions")
util.AddNetworkString("ArrestPlayers")
util.AddNetworkString("ArrestReady")
util.AddNetworkString("ArrestedPly")

function bArrest.NetworkPositions(ply)
	if IsValid(ply) then
		net.Start("ArrestPositions")
			net.WriteTable(bArrest.Positions)
		net.Send(ply)
	else
		net.Start("ArrestPositions")
			net.WriteTable(bArrest.Positions)
		net.Broadcast()
	end
end

function bArrest.NetworkPlayers(ply)
	if IsValid(ply) then
		net.Start("ArrestPlayers")
			net.WriteTable(bArrest.Players)
		net.Send(ply)
	else
		net.Start("ArrestPlayers")
			net.WriteTable(bArrest.Players)
		net.Broadcast()
	end
end

net.Receive("ArrestReady", function(len, ply)
	if ply.ArrestsSent then return end
	ply.ArrestsSent = true

	bArrest.NetworkPositions(ply)
	bArrest.NetworkPlayers(ply)
end)

net.Receive("ArrestedPly", function(len,ply) 
	if ! ply:CanArrest() then return end
	local Reason = net.ReadString()
	local Time = net.ReadString()
	local Bail = net.ReadString()
	
	--PromptArrester(player)
	
	--ply.ArrestedPlayers = {}
	if not ply.ArrestedPlayers then return end
	for k,v in pairs(ply.ArrestedPlayers) do
		if v == ArrestedPlayer then
			ply.ArrestedPlayers[k] = nil
		end
	end
	print("Bruh!")

end )
