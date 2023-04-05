local MODULE = MODULE or RK.Modules:Get( "crafting" )

hook.Add( "PostNetInit", "Crafting:PostNetInit", function()
	RK.Net:ReceiveNetData( "RK.Crafting:Handler", function( ply, data )
		local command = data.command

		if command == "craft" then
			for k, v in pairs( MODULE:GetRecipes() ) do
				if k != data.recipe then continue end
				--print(data.recipe)
				if v.CanSee and !v.CanSee( ply, item_data ) then continue end
				if v.CanCraft and !v.CanCraft( ply ) then continue end

				local input_data = v.Recipe.input
				local output_data = v.Recipe.output
				--PrintTable(output_data)
				--PrintTable(input_data)
				for name, amount in pairs( input_data ) do
					--print("1")
					if ply:HasInventoryItem(name) then 
						if ply:HasInventoryItem(name) < amount then return end
					end
				end
				--print("2")
				--if not ply:HasInventoryItem(input_data.name) >= input_data.amount then return end
				for name, amount in pairs( input_data ) do
					ply:RemoveInventoryItem( name, amount )
				end

				for name, amount in pairs( output_data ) do
					local item_data = RK.Inventory:GetItem( name )
					if !item_data then continue end
					ply:AddInventoryItem( name, amount, v.OnCraft and v.OnCraft( ply, item_data ) or nil )

				end
			end
		end
	end )
end )

MODULE.MiningPositions = {
	{
		pos = Vector( -2964.881104, -1369.035645, 304.031250 ),
		ang = Angle( 0, 0, 0 )
	},
	{
		pos = Vector( -2864.881104, -1369.035645, 304.031250 ),
		ang = Angle( 0, 0, 0 )
	},
	{
		pos = Vector( -2764.881104, -1369.035645, 304.031250 ),
		ang = Angle( 0, 0, 0 )
	},
	{
		pos = Vector( -2664.881104, -1369.035645, 304.031250 ),
		ang = Angle( 0, 0, 0 )
	}
}

local function SpawnMiningRocks()
	local no_respawn = {}
	
	for _, v in pairs( ents.FindByClass( "rk_minable_rock" ) ) do
		no_respawn[ v.ID ] = true
	end
	
	for k, v in pairs( MODULE.MiningPositions ) do

		if no_respawn[ k ] then continue end

		local ent = ents.Create( "rk_minable_rock" )
		ent:SetPos( v.pos )
		ent:SetAngles( v.ang )
		ent:Spawn()
		ent:Activate()
		ent.ID = k
	end
end

timer.Create( "RK.SpawnMinableRocks", 600, 0, function() SpawnMiningRocks() end )