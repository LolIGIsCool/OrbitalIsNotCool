RK = RK or {}
RK.Config = RK.Config or {}
RK.Config.data = RK.Config.data or {}

--[[
	Config Core.
]]--

hook.Add( "PostNetInit", "RK.Config:PostNetInit", function()
	RK.Net:CheckNWStrings( "Config Update" )
end )

// Register a new config variable.
function RK.Config:Register( name, var, realm )
	local realm = realm and string.lower( realm ) or "shared"
	
	if self.data[ name ] then return end
	self.data[ name ] = { var = var, realm = realm and realm or "Shared", default = var }
end

// Set a config variable.
function RK.Config:Set( name, var )
	if !SERVER then return end
	if !self.data[ name ] then return end
	if self.data[ name ][ "realm" ] == "Server" and CLIENT then return end
	if self.data[ name ][ "realm" ] == "Client" and SERVER then return end

	self.data[ name ] = var

	// Send a compressed config update to all clients
	if self.data[ name ][ "realm" ] == "Shared" and SERVER then
		RK.Net:SendNetData( "Config Update", { var = self.data[ name ][ "var" ], name = name }, "*" )
		hook.Run( "RKConfig:Update", name, var )
	end
end

hook.Add( "PostNetInit", "Config:PostNetInit", function()
	if CLIENT then
		// Receive a compressed netmessage containing a config update and update the server.
		RK.Net:ReceiveNetData( "Config Update", function( ply, data )
			RK.Config:Set( data.name, data.var )
		end )
		RK.Net:ReceiveNetData( "Request Config", function( ply, data )
			hook.Run( "ReceivedConfig", data )
		end )
	end
	if SERVER then
		RK.Net:ReceiveNetData( "Request Config", function( ply, data )
			RK.Config:RequestAllConfig( ply ) -- Send all config variables to the client.
		end ) 
		RK.Net:ReceiveNetData( "Full Update Config", function( ply, data )
			if !ply:IsAdmin() then return end -- Only admins can do this.
			self.data = data -- Set the config data to the received data.
		end ) -- Receive a compressed netmessage containing a full config update.
	end
end )

// Get a config variable or if it doesnt exist, return a default value.
function RK.Config:Get( name, redundancy, forceupdate )
	if !name then return self.data end

	local target = self.data[ name ]
	if !target then return redundancy end

	if isfunction( target[ "var" ] ) then return target[ "var" ]( target ) end
	return target[ "var" ]
end

// Client Request a full list of config.
function RK.Config:RequestAllConfig( ply )
	if !ply or !ply:IsPlayer() then return end
	if !ply:IsAdmin() then return end
	
	if CLIENT then
		RK.Net:SendNetData( "Request Config", {}, "server", true )
	else
		ply:SendNetMessage( "Request Config", self.data )
	end

end

// Register font config variables.
if CLIENT then
	RK.Config:Register( "Title Font", RKFont( 72 ), "Client" )
	RK.Config:Register( "Sub Title Font", RKFont( 32 ), "Client" )
	RK.Config:Register( "Description Font", RKFont( 20 ), "Client" )
end

RK.Config:Register( "Title Color", Color( 255, 255, 255, 255 ), "Shared" )
RK.Config:Register( "Sub Title Color", Color( 255, 255, 255, 255 ), "Shared" )
RK.Config:Register( "Description Color", Color( 255, 255, 255, 255 ), "Shared" )
RK.Config:Register( "Background Color", Color( 255, 255, 255, 255 ), "Shared" )
RK.Config:Register( "Sub-background Color", Color( 255, 255, 255, 255 ), "Shared" )

RK.Config:Register( "XP Per Time", 50, "Shared" )
RK.Config:Register( "Time For XP", 300, "Shared" )

RK.Config:Register( "Salary Default", 100, "Shared" )