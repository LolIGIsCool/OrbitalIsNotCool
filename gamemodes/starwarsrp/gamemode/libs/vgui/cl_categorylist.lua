local draw, vgui = draw, vgui
local draw_RoundedBox, vgui_Create, vgui_Register = draw.RoundedBox, vgui.Create, vgui.Register

local PANEL = {}

function PANEL:Init()
	self.m_tCategorys = {}
	self:RepaintScrollBar()
end

function PANEL:Paint( w, h )
	--draw_RoundedBox( 0, 0, 0, w, h, Color( 255, 255, 255, 255 ) )
end

function PANEL:PostPaint( w, h )
end

function PANEL:GetCategory( name )
	return self.m_tCategorys[ name ] and self.m_tCategorys[ name ] or false
end

function PANEL:AddCategory( name )

	self.m_tCategorys[ name ] = self:Add( "DCollapsibleCategory" )

	local panel = self.m_tCategorys[ name ]

	panel:Dock( TOP )
	panel:DockMargin( 0, 0, 0, 5 )

	panel.Header:SetTall( 35 )
	panel.Header:SetFont( RK.Config:Get( "Sub Title Font", RKFont( 22 ) ) )
	panel.Header:SetTextColor( Color( 225, 225, 225 ) )
	panel.Header:SetText( name )
	panel.Header.Paint = function( s, w, h )
		draw.RoundedBox( 4, 0, 0, w, h, Color( 0, 155, 200 ) )
	end

	panel.List = vgui_Create( "RKCore:ScrollPanel" )
	panel.List:RepaintScrollBar()

	panel:SetContents( panel.List )

	return panel

end

function PANEL:AddCategoryItem( name, pnl )
	if not name or not self.m_tCategorys[ name ] then return end

	local panel = self.m_tCategorys[ name ]
	panel.List:AddItem( pnl )

	pnl:Dock( TOP )
	pnl:DockMargin( 0, 5, 0, 0 )
end

vgui_Register( "RKCore:CategoryList", PANEL, "RKCore:ScrollPanel")