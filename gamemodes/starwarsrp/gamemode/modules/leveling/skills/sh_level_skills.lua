local MODULE = MODULE or RK.Modules:Get( "leveling" )
local PLAYER = FindMetaTable( "Player" )

MODULE.data = MODULE.data or {}

function MODULE:RegisterSkill( name, tbl )
	self.data[name] = tbl

	// Set function for skill levels
	PLAYER[ "Set" .. name .. "Level" ] = function( s, var )
		local skill_tbl = s:GetData():GetVar( "PlayerSkills", {} )
		skill_tbl[name] = skill_tbl[name] and skill_tbl[name] or { level = 1, xp = 0 }
		s:GetData():SetVar( "PlayerSkills", skill_tbl )
		return true
	end
	// Get function for skill levels
	PLAYER[ "Get" .. name .. "Level" ] = function( s )
		local skill_tbl = s:GetData():GetVar( "PlayerSkills", {} )
		return skill_tbl[name] and skill_tbl[name][ "level" ] or 0
	end
	// Add function for skill levels
	PLAYER[ "Add" .. name .. "Level" ] = function( s, var )
		local skill_tbl = s:GetData():GetVar( "PlayerSkills", {} )
		skill_tbl[name] = skill_tbl[name] and skill_tbl[name] or { level = 1, xp = 0 }
		skill_tbl[name][ "level" ] = skill_tbl[name][ "level" ] + var
		s:GetData():SetVar( "PlayerSkills", skill_tbl )
		return true
	end

	// Set function for skill xp
	PLAYER[ "Set" .. name .. "XP" ] = function( s, var )
		local skill_tbl = s:GetData():GetVar( "PlayerSkills", {} )
		skill_tbl[name] = skill_tbl[name] and skill_tbl[name] or { level = 1, xp = 0 }
		skill_tbl[name][ "xp" ] = var
		s:GetData():SetVar( "PlayerSkills", skill_tbl )
		return true
	end
	// Get function for skill xp
	PLAYER[ "Get" .. name .. "XP" ] = function( s )
		local skill_tbl = s:GetData():GetVar( "PlayerSkills", {} )
		return skill_tbl[name] and skill_tbl[name][ "xp" ] or 0
	end
	// Add function for skill xp
	PLAYER[ "Add" .. name .. "XP" ] = function( s, var )
		local skill_tbl = s:GetData():GetVar( "PlayerSkills", {} )
		skill_tbl[name] = skill_tbl[name] and skill_tbl[name] or { level = 1, xp = 0 }
		skill_tbl[name][ "xp" ] = skill_tbl[name][ "xp" ] + var
		s:GetData():SetVar( "PlayerSkills", skill_tbl )

		local level = skill_tbl[ name ][ "level" ]
		local cost = ( self.data[name].levelcost ) * (level ^ 2 * (1 * level / 100) + 1) --- ( 1 + ( level / 100 ) * level )
		if skill_tbl[name][ "xp" ] >= cost then
			skill_tbl[name][ "xp" ] = skill_tbl[name][ "xp" ] - cost
			skill_tbl[name][ "level" ] = skill_tbl[name][ "level" ] + 1
			s:GetData():SetVar( "PlayerSkills", skill_tbl )
			
		end
		return true
	end
end

MODULE:RegisterSkill( "Mining", {
	[ "levelcost" ] = 100,
	[ "maxlevel" ] = 100,
} )
MODULE:RegisterSkill( "Endurance", {
	[ "levelcost" ] = 100,
	[ "maxlevel" ] = 100,
} )
MODULE:RegisterSkill( "Alchemy", {
	[ "levelcost" ] = 100,
	[ "maxlevel" ] = 100,
} )
MODULE:RegisterSkill( "Herbalism", {
	[ "levelcost" ] = 100,
	[ "maxlevel" ] = 100,
} )

function MODULE:GetSkill( name )
	return self.data[name]
end