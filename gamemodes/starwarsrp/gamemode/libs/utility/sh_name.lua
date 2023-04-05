-- Overide Default Naming

local PLAYER = FindMetaTable( "Player" )

local function Overide( name, func )
	PLAYER[ "Old" .. name ] = PLAYER[ "Old" .. name ] or PLAYER[ name ]

	PLAYER[ name ] = func
end

Overide( "Nick", function( s ) return s:GetData():GetVar( "Name", s:OldNick() ) or s:OldNick() end )
Overide( "Name", function( s ) return s:GetData():GetVar( "Name", s:OldName() ) or s:OldName() end )
Overide( "GetName", function( s ) return s:GetData():GetVar( "Name", s:OldGetName() ) or s:OldGetName() end )

function PLAYER:SetRPName( var )
	--print( var )
	print(self:GetData():GetVar( "Name", self:OldNick() ) .. " changed name to: " .. var )
	return self:GetData():SetVar( "Name", var )
end

if CLIENT then
	hook.Add( "OnPlayerChat", "NoChat", function( ply, text )		

		return true
	end )
	
	hook.Add( "PostNetInit", "PlayerData:PostNetInit", function()
		RK.Net:ReceiveNetData( "SendChatMessage", function( ply, data )
			
			chat.AddText( unpack( data ) )
	
		end )
	end )
end