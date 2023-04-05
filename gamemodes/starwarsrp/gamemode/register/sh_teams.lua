RK = RK or {}

// Create new MetaTable via register module
RK.Teams = RK.Register:New( {} )
// On register function, Called after a new entry
function RK.Teams:OnRegister( data )
	
	team.SetUp(data.team_num, data.name, data.colour)
	
	local enum = string.gsub( data.name:upper(), " ", "_" )

	_G[ "TEAM_" .. enum ] = data.team_num

	return data
end

// On Player Spawn function, Called after a new player, Sets all their stats of their team

function RK.Teams:RunPlayerSpawn( ply )
	local t = ply:GetData():GetVar( "Team", 1 )
	if !t then t = 1 end
	local t_data = RK.Teams:GetByMember( "team_num", t )

	ply:SetTeam( t )

	ply:SetBodyGroups( t_data.bodygroups or "" )
	ply:SetModelScale( t_data.modelscale or 1 )

	ply:SetMaxHealth( ( t_data.health or 100 ) )
	ply:SetHealth( ( t_data.health or 100 ) )

	ply:SetMaxArmor( ( t_data.armour or 0 ) )
	ply:SetArmor( ( t_data.armour or 0 ) )

	ply:SetJumpPower( ( t_data.jumppower or 0 ) )

	ply:SetWalkSpeed( ( t_data.walkspeed or 0 ) )
	ply:SetRunSpeed( ( t_data.runspeed or 0 ) )

	for k, v in pairs( t_data.weapons or {} ) do
		
		ply:Give( v )

	end

	-- ply:Notify( "You have joined the team: " .. t_data.name )
end

hook.AddOrder( "DataStorage:Initialized", 99, function( ply )
	RK.Teams:RunPlayerSpawn( ply )
end )

RK.Teams:Add( "Empire", {
	team_num = 1, -- Unique

	description = "Basic recruit.\nYou do what you are told, When you are told.",
	colour = Color( 255, 0, 0 ),

	health = 100, -- Init health
	armour = 0, -- Init armour
	runspeed = 240, -- Init runspeed
	walkspeed = 160, -- Init walkspeed

	weapons = {}
} )

RK.Teams:Add( "Republic", {
	team_num = 2, -- Unique

	description = "Basic recruit.\nYou do what you are told, When you are told.",
	colour = Color( 0, 100, 255 ),

	health = 100, -- Init health
	armour = 0, -- Init armour
	runspeed = 240, -- Init runspeed
	walkspeed = 160, -- Init walkspeed

	weapons = {}
} )


RK.Teams:Add( "Connecting", {
	team_num = 1001, -- Unique

	description = "This is the final team, You shouldnt be in this.",
	colour = Color( 0, 100, 255 ),
	
	health = 100, -- Init health
	armour = 0, -- Init armour
	runspeed = 240, -- Init runspeed
	walkspeed = 160, -- Init walkspeed

	weapons = {}
} )