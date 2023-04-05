local MODULE = MODULE or RK.Modules:Get( "regiments" )

-- Hook called when player spawns, Sets their regiment, Team, Color, Bodygroups, Model, Max Health, Max Armor, and Max Armor, Walk Speed,
-- Run Speed, Jump Power, and crouch speed, Then gives them weapons that are assigned to their regiment.

function RK.Regiment:RunPlayerSpawn( ply )
	if !IsValid( ply ) then return end
	if !ply:Alive() then return end

	local t = ply:GetData():GetVar( "Regiment", 1 )
	if !t then t = 1 end
	local t_data = RK.Regiment:GetByMember( "team_num", t )
	--PrintTable(t_data)
	local c_data = ply:GetPlayerClass()

	local r_data = t_data.ranks[ ply:GetRegimentRank() ] and t_data.ranks[ ply:GetRegimentRank() ] or t_data.ranks[ 1 ]
	local cl_data = ply:GetRegimentRankCl()
	
	local class = {}
	if c_data and c_data and t_data.classes[c_data] then
		class = t_data.classes[c_data]
	end
	
	local model = ( r_data and r_data[ "model" ] ) and r_data[ "model" ] or t_data.model and t_data.model or "models/player/kleiner.mdl"
	local skin = ( r_data and r_data[ "skin" ] ) and r_data[ "skin" ] or t_data.skin and t_data.skin or 0
	local colour = ( r_data and r_data[ "colour" ] ) and r_data[ "colour" ] or t_data.colour and t_data.colour or Color( 255, 255, 255 )
	local bodygroups = ( r_data and r_data[ "bodygroups" ] ) and r_data[ "bodygroups" ] or t_data.bodygroups and t_data.bodygroups or ""
	
	if not (class == {}) then
		model = class.model or model
		skin = class.skin or skin
		colour = class.colour or colour
		bodygroups = class.bodygroups or colour
	end
	
	ply:SetModel( model )
	ply:SetSkin( skin )
	--ply:SetColor( colour )
	ply:SetBodyGroups( bodygroups )
	ply:SetModelScale( class.modelscale or t_data.modelscale or 1 )

	timer.Simple( 0.4, function()
		ply:SetupHands()
	end ) -- Setup the player's hands after hook run order to allow the player to be setup properly

	ply:SetMaxHealth( ply:GetMaxHealth() + ( t_data.health or 100 ) + (class.health or 0) )
	ply:SetHealth( ply:Health() + ( t_data.health or 100 ) + (class.health or 0) )

	ply:SetMaxArmor( ply:GetMaxArmor() + ( t_data.armour or 0 ) + (class.armour or 0) )
	ply:SetArmor( ply:Armor() + ( t_data.armour or 0 ) + (class.armour or 0) )

	ply:SetJumpPower( ply:GetJumpPower() + ( t_data.jumppower or 0 ) + (class.jumppower or 0) )

	ply:SetWalkSpeed( ply:GetWalkSpeed() + ( t_data.walkspeed or 0 ) + (class.walkspeed or 0)  )
	ply:SetRunSpeed( ply:GetRunSpeed() + ( t_data.runspeed or 0 ) + (class.runspeed or 0)  )

	for k, v in pairs( t_data.weapons or {} ) do
		ply:Give( v )
	end
	
	for k, v in pairs( class.weapons or {} ) do
		ply:Give( v )
	end

	if ply:HasFlag( "physgun" ) then
		ply:Give( "weapon_physgun" )
	end
	if ply:HasFlag( "physcannon" ) then
		ply:Give( "weapon_physcannon" )
	end
	if ply:HasFlag( "toolgun" ) then
		ply:Give( "gmod_tool" )
	end
	if ply:HasFlag( "flashlight" ) then
		ply:AllowFlashlight( true )
	end

	if !ply.ShouldNotRespawn and t_data.spawn_position then
		if istable( t_data.spawn_position ) then
			if t_data.spawn_position[ game.GetMap() ] then
				ply:SetPos( t_data.spawn_position[ game.GetMap() ] )
			end
		else
			ply:SetPos( t_data.spawn_position )
		end
	end

	-- ply:Notify( "You have joined the regiment: " .. t_data.name )

	hook.Run( "PostRegimentLoad", ply )
end

hook.AddOrder( "DataStorage:Initialized", 100, function( ply )
	RK.Regiment:RunPlayerSpawn( ply )
end )
