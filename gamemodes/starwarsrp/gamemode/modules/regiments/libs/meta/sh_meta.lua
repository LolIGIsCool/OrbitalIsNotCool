local MODULE = MODULE or RK.Modules:Get( "regiments" )
local meta = FindMetaTable( "Player" )

// Regiment meta
function meta:GetRegiment() -- Returns players regiment in number form
	return self:GetData():GetVar( "Regiment", 1 )
end

function meta:GetRegimentData() -- returns all data via input of number
	--PrintTable(RK.Regiment:GetByMember( "team_num",  self:GetRegiment() ))
	return RK.Regiment:GetByMember( "team_num",  self:GetRegiment() )
end

function meta:GetRegimentName() -- returns players regiment name e.g "212th Trooper"
	return self:GetRegimentData().name or "Recruit" 
end

// Regiment Rank meta
function meta:GetRegimentRank() -- returns player rank in number form
	--PrintTable(self:GetData():GetVar( "RegimentRank", 1 ))
	return self:GetData():GetVar( "RegimentRank", 1 )
end

function meta:GetRegimentRanks() -- returns player rank in number form
	--PrintTable(self:GetData():GetVar( "RegimentRank", 1 ))
	return self:GetRegimentData().ranks or {}
end

function meta:GetRegimentRankData() -- returns ranks of the players regiment
	return RK.Regiment:GetByMember( "team_num",  self:GetRegiment() ).ranks[ self:GetRegimentRank() ]
end

function meta:GetRegimentRankName() -- returns name of players rank
	return self:GetRegimentRankData()[ "name" ]
end

function meta:GetRegimentRankCl() -- returns players clearence level
	return self:GetRegimentRankData()[ "cl" ] or 1
end

function meta:GetBranch() -- returns players branch, only used for IHC purposes because no one trusts karssus
	return self:GetRegimentRankData()[ "branch" ] or nil
end

function meta:GetRegimentClasses() -- returns all classes within the players regiment
	return self:GetRegimentData().classes or {}
end

function meta:GetPlayerClass() -- returns the players class or false if no class
	return self:GetData():GetVar( "Class", false )
end

function meta:HasAuthority()

	local regiment = self:GetRegimentData()
	
	local power = ( #regiment.ranks - 1 ) <= self:GetRegimentRank()
	if regiment.ranks[self:GetRegimentRank()] then
		return self:GetRegimentRankCl() >= 3
	end
	return power

end

function meta:IsCommander()

	local regiment = self:GetRegimentData()
	local power = ( #regiment.ranks ) <= self:GetRegimentRank()
	
	return power

end

if SERVER then
	// Set the regiment for the player.
	function meta:SetRegiment( regiment, rank )
		self:GetData():SetVar( "Regiment", regiment )
		self:GetData():SetVar( "RegimentRank", rank and rank or 1 )
		self:GetData():ClearVar("Class")

		self.ShouldNotRespawn = true
		RK.Teams:RunPlayerSpawn( self )
		RK.Regiment:RunPlayerSpawn( self ) -- Run the player order spawn hook
		self.ShouldNotRespawn = false

		self:Notify( "You have joined the regiment: " .. self:GetRegimentData().name )
	end

	// Set the regiment rank for the player.
	function meta:SetRegimentRank( rank )
		self:GetData():SetVar( "RegimentRank", rank )

		self.ShouldNotRespawn = true
		RK.Teams:RunPlayerSpawn( self )
		RK.Regiment:RunPlayerSpawn( self ) -- Run the player order spawn hook
		self.ShouldNotRespawn = false

		self:Notify( "Your regiment rank has been changed to: " .. self:GetRegimentRankName() )
	end
	
	function meta:SetClass( class )
		self:GetData():SetVar( "Class", class ) -- only time it ever needs to be set, ClearVar("Class") to remove

		self.ShouldNotRespawn = true
		RK.Teams:RunPlayerSpawn( self )
		RK.Regiment:RunPlayerSpawn( self ) -- Run the player order spawn hook
		self.ShouldNotRespawn = false

		self:Notify( "Your class has been changed to: " .. tostring(self:GetPlayerClass()) )
	end
	
	function meta:ResetClass( class ) -- Resets class to nothing bc pog
		self:GetData():ClearVar("Class")

		self.ShouldNotRespawn = true -- same shit as above
		RK.Teams:RunPlayerSpawn( self )
		RK.Regiment:RunPlayerSpawn( self ) -- Run the player order spawn hook
		self.ShouldNotRespawn = false

		self:Notify( "Your class has been reset!" )
	end
	
end

if CLIENT then

	hook.Add( "PostNetInit", "NetRequests:PostNetInit", function()
		RK.Net:ReceiveNetData( "RK.Regiment:ReceiveInvite", function( ply, data )
			ply.invite = data.id

			ply:Notify( "You have been invited to join the regiment: " .. RK.Regiment:GetByID( data.id ).name )
			ply:Notify( "Type /accept to join the regiment." )

			ply:ChatPrint( "You have been invited to join the regiment: " .. RK.Regiment:GetByID( data.id ).name .. "\nType /accept to join the regiment." )

		end )
	end )

end