RK = RK or {}

local DataStorage = {}
DataStorage.__tostring = function( s )
	return util.TableToJSON( s.vars )
end
DataStorage.__index = DataStorage

function DataStorage:SetupDatatables()
	self.vars = {}
	if !mysql then return end
	local query = mysql:Select( "player_data" )
	query:Select( "data" )
	query:Where( "id", self.id )
	query:Callback( function( result )
		if !istable( result ) or !result[1] then
			local query = mysql:Insert("player_data")
			query:Insert("id", self.id )
			query:Insert("data", util.TableToJSON( self.vars or {}))
			query:Execute()
			self.vars = self.vars or {}
			hook.Run( "DataStorage:Initialized", self.owner )
		return end
		
		self.vars = util.JSONToTable( result[1].data )
		hook.Run( "DataStorage:Initialized", self.owner )
		timer.Simple( 2, function() RK.Net:SendNetData( "DataStorage:TransmitAll", { owner = self.owner, vars = self.vars }, "*" ) end )
	end )
	query:Execute()

	hook.Run( "DataStorage:SetupDataTables", self )
end

function DataStorage:New( ply )
	if !ply or !IsValid( ply ) then return {} end

	local newObject = setmetatable( {}, DataStorage )
	
	newObject.owner = ply
	newObject.id = ply:SteamID64() .. "_1"
	newObject.vars = {}

	if SERVER then
		newObject:SetupDatatables()
	end

	return newObject
end

function DataStorage:Init( ply )
	if !ply or !IsValid( ply ) then return false end
	if ply.Data then
		if SERVER then hook.RunOrder( "DataStorage:Initialized", ply ) end
	return ply.Data end

	ply.Data = self:New( ply )
	if SERVER then hook.RunOrder( "DataStorage:Initialized", ply ) end
	
	return ply.Data
end

function DataStorage:GetOwner()
	return self.owner
end

function DataStorage:Save()
	if !SERVER then return end

	local ply = self.owner

	if !ply or !IsValid( ply ) then return false end
	if !mysql then return false end

	local query = mysql:Update( "player_data" )
	query:Update( "data", util.TableToJSON( self.vars or {}) )
	query:Where( "id", self.id )
	query:Execute()
	
end

function DataStorage:SetVar( name, value )
	if !SERVER then return end

	local ply = self.owner

	if !ply or !IsValid( ply ) then return false end

	self.vars[ name ] = value

	self:Save()

	RK.Net:SendNetData( "DataStorage:TransmitVar", { owner = ply, var = name, value = value }, "*" )
	return true
end

hook.AddOrder( "PlayerOrderSpawnInit", 1, function( ply )
	DataStorage:Init( ply )
		
	timer.Simple( 2.05, function()
		local storage = {}
		for k, v in pairs( player.GetAll() ) do
			table.insert( storage, { player = v, data = v.Data and v.Data.vars or {} } )
		end
			
		RK.Net:SendNetData( "DataStorage:TransmitStorage", storage, ply )
	end )
	
end )

function DataStorage:GetVar( name, redundancy )
	local ply = self.owner

	if !ply or !IsValid( ply ) then return false end
	
	self.vars = self.vars or {}

	return self.vars[ name ] and self.vars[ name ] or redundancy
end


function DataStorage:ClearVar( name ) -- Only used for classes, can be very bad news if else
	if !SERVER then return end

	local ply = self.owner

	if !ply or !IsValid( ply ) then return false end
	
	local tbl = self.vars
	
	for k,v in pairs(tbl) do
		if tostring(k) == tostring(name) then
			tbl[k] = nil
			--print("Ladies and gentlemen, we got em")
			break
		end
	end

	self:Save()

	RK.Net:SendNetData( "DataStorage:TransmitVar", { owner = ply, var = name, value = value }, "*" )
	return true
end


local meta = FindMetaTable( "Player" )

function meta:GetData()
	self.Data = self.Data or DataStorage:Init( self )
	return self.Data
end

hook.Add( "PostNetInit", "DataStorage:PostNetInit", function()
	RK.Net:ReceiveNetData( "DataStorage:TransmitAll", function( ply, data )
		if !CLIENT then return end
		if !IsValid( data.owner ) then return end

		data.owner.Data = data.owner.Data or DataStorage:Init( data.owner )
		data.owner.Data.vars = data.vars
	end )
	    RK.Net:ReceiveNetData( "DataStorage:TransmitVar", function( ply, data )
        if !CLIENT then return end
        if !data.owner then return end
		local data = data
        data.owner.Data = data.owner.Data or DataStorage:Init( data.owner )
        if !data.owner.Data then
            timer.Simple( 1, function(data) local data = data or nil if data != nil then data.owner.Data.vars[ data.var ] = data.value end end )
        else
            data.owner.Data.vars[ data.var ] = data.value
        end
        hook.Run( "DataStorage:VarChanged", data.owner, data.var, data.value )
    end )

	RK.Net:ReceiveNetData( "DataStorage:TransmitStorage", function( ply, data )
		if !CLIENT then return end

		for k, v in pairs( data ) do
			if IsValid( v.player ) then
				v.player.Data = v.player.Data or DataStorage:Init( v.player )
				v.player.Data.vars = v.data
			end
		end
	end )
end )

hook.Add( "DatabaseConnected", "DataStorage:DatabaseConnected", function()
	MsgC( Color( 255, 0, 0 ), "[RK] " , Color( 255, 255, 255 ), "MYSQL DataStorage Initialized\n" )
	
	local query = mysql:Create("player_data")
		query:Create("id", "VARCHAR(255) NOT NULL")
		query:Create("data", "LONGTEXT")
		query:PrimaryKey("id")
	query:Execute()
end )