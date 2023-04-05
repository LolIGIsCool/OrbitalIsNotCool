RK = RK or {}
RK.Timing = RK.Timing or {}

local META = FindMetaTable( "Player" )

function RK.Timing:GetTimeString( time )
	local hours = math.floor( time / 3600 )
	local minutes = math.floor( time / 60 ) - ( hours * 60 )
	local seconds = time - ( hours * 3600 ) - ( minutes * 60 )
	
	return string.format( "%02i:%02i:%02i", hours, minutes, seconds )
end

function RK.Timing:GetTimeDate( time )

	local date = os.date( "*t", os.time() + time )
	
	return string.format( "%02i/%02i/%04i", date.day, date.month, date.year )
end

function RK.Timing:CheckTime( ply )

	local data = ply:GetData():GetVar( "Timing_Library", {} )

	for k, v in pairs( data ) do
		if v and os.time() >= v then
			ply:RemoveTimedFlag( k )
		end
	end

	ply:GetData():SetVar( "Timing_Library", data )

	return data
end
	
function META:AddTimedFlag( flag, time )
	local data = RK.Timing:CheckTime( self )
	if data[ flag ] then
		data[ flag ] = data[ flag ] + time
	else
		data[ flag ] = os.time() + time
	end
	self:GetData():SetVar( "Timing_Library", data )

	hook.Run( "PlayerTimerAdded", self, flag, time )
end

function META:RemoveTimedFlag( flag )
	local data = RK.Timing:CheckTime( self )
	if data[ flag ] then
		data[ flag ] = nil
	end
	self:GetData():SetVar( "Timing_Library", data )

	hook.Run( "PlayerTimerRemoved", self, flag, os.time() )
end

hook.Add( "PlayerHasFlag", "Timing:PlayerHasFlag", function( ply, flag )
	local data = RK.Timing:CheckTime( ply )
	if data[ flag ] then
		return true
	end
end )

local add = not GAMEMODE and hook.Add or function(_, _, fn)
	fn()
end
	
add("PostGamemodeLoaded", "SAM.Timings", function()

	local sam, command, language = sam, sam.command, sam.language

	command.set_category("Flags")

	command.new("addflag")
		:SetPermission("addflag", "superadmin")

		:AddArg("player")
		:AddArg("number", {hint = "time", optional = true, min = 0, default = 0, round = true})
		:AddArg("text", { hint = "flag" } )

		:Help("probs dont use for the moment")

		:OnExecute(function(ply, targets, time)
			if time == 0 then
				time = math.huge
			end

			for i = 1, #targets do
				local v = targets[i]
				if v and IsValid( v ) then
					v:AddTimedFlag( flag, time )
				end
			end
		end)
	:End()
end)