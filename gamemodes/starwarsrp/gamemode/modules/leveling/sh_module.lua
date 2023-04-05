// Init Module
local MODULE = MODULE or RK.Modules:Get( "leveling" )

// Module name
MODULE.name = "Leveling"
// Module author
MODULE.author = "Kirby#2015"
// Module description
MODULE.description = [[
	XP and Leveling system.
]]
MODULE.data = {}

local PLAYER = FindMetaTable( "Player" )

// Calculate player's level up cost
function PLAYER:CalculateLevelupCost()
	local level = self:GetLevel()

	return 200 * ( 1 + ( level / 100 ) * level )
end

// Check if player can levelup
function PLAYER:CheckLevelup()
	local xp = self:GetXP()
	local level = self:GetLevel()
	local calc = self:CalculateLevelupCost()
	
	if xp >= calc then
		self:AddXP( -calc )
		self:AddLevel( 1 )
		return true
	end
	return false
end

// Get the players current xp
function PLAYER:GetXP()
	return self:GetData():GetVar( "xp", 0 )
end

// Get player level
function PLAYER:SetXP( var )
	self:GetData():SetVar( "xp", var )
	self:CheckLevelup()
	return true
end

// Add xp to player
function PLAYER:AddXP( var )
	self:SetXP( math.Round(self:GetXP() + var ) )
	self:CheckLevelup()
	return true
end

// Get level
function PLAYER:GetLevel()
	return self:GetData():GetVar( "level", 1 )
end

// Set level
function PLAYER:SetLevel( var )
	self:GetData():SetVar( "level", var )
	return true
end

// Add Level
function PLAYER:AddLevel( var )
	self:SetLevel( self:GetLevel() + var )
	self:Notify( "You are now level ".. self:GetLevel() .."!" )
	hook.Run( "RK:Levelup" )

	return true
end

function PLAYER:GetXPSalary()
	local xp = RK.Config:Get( "XP Per Time", 50 )
	local lvl = self:GetLevel()
	xp = xp + (math.floor(lvl / 10))
	return xp
end


if SERVER then
	hook.Add( "PlayerSpawn", "RK:Leveling:PlayerSpawn", function( ply )
		--print(ply:GetLevel())
		if timer.Exists( "RK.Leveling"..ply:SteamID64() ) then
			timer.Remove( "RK.Leveling"..ply:SteamID64() )
		end

		timer.Create( "RK:Leveling"..ply:SteamID64(), 300, 0, function()
			if IsValid( ply ) then
				ply:AddXP( ply:GetXPSalary() )
				ply:Notify( "You have gained "..ply:GetXPSalary().."xp for staying alive." )
			end
		end )
	end )
	hook.Add( "PlayerDeath", "RK:Leveling:PlayerDeath", function( ply )
		if timer.Exists( "RK.Leveling"..ply:SteamID64() ) then
			timer.Remove( "RK.Leveling"..ply:SteamID64() )
		end
	end )
	hook.Add( "PlayerDisconnected", "RK:Leveling:PlayerDisconnected", function( ply )
		if timer.Exists( "RK.Leveling"..ply:SteamID64() ) then
			timer.Remove( "RK.Leveling"..ply:SteamID64() )
		end
	end )
end