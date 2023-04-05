if SERVER then
	resource.AddFile( "materials/bleur_scoreboard/mute.png" )
	resource.AddFile( "resource/fonts/Starjedi.ttf" )
	return
end

-- Kirbys Shite --
// Christmas Shite

-- Set to false to disable the snow
local snow = false

function draw.SnowDropsDraw( s )
	for k,v in pairs( s.snowdrops ) do
		draw.RoundedBox( v[3]*4,v[1],v[2],v[3],v[3],Color(200,200,200) )
	end
end
function draw.SnowDrops( s, amount, offset )

	if not snow then return true end

	-- CLIENT function draw.SnowDrops( Panel, MaxSnowDrops, OffsetFromPanelBounds )
	local w = s:GetWide()
	local h = s:GetTall()
	-- local scalar = (w * h)
	offset = (offset or 0)
	if !s.snowdrops then
		s.snowdrops = {}
	else
		draw.SnowDropsDraw( s )
		if #s.snowdrops < ( amount or 64 ) and math.random(1,10) == 1 then
			table.insert( s.snowdrops, { math.random(offset,s:GetWide()-offset), offset, math.random(3,10), math.random(1,3) } )
		end
		for k,v in pairs( s.snowdrops ) do
			s.snowdrops[ k ] = { v[1], v[2] + ( v[4] / 2.5 ), v[3], v[4] }
			if v[2] > s:GetTall() - offset then
				s.snowdrops[k] = { math.random(offset,s:GetWide() - offset), 0, v[3], v[4] }
			end
		end
	end
end
-- End of Kirbys Shite --

surface.CreateFont( "bleur_scoreboard48bold", {
	font = "Star Jedi",
	size = 48,
	weight = 700,
	antialias = true,
	additive = true,
})

surface.CreateFont( "bleur_scoreboard28", {
	font = "Montserrat",
	size = 22,
	weight = 700,
	antialias = true,
	additive = true,
})

surface.CreateFont( "bleur_scoreboard14bold", {
	font = "Montserrat",
	size = 16,
	weight = 700,
	antialias = true,
	additive = true,
})

surface.CreateFont( "bleur_scoreboard12", {
	font = "Montserrat",
	size = 14,
	weight = 100,
	antialias = true,
	additive = true,
})
/*---------------------------------------------------------------------------
	CONFIG
---------------------------------------------------------------------------*/
local config = {}
config.menuAccessGroups = {}
config.width = ScrW()*0.6			--if you want this one to scale with resolution (not advised), set this to ScrW() - distance_from_edges
config.height = ScrH() - 270	--height
config.header = "orbital servers"	--text on top of scoreboard
config.headermoto = " DISCORD.GG/ORBITALSWRP"	--text on top of scoreboard but under header
config.footer = "IMPERIAL ROLEPLAY AT ITS FINEST"	--text in the bottom of the scoreboard
config.defaultSortingTab = 1	--number of tab to sort by default
config.updateDelay = 0.5 		--update delay in seconds
config.showPlayerNum = true		--Whether to show or not player count
config.menuAccessGroups["superadmin"] = true
config.menuAccessGroups["enforcement"] = true

local groups = {}
groups[ "superadmin" ]			= "Management"
groups[ "enforcement" ]			= "Enforcement"
groups[ "eventmaster" ]			= "Event Master"
groups[ "user" ]				= "User" 
groups[ "trialmoderator" ]		= "Trial Moderator" 
groups[ "trialeventmaster" ]	= "Trial Event Master" 
groups[ "builder" ]				= "Builder" 
groups[ "user" ]				= "User" 


groups.user="User"
groups.usar="User"
groups.enforcement="Enforcement"
groups.event_master="Event Master"
groups.superadmin="Management"
groups.trialeventmaster="Trial Event Master"
groups.trialmoderator="Trial Moderator"
groups.builder="Builder"



local theme = {}
theme.top 		= Color( 30, 30, 30, 255 )
theme.bottom 	= Color( 30, 30, 30, 255 )
theme.tab	 	= Color( 230, 230, 230, 255 )
theme.footer 	= Color( 194, 0, 194 )
theme.header 	= Color( 255, 255, 255 )
/*---------------------------------------------------------------------------
	TABS

	Explanation:
	name - 	self-explanatory
	size - 	fraction of tab area that it should take, number between 0 and 1
			where 1 means whole tab area and 0 means none
	fetch -	this is just a function that returns what to put in certain tab,
			very useful if you want developers to add a tab for their addon to
			the scoreboard
	liveUpdate 	- 	set to true if you want values to update for the tab while
					scoreboard is open
	fetchColor 	-	this function fetches for color, useful for different
					rank colors and whatnot
---------------------------------------------------------------------------*/

