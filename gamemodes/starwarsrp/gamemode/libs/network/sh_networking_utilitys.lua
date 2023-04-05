local isstring, istable, isentity, pairs, util, string, net = isstring, istable, isentity, pairs, util, string, net

RK = RK or {}
RK["Net"] = RK["Net"] or {}
RK["Net"]["Storage"] = RK["Net"]["Storage"] or {}

--[[
	Net Utilities.
]]--

// Check a newtwork string has been created.
function RK.Net:CheckNWStrings( msg )
	if not SERVER then return false end
	if not self[ "Storage" ][ msg ] then
		util.AddNetworkString( msg )
		self[ "Storage" ][ msg ] = true
	return true end
return false end

// Obsfuscate a entity to a string.
function RK.Net:EscapeEntities( tbl, bool )
	if not tbl then return {} end
	if bool then
		for k, v in pairs( tbl ) do
			if istable( v ) then
				tbl[ k ] = self:EscapeEntities( v, true )
			end
			if isentity( v ) then
				tbl[ k ] = "e;_" .. v:EntIndex()
			end

		end
		return tbl
	else
		for k, v in pairs( tbl ) do
			if istable( v ) then
				tbl[ k ] = self:EscapeEntities( v, false )
			end
			if isstring( v ) and string.find( v, "e;_" ) then
				tbl[ k ] = Entity( string.gsub( v, "e;_", "" ) )
			end
		end
		return tbl
	end
end

// Compress a table to data.
function RK.Net:Compress( data )

	data = RK.Net:EscapeEntities( data, true )

	data = util.TableToJSON( data )
	data = util.Compress( data )

	return data
end

// Uncompress a to a table.
function RK.Net:Decompress( data )

	// Decompress the variable
	data = util.Decompress( data )
	// Convert the variable to a table from JSON.
	data = util.JSONToTable( data )

	// Unobfuscate the table.
	data = RK.Net:EscapeEntities( data, false )
	
	// Return the sanitized table.
	return data
end

// Convert variable to a table if not already a table.
function RK.Net:ConvertData( data )

	// Check to see if the data is a table.
	if istable( data ) then return data end

	// Convert the data to a table.
	return { data }

end

// Send a compressed network message to a player or server. 
function RK.Net:SendNetData( msg, data, target, dev )
	// Check to see if the message has been created.
	self:CheckNWStrings( msg )

	// Check to see if the data is valid.
	if not data then return false end
	// Check to see if the data is a table.
	if not istable( data ) then
		// Convert the data into a table.
		data = self:ConvertData( data )
	end

	// Ensure the data is compressed.
	if not istable( data ) then
		ErrorNoHaltWithStack( "Unable to convert data to table.", msg, data, target, dev )
	return end
	// Check the size of the data.
	local before = #util.TableToJSON( data )

	// Compress the data.
	data = self:Compress( data )

	// Check if we should print developer information.
	if dev then
		print( "Sending message: '" .. msg .. "' at compression ratio of 1:" .. math.Round( before / #data, 2 ), before, #data )
	end

	// Send the netmessage to either the client or server.
	net.Start( msg )
	net.WriteString( tostring( #data ) )
	net.WriteData( data, #data )
	if !target or ( isstring( target ) and string.lower( target ) == "server" ) then
		net.SendToServer()
	elseif SERVER and isentity( target ) then
		net.Send( target )
	elseif SERVER and target == "*" then
		net.Broadcast()
	end
end

// Send a compressed network message with printouts.
function RK.Net:SendNetDataDEV( msg, data, target )
	self:SendNetData( msg, data, target, true )
end

// Receive a compressed network message.
function RK.Net:ReceiveNetData( msg, func )
	if not msg then return end
	if not func then return end

	self:CheckNWStrings( msg )
	RK:Print( msg .. " Net Handler Registered." )
	net.Receive( msg, function( _, ply )
		if CLIENT then ply = LocalPlayer() end

		local len = net.ReadString()
		local data = net.ReadData( tonumber( len ) )

		data = self:Decompress( data )

		func( ply, bool and data[1] or data )

	end )
end

// Get the players meta table
local plyMeta = FindMetaTable( "Player" )

// Send a compressed network message to a player or server depending on realm.
function plyMeta:SendNetMessage( name, data, prnt )
	RK.Net:SendNetData( name, data, SERVER and self or "server", prnt and prnt or false )
end

// Run the hook to ensure registered net messages are sent.