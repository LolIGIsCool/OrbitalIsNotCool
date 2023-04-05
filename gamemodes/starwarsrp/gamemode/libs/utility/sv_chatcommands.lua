RK = RK or {}
RK.OldFunctions = RK.OldFunctions or {}

RK.Commands = RK.Commands or {}

function RK:CreateChatCommand( cmd, condition, recipients, data, allowempty )
	if isstring( condition ) then
		RK.Commands[ cmd ] = RK.Commands[ condition ]
	return end
	RK.Commands[ cmd ] = { condition = condition, recipients = recipients, data = data, allowempty = allowempty }
end

hook.Add( "PlayerSay", "ZZZZZzzzSWRPChatCommands", function( ply, text, teamChat, bool )

	if text == "" then return "" end
	if text == "/" then return "" end
	if text == "!" then return "" end

	if !bool then

		local text = hook.Run( "PlayerSay", ply, text, teamChat, true ) or text

		if teamChat then
			local team = RK.Commands[ 1 ]

			for k, v in pairs( team.recipients( ply ) ) do
				v:SendNetMessage( "SendChatMessage", team.data( ply, text ) )
			end

			local msg = string.format( "[team] %s: %s", ply:Nick(), text )

			-- ulx.logString( msg )
			print( msg )

		return "" end

		text = string.Explode( " ", text )

		if !text[ 1 ] then return "" end

		local command = RK.Commands[ text[ 1 ]:lower() ]
		if command then

			local txt = table.concat( text, " ", 2 )
			if !command.allowempty then
				if !txt then return "" end
				if txt == "" then return  "" end
			end

			local recipients = command.recipients( ply, txt )
			local condition = command.condition( ply, txt )

			if #recipients == 0 then return "" end

			for k, v in pairs( recipients ) do
				v:SendNetMessage( "SendChatMessage", command.data( ply, txt ) )
			end

			local msg = string.format( "%s: %s", ply:Nick(), table.concat( text, " " ) )

			-- ulx.logString( msg )
			print( msg )

			return ""

		else
			local txt = table.concat( text, " " )
			if !txt then return "" end
			if txt == "" then return "" end

			for k, v in pairs( RK.Commands[ 2 ].recipients( ply ) ) do
				v:SendNetMessage( "SendChatMessage", RK.Commands[ 2 ].data( ply, txt ) )
			end

			local msg = string.format( "%s: %s", ply:Nick(), txt )

			-- ulx.logString( msg )
			print( msg )

			return ""

		end
	end
end )

RK:CreateChatCommand( 1,
	function( ply )
		return true
	end,

	function( ply )
		local recipients = {}

		for _, ent in ipairs( player.GetAll() ) do
			if ply:GetData():GetVar( "Regiment", 1 ) == ent:GetData():GetVar( "Regiment", 1 ) then
				table.insert( recipients, ent )
			end
		end

		return recipients
	end,

	function( ply, text )

		local prefix = "[Regiment-Comms] "
		local prefix_colour = Color( 200, 0, 0 )

		local reg_data = ply:GetRegimentData()
		local name = string.format( "%s %s %s: ", reg_data.prefix and reg_data.prefix or reg_data.name, ply:GetRegimentRankName(), ply:Nick() )
		local name_colour = reg_data.colour and reg_data.colour or Color( 255, 255, 255 )

		local msg = text
		local msg_colour = Color( 255, 255, 255 )

		return {
			prefix_colour,
			prefix,
			name_colour,
			name,
			msg_colour,
			msg,
		}
	end
)

RK:CreateChatCommand( 2,
	function( ply )
		return true
	end,

	function( ply )
		local recipients = {}

		for _, ent in ipairs( player.GetAll() ) do
			if ent:GetPos():DistToSqr( ply:GetPos() ) < 100000 then
				table.insert( recipients, ent )
			end
		end

		return recipients
	end,

	function( ply, text )
		local prefix = "[Local] "
		local prefix_colour = Color( 152, 152, 152)

		local reg_data = ply:GetRegimentData()
		local name = string.format( "%s %s %s: ", reg_data.prefix and reg_data.prefix or reg_data.name, ply:GetRegimentRankName(), ply:Nick() )
		local name_colour = reg_data.colour and reg_data.colour or Color( 255, 255, 255 )

		local msg = text
		local msg_colour = Color( 255, 255, 255 )

		return {
			prefix_colour,
			prefix,
			name_colour,
			name,
			msg_colour,
			msg,
		}
	end
)