/*---------------------------------------------------------------------------
	Below you can find 2 packs of premade tabs
	2# - TTT
	Uncomment the ones you want to use, don't use both!
---------------------------------------------------------------------------*/

-- surface.SetFont( bleur_scoreboard14bold )
-- local text_size = surface.GetTextSize( "1" )
-- local percent_of_screen = text_size / config.width 

local tabs = {}
tabs[ 0 ] = { name = "Name",		size = 0.3,		liveUpdate = false,		fetch = function( ply ) return ply:Name() end }
tabs[ 1 ] = { name = "Regiment",	size = 0.2675,		liveUpdate = false,		fetch = function( ply )
	if ply:Team() == -1 or ply:Team() == 1001 then 
		return "LOADING"
	else
		return ply:GetRegimentData()[ "name" ]
	end
end }
tabs[ 2 ] = { name = "Rank",		size = 0.2675,			liveUpdate = false,		fetch = function( ply ) return ply:GetRegimentRankName() end }
tabs[ 3 ] = { name = "Kills", 		size = 0.055,		liveUpdate = false,		fetch = function( ply ) return ply:Frags() end }
tabs[ 4 ] = { name = "Deaths", 		size = 0.055,		liveUpdate = false,		fetch = function( ply ) return ply:Deaths() end }
tabs[ 5 ] = { name = "Ping", 		size = 0.055,		liveUpdate = true, 		fetch = function( ply ) return ply:Ping() end }

--local tabs = {}
--tabs[ 0 ] = { name = "Name", 		size = 0.3,		liveUpdate = false, 	fetch = function( ply ) return ply:Team() [ ply:Battalion() ].." "..ply:Rank().." "..ply:Nick() end }
--tabs[ 1 ] = { name = "Score",		size = 0.1,		liveUpdate = false, 	fetch = function( ply ) return ply:Frags() end }
--tabs[ 2 ] = { name = "Rank",		size = 0.2,		liveUpdate = false, 	fetch = function( ply ) return groups[ ply:GetUserGroup() ] or ply:GetUserGroup() end }
--tabs[ 3 ] = { name = "Deaths", 	size = 0.125,	liveUpdate = false, 	fetch = function( ply ) return ply:Deaths() end }
--tabs[ 4 ] = { name = "Karma", 	size = 0.125,	liveUpdate = false, 	fetch = function( ply ) return math.floor( ply:GetBaseKarma() ) end }
--tabs[ 5 ] = { name = "Ping", 		size = 0.125,	liveUpdate = true, 		fetch = function( ply ) return ply:Ping() end }

if not tabs then
	error( "Bleur Scoreboard: You haven't enabled ANY tabs! Open bleur_scoreboard.lua and remove comment lines to enable certain tabs", 0 )
	return false
end

local size = 0
for _, tab in pairs ( tabs ) do
	size = size + tab.size
end
if size > 1 then
	error( "Bleur Scoreboard: Your tabs are way too big. Summarized tab sizes can't be bigger than 1!")
	return false
end

local samFunctions = {} -- first one is the commands name, second one is the requirement for arguments
samFunctions[ 'Fun' ] =
{
	{ 'slap', true },
	{ 'whip', true },
	{ 'slay', true },
	{ 'sslay', true },
	{ 'ignite', true },
	{ 'freeze', false },
	{ 'god', false },
	{ 'hp', true },
	{ 'armor', true },
	{ 'cloak', false },
	{ 'blind', true },
	{ 'jail', true },
	{ 'jailtp', true },
	{ 'ragdoll', false },
	{ 'maul', true },
	{ 'strip', false },
	{ 'unfreeze', false },
}

samFunctions[ 'User Management' ] =
{
	{ 'adduser', true },
	{ 'removeuser', true },
	{ 'userallow', true },
	{ 'userdeny', true },
}

samFunctions[ 'Utility' ] =
{
	{ 'kick', true },
	{ 'ban', true },
	{ 'noclip', true },
	{ 'spectate', true },
}

samFunctions[ 'Chat' ] =
{
	{ 'gimp', true },
	{ 'mute', true },
	{ 'gag', true },
}

