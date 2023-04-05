local LerpValue = function( v1, v2 )
	return Lerp( FrameTime() * 5, v1, v2 )
end

local PANEL = {}

function PANEL:Init()
	self:OldSetText("")
	self:SetFont( RKFont( 24 ) )
	self:SetSelectable( true )
end

PANEL.OldSetText = vgui.GetControlTable("DLabel").SetText

function PANEL:SetText( str )
	self.m_strText = str
end

function PANEL:GetText()
	return self.m_strText
end

function PANEL:SetFont( str )
	self.m_strFont = str
end

function PANEL:GetFont()
	return self.m_strFont
end

function PANEL:PaintHover()
	local w, h = self:GetSize()
	self.m_col = self.m_col or Color( 0, 0, 0, 0 )
	if self:IsHovered() and !self:IsSelected() then
		self.m_colBackground = Color( 0, 0, 0, 100 )
	elseif self:IsSelected() and !self:IsHovered() then
		self.m_colBackground = Color( 0, 0, 0, 200 )
	elseif !self:IsSelected() and !self:IsHovered() then
		self.m_colBackground = Color( 0, 0, 0, 0 )
	end

	local r = LerpValue( self.m_col.r, self.m_colBackground.r )
	local g = LerpValue( self.m_col.g, self.m_colBackground.g )
	local b = LerpValue( self.m_col.b, self.m_colBackground.b )
	local a = LerpValue( self.m_col.a, self.m_colBackground.a )

	self.m_col = Color( r, g, b, a )
end

function PANEL:PaintHoverText()
	self.m_colT = self.m_colT or Color( 175, 175, 175, 255 )
	if self:IsHovered() and !self:IsSelected() then
		self.m_colText = Color( 255, 255, 255, 255 )
	elseif self:IsSelected() and !self:IsHovered() then
		self.m_colText = Color( 255, 255, 255, 255 )
	elseif !self:IsSelected() and !self:IsHovered() then
		self.m_colText = Color( 175, 175, 175, 255 )
	end

	local r = LerpValue( self.m_colT.r, self.m_colText.r )
	local g = LerpValue( self.m_colT.g, self.m_colText.g )
	local b = LerpValue( self.m_colT.b, self.m_colText.b )
	local a = LerpValue( self.m_colT.a, self.m_colText.a )

	self.m_colT = Color( r, g, b, a )

end

function PANEL:DoClickInternal()
	for k, v in pairs( self:GetParent():GetSelectedChildren() ) do
		v:SetSelected( false )
	end
	self:ToggleSelection()
end

function PANEL:Paint( w, h )
	self:PaintHover()
	self:PaintHoverText()

	draw.RoundedBox( 0, 0, 0, w, h, self.m_col )
	draw.SimpleTextOutlined( self:GetText(), self:GetFont(), w / 2, h / 2, self.m_colT, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0, 255 ) )
	
	self:PostPaint( w, h )
end
function PANEL:PostPaint( w, h ) end

function PANEL:PerformLayout( w, h )
	self:PostPerformLayout( w, h )
end
function PANEL:PostPerformLayout( w, h ) end

vgui.Register( "RKCore:Button", PANEL, "DButton" )

--[[
PANEL = {}

function PANEL:Init()

end

function PANEL:Paint( w, h )

end

function PANEL:PerformLayout( w, h )

end
]]--