RK:CreateChatCommand( "/yell",
	function( ply )
		return true
	end,

	function( ply )
		local recipients = {}

		for _, ent in ipairs( player.GetAll() ) do
			if ent:GetPos():DistToSqr( ply:GetPos() ) < 300000 then
				table.insert( recipients, ent )
			end
		end

		return recipients
	end,

	function( ply, text )
		local prefix = "[Yell] "
		local prefix_colour = Color( 183, 183, 183)

		local reg_data = ply:GetRegimentData()
		local name = string.format( "%s %s %s: ", reg_data.prefix and reg_data.prefix or reg_data.name, ply:GetRegimentRankName(), ply:Nick() )
		local name_colour = reg_data.colour and reg_data.colour or Color( 255, 255, 255 )

		local msg = text
		local msg_colour = Color( 255, 255, 255 )

		return {
			prefix_colour,
			prefix,
			name_colour,
			name,
			msg_colour,
			msg,
		}
	end
)

RK:CreateChatCommand( "/y", "/yell" )

RK:CreateChatCommand( "/w",
	function( ply )
		return true
	end,

	function( ply )
		local recipients = {}

		for _, ent in ipairs( player.GetAll() ) do
			if ent:GetPos():DistToSqr( ply:GetPos() ) < 10000 then
				table.insert( recipients, ent )
			end
		end

		return recipients
	end,

	function( ply, text )
		local prefix = "[Whisper] "
		local prefix_colour = Color( 81, 113, 119)

		local reg_data = ply:GetRegimentData()
		local name = string.format( "%s %s %s: ", reg_data.prefix and reg_data.prefix or reg_data.name, ply:GetRegimentRankName(), ply:Nick() )
		local name_colour = reg_data.colour and reg_data.colour or Color( 255, 255, 255 )

		local msg = text
		local msg_colour = Color( 255, 255, 255 )

		return {
			prefix_colour,
			prefix,
			name_colour,
			name,
			msg_colour,
			msg,
		}
	end
)


RK:CreateChatCommand( "/name",
	function( ply, text )
		return true
	end,

	function( ply, text )
		ply:SetRPName( text )
		return {}
	end,

	function()
	end
)

RK:CreateChatCommand( "/setname", "/name" )
RK:CreateChatCommand( "/rpname", "/name" )

RK:CreateChatCommand( "/comms",
	function( ply )
		return true
	end,

	function( ply )
		return player.GetAll()
	end,

	function( ply, text )
		local prefix = "[Imperial-Comms] "
		local prefix_colour = Color( 255, 0, 0 )

		local reg_data = ply:GetRegimentData()
		local name = string.format( "%s %s %s: ", reg_data.prefix and reg_data.prefix or reg_data.name, ply:GetRegimentRankName(), ply:Nick() )
		local name_colour = reg_data.colour and reg_data.colour or Color( 255, 255, 255 )

		local msg = text
		local msg_colour = Color( 255, 255, 255 )

		return {
			prefix_colour,
			prefix,
			name_colour,
			name,
			msg_colour,
			msg,
		}
	end
)

RK:CreateChatCommand( "/ecomms",
	function( ply )
		return true
	end,

	function( ply )
		return player.GetAll()
	end,

	function( ply, text )
		local prefix = "[Emergency-Comms] "
		local prefix_colour = Color( 204, 255, 0)

		local reg_data = ply:GetRegimentData()
		local name = string.format( "%s %s %s: ", reg_data.prefix and reg_data.prefix or reg_data.name, ply:GetRegimentRankName(), ply:Nick() )
		local name_colour = reg_data.colour and reg_data.colour or Color( 255, 255, 255 )

		local msg = text
		local msg_colour = Color( 255, 255, 255 )

		return {
			prefix_colour,
			prefix,
			name_colour,
			name,
			msg_colour,
			msg,
		}
	end
)