samFunctions[ 'Teleport' ] =
{
	{ 'bring', false },
	{ 'send', true },
	{ 'teleport', false },
}
/*---------------------------------------------------------------------------
	END OF CONFIG, DON'T TOUCH ANYTHING BELOW
---------------------------------------------------------------------------*/
local tabArea = config.width - 35 -- preserve 35px from left edge for avatar
tabArea = tabArea - 30 -- preserve 30px from right edge for mute button
for i, tab in pairs( tabs ) do
	local prev = tabs[ i - 1 ] or { pos = 0, size = 0 }
	tabs[ i ].pos = prev.pos + prev.size
	tabs[ i ].size = tabArea * tab.size
end

local function fetchRowColor( ply )
	local col = ply:GetRegimentData() and ply:GetRegimentData()[ "colour" ] and table.Copy( ply:GetRegimentData()[ "colour" ] ) or Color( 50, 50, 50 )
	col.a = 200

	return col
end
/*---------------------------------------------------------------------------
	VISUALS
---------------------------------------------------------------------------*/
local blur = Material( "pp/blurscreen" )
local function drawBlur( x, y, w, h, layers, density, alpha )
	surface.SetDrawColor( 255, 255, 255, alpha )
	surface.SetMaterial( blur )

	for i = 1, layers do
		blur:SetFloat( "$blur", ( i / layers ) * density )
		blur:Recompute()

		render.UpdateScreenEffectTexture()
		render.SetScissorRect( x, y, x + w, y + h, true )
			surface.DrawTexturedRect( 0, 0, ScrW(), ScrH() )
		render.SetScissorRect( 0, 0, 0, 0, false )
	end
end

local function drawPanelBlur( panel, layers, density, alpha )
	local x, y = panel:LocalToScreen(0, 0)

	surface.SetDrawColor( 255, 255, 255, alpha )
	surface.SetMaterial( blur )

	for i = 1, 3 do
		blur:SetFloat( "$blur", ( i / layers ) * density )
		blur:Recompute()

		render.UpdateScreenEffectTexture()
		surface.DrawTexturedRect( -x, -y, ScrW(), ScrH() )
	end
end

local function drawLine( startPos, endPos, color )
	surface.SetDrawColor( color )
	surface.DrawLine( startPos[1], startPos[2], endPos[1], endPos[2] )
end

local function drawRectOutline( x, y, w, h, color )
	surface.SetDrawColor( color )
	surface.DrawOutlinedRect( x, y, w, h )
end
/*---------------------------------------------------------------------------
	PANEL
---------------------------------------------------------------------------*/
local PANEL = {}
function PANEL:Init()
	self:SetSize( 100, 50 )
	self:Center()
	self.color = Color( 0, 0, 0, 200 )
	self.ply = nil
end

