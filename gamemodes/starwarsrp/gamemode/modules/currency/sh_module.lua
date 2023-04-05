// Init Module
local MODULE = MODULE or RK.Modules:Get( "currency" )

// Module name
MODULE.name = "Currency"
// Module author
MODULE.author = "Kirby#2015"
// Module description
MODULE.description = [[
	A module that allows players to obtain currency.
]]

local META = FindMetaTable( "Player" )

function META:GetMoney()
	return self:GetData():GetVar( "money", 0 )
end
META.getMoney = META.GetMoney

function META:SetMoney( amount )
	self:GetData():SetVar( "money", amount )
end
META.setMoney = META.SetMoney

function META:AddMoney( amount )
	self:SetMoney( self:GetMoney() + amount )
end
META.addMoney = META.AddMoney

function META:RemoveMoney( amount )
	self:SetMoney( self:GetMoney() - amount )
end
META.removeMoney = META.RemoveMoney

function META:CanAfford( amount )
	return self:GetMoney() >= amount
end
META.canAfford = META.CanAfford

function META:GetSalary()
	local sal = RK.Config:Get( "Salary Default", 100 )
	local cl = self:GetRegimentRankCl()
	local lvl = self:GetLevel()
	sal = sal + (cl * lvl)

	return sal
end

if SERVER then
	hook.Add("PlayerInitialSpawn", "RK:Salary:PlayerConnected", function(ply)
	
		if timer.Exists( "RK.Salary"..ply:SteamID64() ) then
			timer.Remove( "RK.Salary"..ply:SteamID64() )
		end

		timer.Create( "RK:Salary"..ply:SteamID64(), 900, 0, function()
			if IsValid( ply ) then
				ply:AddMoney( ply:GetSalary() )
				ply:Notify( "You have been given $"..ply:GetSalary().." as your salary." )
			end
		end )
	
	end)

	hook.Add( "PlayerDisconnected", "RK:Salary:PlayerDisconnected", function( ply )
		if timer.Exists( "RK.Salary"..ply:SteamID64() ) then
			timer.Remove( "RK.Salary"..ply:SteamID64() )
		end
	end )
end