RK:CreateChatCommand( "/ooc",
	function( ply )
		return true
	end,

	function( ply )
		return player.GetAll()
	end,

	function( ply, text )
		local prefix = "[OOC] "
		local prefix_colour = Color( 255, 255, 255)

		local name = ply:OldNick() .. ": "
		local name_colour = RK.Regiment:GetByMember( "team_num", ply:GetData():GetVar( "Regiment", 1 ) ).colour

		local msg = text
		local msg_colour = Color( 255, 255, 255 )

		return {
			prefix_colour,
			prefix,
			name_colour,
			name,
			msg_colour,
			msg,
		}
	end
)

RK:CreateChatCommand( "//", "/ooc" )

RK:CreateChatCommand( "/me",
	function( ply )
		return true
	end,

	function( ply )
		local recipients = {}

		for _, ent in ipairs( player.GetAll() ) do
			if ent:GetPos():DistToSqr( ply:GetPos() ) < 100000 then
				table.insert( recipients, ent )
			end
		end

		return recipients
	end,

	function( ply, text )
		return {
		Color( 149, 149, 147),
		RK.Regiment:GetByMember( "team_num", ply:GetData():GetVar( "Regiment", 1 ) ).name .. ( RK.Regiment:GetByMember( "team_num", ply:GetData():GetVar( "Regiment", 1 ) ).name == "" and "" or " " ) .. ply:Nick(),
		" ",
		text
		}
	end
)

RK:CreateChatCommand( "/looc",
	function( ply )
		return true
	end,

	function( ply )
		local recipients = {}

		for _, ent in ipairs( player.GetAll() ) do
			if ent:GetPos():DistToSqr( ply:GetPos() ) < 100000 then
				table.insert( recipients, ent )
			end
		end

		return recipients
	end,

	function( ply, text )
		local prefix = "[LOOC] "
		local prefix_colour = Color( 170, 240, 255)

		local name = ply:OldNick() .. ": "
		local name_colour = RK.Regiment:GetByMember( "team_num", ply:GetData():GetVar( "Regiment", 1 ) ).colour

		local msg = text
		local msg_colour = Color( 255, 255, 255 )

		return {
			prefix_colour,
			prefix,
			name_colour,
			name,
			msg_colour,
			msg,
		}
	end
)

RK:CreateChatCommand( "/accept",
	function( ply )
		return ply.invite
	end,

	function( ply, text )
		if ply.invite == nil then print("asd") return {} end
		ply:SetRegiment( ply.invite, 1 )
		ply:SetRegimentRank( 1 )
		ply.invite = nil
		return {}
	end,

	function( ply, text )
	end, true
)

RK:CreateChatCommand( "/roll",
	function( ply )
		return true
	end,

	function( ply )
		local recipients = {}

		for _, ent in ipairs( player.GetAll() ) do
			if ent:GetPos():DistToSqr( ply:GetPos() ) < 100000 then
				table.insert( recipients, ent )
			end
		end

		return recipients
	end,

	function( ply, text )
		return {
		Color( 0,255,255 ),
		RK.Regiment:GetByMember( "team_num", ply:GetData():GetVar( "Regiment", 1 ) ).name .. ( RK.Regiment:GetByMember( "team_num", ply:GetData():GetVar( "Regiment", 1 ) ).name == "" and "" or " *** " ) .. ply:Nick(),
                " has rolled a "..math.random(1,100).."."
		}
	end, true
)

local meta = FindMetaTable( "Player" )

RK.OldFunctions[ "ChatPrint" ] = RK.OldFunctions[ "ChatPrint" ] or meta.ChatPrint
RK.OldFunctions[ "PrintMessage" ] = RK.OldFunctions[ "PrintMessage" ] or meta.ChatPrint

function meta:ChatPrint( ... )
	local args = { ... }
	local msg = ""
	
	for _, arg in ipairs( args ) do
		msg = msg .. tostring( arg )
	end

	self:SendNetMessage( "SendChatMessage", msg )
end

function meta:PrintMessage( type, message )
	if type == HUD_PRINTTALK then self:SendNetMessage( "SendChatMessage", message ) return end
	RK.OldFunctions[ "PrintMessage" ]( self, type, message )
end