function PANEL:OnMousePressed()
	local ply = self.ply
	if not config.menuAccessGroups[ LocalPlayer():GetNWString( "usergroup" ) ] then return end

	self.menu = vgui.Create( "DMenu" )
	self.menu:SetPos( gui.MouseX(), gui.MouseY() )
	self.menu.categories = {}
	for category, cmds in pairs( samFunctions ) do
		self.menu.categories[ category ] = self.menu:AddSubMenu( category )
		for i, cmd in pairs ( cmds ) do
			self.menu.categories[ category ]:AddOption( cmd[ 1 ], function()
				if not cmd[ 2 ] then
					if ply:IsValid() then
						print( "sam " .. cmd[ 1 ] .. " \"" .. ply:Nick() .. "\"" )
						LocalPlayer():ConCommand( "sam " .. cmd[ 1 ] .. " \"" .. ply:Nick() .. "\"" )
					end
					return
				end
				local argMenu = vgui.Create( "EditablePanel" )
				argMenu:SetSize( 300, 50 )
				argMenu:Center()
				argMenu:MakePopup()
				argMenu.Paint = function()
					draw.RoundedBox( 0, 0, 0, argMenu:GetWide(), argMenu:GetTall(), Color( theme.top.r, theme.top.g, theme.top.b, 235 ) )
					drawRectOutline( 0, 0, argMenu:GetWide(), argMenu:GetTall(), Color( theme.top.r, theme.top.g, theme.top.b, 235 ) )
					draw.SimpleText( "Specify arguments for command '" .. cmd[ 1 ] .. "'", "bleur_scoreboard12", argMenu:GetWide() * 0.5, 5, Color( theme.header.r, theme.header.g, theme.header.b, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
				end

				local argEntry = vgui.Create( "DTextEntry", argMenu )
				argEntry:SetSize( 280, 20 )
				argEntry:AlignBottom( 5 )
				argEntry:CenterHorizontal()
				argEntry.OnEnter = function()
					if ply:IsValid() then
						LocalPlayer():ConCommand( "sam " .. cmd[ 1 ] .. " \"" .. ply:Nick() .. "\" " .. argEntry:GetValue() )
					end
					argMenu:Remove()
				end
			end )
		end
	end
end

function PANEL:Paint( w, h )
	draw.RoundedBox( 0, 0, 0, w, h, Color( self.color.r, self.color.g, self.color.b, 170 ) )
	drawRectOutline( 0, 0, w, h, Color( self.color.r, self.color.g, self.color.b, 180 ) )
end
vgui.Register( "bleur_row", PANEL, "EditablePanel" )

local PANEL = {}
function PANEL:Init()
	self:SetSize( config.width, config.height )
	self:Center()
	self.sortAsc = false

	self.alphaMul = 0

	for i, tab in pairs( tabs ) do
		surface.SetFont( "bleur_scoreboard14bold" )
		local width, height = surface.GetTextSize( tab.name )
		local tabLabel = vgui.Create( "DLabel", self )
		tabLabel:SetFont( "bleur_scoreboard14bold" )
		tabLabel:SetColor( Color( theme.tab.r, theme.tab.g, theme.tab.b, theme.tab.a ) )
		tabLabel:SetText( tab.name )
		tabLabel:SizeToContents()
		tabLabel:SetPos( 35 + tab.pos + ( tab.size / 2 ) - ( width / 2 ), 81 )
		tabLabel:SetMouseInputEnabled( true )
		function tabLabel:DoClick()
			self:GetParent().sortAsc = !self:GetParent().sortAsc
			self:GetParent():populate( tab.name )
		end
	end
end

function PANEL:Paint( w, h )
	self.alphaMul = Lerp( 0.1, self.alphaMul, 1 )

	drawPanelBlur( self, 3, 6, 255 )
	draw.SnowDrops( self, math.random( 1, 100 ), 0 )

	drawPanelBlur( self, 2, 3, 255 )
	draw.RoundedBox( 0, 0, 75, w, h - 100, Color( 0, 0, 0, 150 * self.alphaMul ) )
	drawRectOutline( 0, 0, w, h, Color( 0, 0, 0, 75 * self.alphaMul  ) )
	//Top bar
	draw.RoundedBoxEx( 4, 0, 0, w, 75, Color( theme.top.r, theme.top.g, theme.top.b, theme.top.a * self.alphaMul ), true, true, false, false )
	local _, th = draw.SimpleText( config.header, "bleur_scoreboard48bold", w / 2, -5, Color( theme.header.r, theme.header.g, theme.header.b, theme.header.a * self.alphaMul ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
	draw.SimpleText( config.headermoto, "bleur_scoreboard28", w / 2, th - 5, Color( theme.header.r, theme.header.g, theme.header.b, theme.header.a * self.alphaMul ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
	if config.showPlayerNum then
		draw.SimpleText( "Players: " .. #player.GetAll() .. "/" .. game.MaxPlayers(), "bleur_scoreboard14bold", 5, 55 )
	end
	//Tabs
	draw.RoundedBox( 0, 0, 76, tabArea + 65, 25, Color( 0, 0, 0, 220 * self.alphaMul ) )
	//Bottom bar
	draw.RoundedBoxEx( 4, 0, h - 25, w, 25, Color( theme.bottom.r, theme.bottom.g, theme.bottom.b, theme.bottom.a * self.alphaMul ), false, false, true, true )
	draw.SimpleText( config.footer, "bleur_scoreboard12", w / 2, h - 12.5, Color( theme.footer.r, theme.footer.g, theme.footer.b, theme.footer.a * self.alphaMul ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
end


-- 76561198105109892


function PANEL:populate( sorting )
	self.scrollPanel = vgui.Create( "DScrollPanel", self )
	self.scrollPanel:SetPos( 1, 102 )
	self.scrollPanel:SetSize( self:GetWide() + 18, self:GetTall() - 128 )

	if self.list then
		self.list:Remove()
	end

	self.list = vgui.Create( "DIconLayout", self.scrollPanel )
	self.list:SetSize( self.scrollPanel:GetWide() - 20, self.scrollPanel:GetTall() )
	self.list:SetPos( 1, 0 )
	self.list:SetSpaceY( 1 )

	local players = {}
	for i, ply in pairs( player.GetAll() ) do
		table.insert(players, 1, {ply=ply})
		--if not players[1] then i = 1 end
		--players[ i ] = { ply = ply }
		for _, tab in pairs( tabs ) do
			players[ 1 ][ tab.name ] = tab.fetch( ply )
		end
	end
	table.SortByMember( players, sorting or tabs[ 0 ].name, self.sortAsc )

	for i, data in pairs( players ) do
		local row = vgui.Create( "bleur_row", self.list )
		row:SetSize( self.list:GetWide() - 2, 30 )
		row.color = fetchRowColor( data.ply )
		row.ply = data.ply

		row.avatar = vgui.Create( "AvatarImage", row )
		row.avatar:SetSize( 26, 26 )
		row.avatar:SetPos( 2, 2 )
		row.avatar:SetPlayer( data.ply, 64 )

		if row.ply ~= LocalPlayer() then
			row.mute = vgui.Create( "DImageButton", row )
			row.mute:SetSize( 16, 16 )
			row.mute:SetPos( row:GetWide()  - 31, 8 )
			row.mute:SetImage( "bleur_scoreboard/mute.png" )
			row.mute:SetColor( Color( 0, 0, 0 ) )
			if row.ply:IsMuted() then
				row.mute:SetColor( Color( 255, 0, 0 ) )
			end

			function row.mute:DoClick()
				local row = self:GetParent()
				row.ply:SetMuted( !row.ply:IsMuted() )

				self:SetColor( Color( 0, 0, 0 ) )
				if row.ply:IsMuted() then
					self:SetColor( Color( 255, 0, 0 ) )
				end
			end
		end

		for i, tab in pairs( tabs ) do
			surface.SetFont( "bleur_scoreboard14bold" )
			local width, height = surface.GetTextSize( data[ tab.name ] or "" )
			local info = vgui.Create( "DLabel", row )
			info:SetFont( "bleur_scoreboard14bold" )
			info:SetColor( Color( 255, 255, 255 ) )
			info:SetText( data[ tab.name ] or "ERROR" )
			info:SizeToContents()
			info:SetPos( 35 + tab.pos + ( tab.size / 2 ) - ( width / 2 ), 0 )
			info:CenterVertical()
			if tab.fetchColor then
				info:SetColor( tab.fetchColor( ply ) )
			end

			if tab.liveUpdate then
				function info:Think()
					self.lastThink = self.lastThink or CurTime()
					if self.lastThink + config.updateDelay < CurTime() then
						surface.SetFont( "bleur_scoreboard14bold" )
						local width, height = surface.GetTextSize( data[ tab.name ] or "" )
						self:SetFont( "bleur_scoreboard14bold" )
						self:SetColor( Color( 255, 255, 255 ) )
						if row.ply:IsValid() then
							self:SetText( tab.fetch( row.ply ) or "ERROR" )
						else
							self:SetText( "ERROR" )
						end
						self:SizeToContents()
						self:SetPos( 35 + tab.pos + ( tab.size / 2 ) - ( width / 2 ), 0 )
						self:CenterVertical()

						self.lastThink = CurTime()
					end
				end
			end
		end
	end
end
vgui.Register( "bleur_scoreboard", PANEL, "EditablePanel" )
/*---------------------------------------------------------------------------
	FUNCTIONALITY - DON'T TOUCH ANYTHING BELOW!
---------------------------------------------------------------------------*/
timer.Simple( 0.1, function()
	for i, v in pairs( hook.GetTable()["ScoreboardShow"] or {} )do
		hook.Remove( "ScoreboardShow", i)
	end

	for i, v in pairs( hook.GetTable()["ScoreboardHide"] or {} )do
		hook.Remove( "ScoreboardHide", i)
	end

	local scoreboard = nil
	hook.Add( "ScoreboardShow", "bleur_scoreboard_show", function()
		gui.EnableScreenClicker( true )

		scoreboard = vgui.Create( "bleur_scoreboard" )
		scoreboard:populate( tabs[ config.defaultSortingTab ].name )
		return true
	end )

	hook.Add( "ScoreboardHide", "bleur_scoreboard_hide", function()
		gui.EnableScreenClicker( false )

		scoreboard:Remove()
		return true
	end )
end )