local MODULE = MODULE or RK.Modules:Get( "net_requests" )

local commands = {
	[ "Set Regiment" ] = function( ply, data )
		local target = data.target
		local regiment = data.id
		local rank = data.rank

		if !IsValid( target ) then return false end
		if !target:IsPlayer() then return false end
		if !ply:IsAdmin() and target:GetRegiment() != ply:GetRegiment() then return false end

		hook.Run( "PlayerChangedRegiment", ply, data.target, data.target:GetRegiment(), rank )
		target:SetRegiment( regiment )

		target:SetRegimentRank( rank and rank or 1 )

		target:KillSilent()
		target:Spawn()
	end,
	[ "Set Rank" ] = function( ply, data )
		local target = data.target
		local rank = data.id

		if !IsValid( target ) then return false end
		if !target:IsPlayer() then return false end

		if !ply:IsAdmin() and target:GetRegiment() != ply:GetRegiment() then return false end

		hook.Run( "PlayerChangedRegiment", ply, data.target, data.target:GetRegimentRank(), rank )
		target:SetRegimentRank( rank )
	end,

	[ "Set Money" ] = function( ply, data )
		if !ply:IsAdmin() then return false end

		local target = data.target
		local money = data.id

		if !IsValid( target ) then return false end
		if !target:IsPlayer() then return false end

		target:SetMoney( money )
	end,
}

local reg_commands = {
	[ "Invite Player" ] = function( ply, data )

		if !IsValid( data.target ) then return end

		if !ply:IsAdmin() then
			if ply == data.target then return false end
			if ply:GetRegiment() == data.target:GetRegiment() then
				return false
			end

			if !ply:HasAuthority() then
				return false
			end
		end

		if ply:HasFlag( "invitebypass" ) then
			data.target:SetRegiment( data.id, 1 )
		return true end

		data.target.invite = data.id

		RK.Net:SendNetData( "RK.Regiment:ReceiveInvite", {
			id = data.id,
		}, data.target )

	end,

	[ "Kick Player" ] = function( ply, data )
		if !IsValid( data.target ) then return end

		if !ply:IsAdmin() then
			if ply == data.target then return false end
			if ply:GetRegiment() != data.target:GetRegiment() then
				return false
			end

			if !ply:HasAuthority() then
				return false
			end

			if data.target:HasAuthority() and !ply:IsCommander() then
				return false
			end
		end
		hook.Run( "PlayerChangedRegiment", ply, data.target, data.target:GetRegimentRank(), 1 )
		data.target:SetRegiment( 1, 1 )
	end,

	[ "Promote Player" ] = function( ply, data )
		if !IsValid( data.target ) then return end

		PrintTable( data )

		if ply:IsAdmin() then
			hook.Run( "PlayerChangedRegimentRank", ply, data.target, data.target:GetRegimentRank(), data.rank )
			data.target:SetRegimentRank( math.Clamp( data.rank, 1, #data.target:GetRegimentData()[ "ranks" ] ) )
		return true end

		if ply == data.target then return false end
		if ply:GetRegiment() != data.target:GetRegiment() then
			return false
		end

		if !ply:HasAuthority() then
			return false
		end

		if data.target:IsCommander() then
			return false
		end

		if data.target:HasAuthority() and !ply:IsCommander() then
			return false
		end

		hook.Run( "PlayerChangedRegimentRank", ply, data.target, data.target:GetRegimentRank(), data.rank )
		data.target:SetRegimentRank( math.Clamp( data.rank, 1, #data.target:GetRegimentData()[ "ranks" ] ) )
	end,
	
	[ "Change Class" ] = function( ply, data )
		if !IsValid( data.target ) then return end

		--PrintTable( data )
		local tar = data.target
		--if ply:IsAdmin() then
		--	hook.Run( "PlayerChangedRegimentRank", ply, data.target, data.target:GetRegimentRank(), data.rank )
		--	data.target:SetRegimentRank( math.Clamp( data.rank, 1, #data.target:GetRegimentData()[ "ranks" ] ) )
		--return true end
		if ply:IsAdmin() then
			tar:SetClass(data.class)
			return true
		end

		if ply == tar then return false end
		if ply:GetRegiment() != tar:GetRegiment() then
			return false
		end

		if !ply:HasAuthority() then
			return false
		end

		if tar:IsCommander() then
			return false
		end

		if tar:HasAuthority() and !ply:IsCommander() then
			return false
		end
		
		tar:SetClass(data.class)
		--hook.Run( "PlayerChangedRegimentRank", ply, data.target, data.target:GetRegimentRank(), data.rank )
		--data.target:SetRegimentRank( math.Clamp( data.rank, 1, #data.target:GetRegimentData()[ "ranks" ] ) )
	end,
	
	
	[ "Reset Class" ] = function( ply, data )
		if !IsValid( data.target ) then return end

		--PrintTable( data )
		local tar = data.target
		--if ply:IsAdmin() then
		--	hook.Run( "PlayerChangedRegimentRank", ply, data.target, data.target:GetRegimentRank(), data.rank )
		--	data.target:SetRegimentRank( math.Clamp( data.rank, 1, #data.target:GetRegimentData()[ "ranks" ] ) )
		--return true end
		if ply:IsAdmin() then
			tar:ResetClass()
			return true
		end

		if ply == tar then return false end
		if ply:GetRegiment() != tar:GetRegiment() then
			return false
		end

		if !ply:HasAuthority() then
			return false
		end

		if tar:IsCommander() then
			return false
		end

		if tar:HasAuthority() and !ply:IsCommander() then
			return false
		end
		
		tar:ResetClass()
		--hook.Run( "PlayerChangedRegimentRank", ply, data.target, data.target:GetRegimentRank(), data.rank )
		--data.target:SetRegimentRank( math.Clamp( data.rank, 1, #data.target:GetRegimentData()[ "ranks" ] ) )
	end,
	

	-- [ "Demote Player" ] = function( ply, data )
	-- 	if !IsValid( data.target ) then return end

	-- 	if !ply:IsAdmin() then
	-- 		if ply == data.target then return false end
	-- 		if ply:GetRegiment() != data.target:GetRegiment() then
	-- 			return false
	-- 		end

	-- 		if !ply:HasAuthority() then
	-- 			return false
	-- 		end

	-- 		if data.target:IsCommander() then
	-- 			return false
	-- 		end

	-- 		if data.target:HasAuthority() and !ply:IsCommander() then
	-- 			return false
	-- 		end
	-- 	end

	-- 	data.target:SetRegimentRank( math.Clamp( data.target:GetRegimentRank() - 1, 1, #data.target:GetRegimentData()[ "ranks" ] ) )
	-- end,
}

hook.Add( "PostNetInit", "NetRequests:PostNetInit", function()
	RK.Net:ReceiveNetData( "RK.Admin:RequestDataChange", function( ply, data )
		if !ply:IsAdmin() then return end
		if !data.command then return end
		if !commands[ data.command ] then return end

		commands[ data.command ]( ply, data[ "data" ] )
	end )

	RK.Net:ReceiveNetData( "RK.Regiments:RequestDataChange", function( ply, data )
		if !data.command then return end
		if !reg_commands[ data.command ] then return end
		if !ply:IsAdmin() and data.data.target and data.data.target == ply then return end

		reg_commands[ data.command ]( ply, data[ "data" ] )

	end )
end )