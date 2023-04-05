// Init Module.
local MODULE = MODULE or RK.Modules:Get( "flags" )

// Module name.
MODULE.name = "Flags"
// Module author.
MODULE.author = "Kirby#2015"
// Module description.
MODULE.description = [[
	Flag system.
]]

RK.Flags = MODULE

local meta = FindMetaTable( "Player" )

// Flag meta
function meta:HasFlag( flag )
	local reg_flags = RK.Regiment:GetFlags( self:GetRegiment())[ flag ]
	local ply_flags = self:GetData():GetVar( "Flags", {} )[ flag ]
	local class_flags = false
	local class = ""
	
	if self:GetPlayerClass() then
		class = self:GetRegimentClasses()[self:GetPlayerClass()]
		if class.flags then
			return true
		end
	end

	if reg_flags then
		return true
	end

	if ply_flags then
		return true
	end

	local hook_flags = hook.Run( "PlayerHasFlag", self, flag )

	return false
end

if SERVER then
	function meta:GiveFlag( flag )
		local ply_flags = self:GetData():GetVar( "Flags", {} )
		ply_flags[ flag ] = true
		self:GetData():SetVar( "Flags", ply_flags )
	end

	function meta:RemoveFlag( flag )
		local ply_flags = self:GetData():GetVar( "Flags", {} )
		ply_flags[ flag ] = nil
		self:GetData():SetVar( "Flags", ply_flags )
	end
end