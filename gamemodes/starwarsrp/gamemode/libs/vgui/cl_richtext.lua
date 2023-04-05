local vgui_Register, draw_RoundedBox = vgui.Register, draw.RoundedBox

local PANEL = {}

function PANEL:Init()

end

function PANEL:AddText( col, txt )

	self:InsertColorChange( col.r, col.g, col.b, col.a )
	self:AppendText( txt )

end

function PANEL:Paint( w, h )
	if self.m_bShouldDrawBlur then self:DrawBlur( 8 ) end

	self:PostPaint( w, h )
end

function PANEL:PostPaint( w, h )

end

function PANEL:PerformLayout( w, h )

	self:SetFontInternal( RKFont( 24, "Bahnschrift SemiLight Condensed" ) )
end

vgui_Register( "RKCore:RichText", PANEL, "RichText" )