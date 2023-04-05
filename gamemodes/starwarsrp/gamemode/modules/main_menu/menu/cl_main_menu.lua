local MODULE = MODULE or RK.Modules:Get( "main_menu" )
MODULE.Backgrounds = {
	--"https://wallpapers.com/images/high/fierce-clone-trooper-star-wars-bex39h3il8fddy96.jpg",
	--"https://wallpapercave.com/wp/wp2469577.jpg",
	--"https://wallpapercave.com/wp/wp7458247.jpg",
	--"https://wallpapercave.com/wp/wp8669627.jpg",
	--"https://wallpapercave.com/wp/wp9053586.jpg",
}
for k, v in pairs( MODULE.Backgrounds ) do
	RK.Img:GetMaterial( v )
end

MODULE.Storage = {}

// Overide to disable default main menu.
function MODULE:PreRender()
	if input.IsKeyDown(KEY_ESCAPE) and gui.IsGameUIVisible() then

		if ValidPanel( self.Menu ) then
			gui.HideGameUI()
			self.Menu:Remove()
		else
			self:OpenMenu()
			gui.HideGameUI()
		end
	end
end

// Register function to be called to add a new menu item.
function MODULE:RegisterTab( name, data )
	self[ "Storage" ][ name ] = data
end

local ServerName = "Orbital Servers"

// Open the main menu.
function MODULE:OpenMenu()

	// Hook to add new menu items.
	hook.Run( "MainMenu:LoadTabs", self )

	// Screen Width and Height.
	local w, h = ScrW(), ScrH()

	// Create the main menu.
	self.Menu = vgui.Create( "RKCore:Frame" )
	self.Menu:SetSize( w, h )

	// Overide the paint function to draw the background.
	self.Menu.Paint = function( s, w, h )
		// Store the material from URL.
		s.Image = s.Image and s.Image or RK.Img:GetMaterial( self.Backgrounds[math.random( 1, 6 )] ) 

		// Draw a image
		if s.Image then
			surface.SetDrawColor( 255, 255, 255, 255 )
			surface.SetMaterial( s.Image )
			surface.DrawTexturedRect( 0, 0, w, h )
		else
			s:DrawBlur( 8 )
		end

		local t_w, t_h = draw.SimpleTextOutlined( string.lower( "Main Menu - " .. ServerName ), RK.Config:Get( "Title Font", RKFont( 72 ) ), 0 + 20, 0 + 10, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1.6, Color( 0, 0, 0, 175 ) )
		draw.SimpleTextOutlined( "Main Menu - " .. string.lower( ServerName ), RKFont( 22, "Aurebesh" ), 0 + 20, 0 + t_h, Color( 100, 200, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1.6, Color( 0, 0, 0, 175 ) )
	end
	// Local variable to store the menu.
	local m = self.Menu

	// Add a new tab to the menu.
	m.Tabs = self.Menu:Insert( "Tabs", "EditablePanel", 20, h * 0.25, w * 0.2 - 20, h * 0.75 - 20 ) 

	// Create the tabs buttons
	for k, v in SortedPairsByMemberValue( self[ "Storage" ], "Order" ) do
		local b = vgui.Create( "RKCore:Button", m.Tabs )
		b:Dock( TOP )
		b:DockMargin( 0, 0, 0, 5 )
		b:SetTall( 40 )
		b:SetText( k:lower() )
		b:SetFont( RKFont( 28 ) )
		b.DoClick = function( s )
			m.Container:ChangePage( k )

			surface.PlaySound( "ambient/water/rain_drip1.wav" )
		end
	end

	// Create the container for the tabs.
	m.Container = self.Menu:Insert( "Container", "EditablePanel", w * 0.2 + 10, h * 0.1, w * 0.8 - 20, h * 0.9 - 20 ) 
	m.Container.Paint = function( s, w, h )
		draw.SimpleTextOutlined( s.Page and s.Page:lower() or "", RK.Config:Get( "Sub Title Font", RKFont( 22 ) ), 5, 0, Color( 100, 200, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1.6, Color( 0, 0, 0, 175 ) )
		-- draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 175 ) )
	end
	// Function to change the page.
	m.Container.ChangePage = function( s, page )
		s:Clear()
		if !self[ "Storage" ][ page ] then return end
		if !self[ "Storage" ][ page ].OnCreate then return end
		s.Page = page

		self[ "Storage" ][ page ].OnCreate( s )
	end

	m.Disconnect = vgui.Create( "DButton", m )
	m.Disconnect:SetPos( m:GetWide() - 180, m:GetTall() - 50 )
	m.Disconnect:SetSize( 180, 40 )
	m.Disconnect:SetText( "" )
	m.Disconnect.Paint = function( s, w, h )
		local col = s:IsHovered() and Color( 100, 200, 255 ) or Color( 175, 175, 175, 255 )
		draw.SimpleTextOutlined( "Disconnect", RK.Config:Get( "Sub Title Font", RKFont( 22 ) ), 15, h * 0.5, col, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1.6, Color( 0, 0, 0, 175 ) )
	end
	m.Disconnect.DoClick = function( s )
		surface.PlaySound( "ambient/water/rain_drip1.wav" )

		RunConsoleCommand( "Disconnect" )
	end

	m.ClearDecals = vgui.Create( "DButton", m )
	m.ClearDecals:SetPos( m:GetWide() - 210, m:GetTall() - 80 )
	m.ClearDecals:SetSize( 200, 30 )
	m.ClearDecals:SetText( "" )
	m.ClearDecals.Paint = function( s, w, h )
		local col = s:IsHovered() and Color( 100, 200, 255 ) or Color( 175, 175, 175, 255 )
		draw.SimpleTextOutlined( "Clear Decals", RK.Config:Get( "Sub Title Font", RKFont( 22 ) ), 15, h * 0.5, col, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1.6, Color( 0, 0, 0, 175 ) )
	end
	m.ClearDecals.DoClick = function( s )
		surface.PlaySound( "ambient/water/rain_drip1.wav" )

		RunConsoleCommand( "r_cleardecals" )
	end

end