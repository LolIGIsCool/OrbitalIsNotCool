RK = RK or {}

-- if RK.Register then return end

local META = {}
META.__tostring = function( s )
	print( s[ "data" ] )
	return util.TableToJSON( s[ "data" ] )
end

META.data = {}

META.__index = META

function META:New( tbl )
	local newObject = setmetatable( tbl and tbl or {}, META )
	newObject.data = {}
	return newObject
end

function META:Add( name, data, overide )
	data.name = name

	if !overide and self.OnRegister then data = self:OnRegister( data ) end

	self[ "data" ][ name ] = data

	return self[ "data" ][ name ]
end

function META:Get( name, redundancy )
	if !self[ "data" ][ name ] then return false end

	return self[ "data" ][ name ]
end

function META:GetAll()
	return self[ "data" ]
end

function META:GetCount()
	return table.Count( self[ "data" ] )
end

function META:GetByMember( member, value )

	for k, v in pairs( self:GetAll() ) do
		if v[ member ] and v[ member ] == value then
			 --print( k, v, member, v[member], value )
		return v end
	end

	return false
end

RK.Register = META