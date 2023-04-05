// Local all common functions
local draw_RoundedBox, isbool, Color, table_insert, vgui_Register = draw.RoundedBox, isbool, Color, table.insert, vgui.Register

// local PANEL MetaTable
local PANEL = {}

// On Panel Created
function PANEL:Init()
	// Container table
	self.m_tContainer = self.m_tContainer or {}

	// Repaint the scroll bar and the container
	timer.Simple( 0, function() if self and IsValid( self ) then self:RepaintScrollBar() end end )
end

// On Panel Paint
function PANEL:Paint( w, h )
	// Draw blur if enabled
	if self.m_bShouldDrawBlur then self:DrawBlur( 8 ) end
	
	// Draw the background
	--surface.SetAlphaMultiplier( 0.1 )
	--draw_RoundedBox( 0, 0, 0, w, h, self:GetDrawColour( "Background" ) )
	--surface.SetAlphaMultiplier( 1 )

	// Call PostPaint function
	self:PostPaint( w, h )
end

// Default post paint function
function PANEL:PostPaint( w, h )

end

// Repaint the scroll bar
function PANEL:RepaintScrollBar()

	// Get Scroll Bar
	local bar = self:GetVBar()
	
	// If the scroll bar is not valid, return
	if !bar or !IsValid( bar ) then return end

	// Repaint the scroll bar
	function bar:Paint(w, h)
		draw_RoundedBox( 2, 0, 0, w, h, Color( 0, 0, 0, 100 ) )
		--self:DrawBlur( 4 )
	end
	// Repaint the scroll bar's Up Arrow
	function bar.btnUp:Paint(w, h)
		draw_RoundedBox( 0, w * 0.275, 0, w * 0.5, h, Color( 100, 200, 255, 255 ) )
	end
	// Repaint the scroll bar's Down Arrow
	function bar.btnDown:Paint(w, h)
		draw_RoundedBox( 0, w * 0.275, 0, w * 0.5, h, Color( 100, 200, 255, 255 ) )
	end
	// Repaint the scroll bar's Grip
	function bar.btnGrip:Paint(w, h)
		draw_RoundedBox( 0, w * 0.275, 0, w * 0.5, h, Color( 100, 200, 255, 255 ) )
	end
end

// Add Panel to the scrollbar
function PANEL:AddPanel( panel )
	table_insert( self.m_tContainer, panel )

	self:AddItem( panel )
end

// Remove panels from the scrollbar
function PANEL:GetPanels()
	return self.m_tContainer
end

// Register the panel
vgui_Register( "RKCore:ScrollPanel", PANEL, "DScrollPanel")