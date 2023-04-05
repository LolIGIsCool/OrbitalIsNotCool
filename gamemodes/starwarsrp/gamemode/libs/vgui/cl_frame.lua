local PANEL = {}

function PANEL:Init()
	self[ "Panels" ] = {}

	self:MakePopup()
	self:ShowCloseButton( false )
	self:SetTitle( "" )

	local close = self:Insert( "CloseButton", "DButton", 0, 0, 32, 32 )
	close:SetFont( RKFont( 32 ) )
	close:SetText( "X" )
	close:SetTextColor( Color( 255, 255, 255 ) )
	close.Paint = function( s, w, h )
		draw.RoundedBox( 0, 0, 0, 32, 32, self:IsHovered() and Color( 255, 75, 75, 255 ) or Color( 255, 50, 50, 255 ) )
	end
	close.DoClick = function( s )
		self:Remove()
	end

	self.close = close
end

function PANEL:Paint( w, h )
	draw.RoundedBox( 0, 0, 0, w, h, Color( 19, 8, 43, 200 ) )
	
	self:PostPaint( w, h )
end
function PANEL:PostPaint( w, h ) end

function PANEL:Insert( name, panel, x, y, w, h )

	self[ "Panels" ][ name ] = self:Add( panel )
	if x == "Dock" then
		self:Dock( y )
	else
		self[ "Panels" ][ name ]:SetPos( x, y )
	end
	self[ "Panels" ][ name ]:SetSize( w, h )

	self:InvalidateLayout()

	return self[ "Panels" ][ name ]
end

function PANEL:GetPanel( name )
	if !name then return self[ "Panels" ] end

	return self[ "Panels" ][ name ]
end

function PANEL:PerformLayout( w, h )

	local close = self:GetPanel( "CloseButton" )
	close:SetPos( w - close:GetWide(), 0 )

	self:PostPerformLayout( w, h )

end

function PANEL:PostPerformLayout( w, h ) end
vgui.Register( "RKCore:Frame", PANEL, "DFrame" )

--[[
PANEL = {}

function PANEL:Init()

end

function PANEL:Paint( w, h )

end

function PANEL:PerformLayout( w, h )

end
]]--