ui.SpacerHeight = 35
ui.ButtonHeight = 30

local tex_white		= surface.GetTextureID( "vgui/white" )

function draw.NoTexture()
	surface.SetTexture( tex_white )
end

local SKIN 	= {
	PrintName 	= 'OS',
	Author 	 	= 'N/A'
}

local color_os			    = Color(150, 0, 255)
local color_gradient 		= Color(85,85,85,200)
local color_header 			= Color(44, 48, 56, 240)
local color_background 		= Color(44, 48, 56, 150)
local color_outline 		= Color(0,0,0,220)
local color_hover 			= Color(160,160,160,75)
local color_button 			= Color(140,140,140,150)
local color_button_hover	= Color(220,220,220,150)
local color_close 			= Color(235,235,235)
local color_close_bg 		= Color(215,45,90)
local color_close_hover 	= Color(235,25,70)

local color_offwhite 		= Color(200,200,200)
local color_flat_black 		= Color(40,40,40)
local color_black 			= Color(0,0,0)
local color_white 			= Color(255,255,255)
local color_red 			= Color(235,10,10)
local color_green 			= Color(10,235,10)
--blur
local blur = Material "pp/blurscreen"
local function DrawBlur(panel, amount)
	local x, y = panel:LocalToScreen(0, 0)
	local scrW, scrH = ScrW(), ScrH()
	surface.SetDrawColor(255, 255, 255)
	surface.SetMaterial(blur)
	for i = 1, 3 do
		blur:SetFloat("$blur", (i / 3) * (amount or 6))
		blur:Recompute()
		render.UpdateScreenEffectTexture()
		surface.DrawTexturedRect(x * -1, y * -1, scrW, scrH)
	end
end
--fonts

surface.CreateFont('ui.60', {font = 'roboto', size = 60, weight = 700})
surface.CreateFont('ui.40', {font = 'roboto', size = 40, weight = 500})
surface.CreateFont('ui.39', {font = 'roboto', size = 39, weight = 500})
surface.CreateFont('ui.38', {font = 'roboto', size = 38, weight = 500})
surface.CreateFont('ui.37', {font = 'roboto', size = 37, weight = 500})
surface.CreateFont('ui.36', {font = 'roboto', size = 36, weight = 500})
surface.CreateFont('ui.35', {font = 'roboto', size = 35, weight = 500})
surface.CreateFont('ui.34', {font = 'roboto', size = 34, weight = 500})
surface.CreateFont('ui.33', {font = 'roboto', size = 33, weight = 500})
surface.CreateFont('ui.32', {font = 'roboto', size = 32, weight = 500})
surface.CreateFont('ui.31', {font = 'roboto', size = 31, weight = 500})
surface.CreateFont('ui.30', {font = 'roboto', size = 30, weight = 500})
surface.CreateFont('ui.29', {font = 'roboto', size = 29, weight = 500})
surface.CreateFont('ui.28', {font = 'roboto', size = 28, weight = 500})
surface.CreateFont('ui.27', {font = 'roboto', size = 27, weight = 400})
surface.CreateFont('ui.26', {font = 'roboto', size = 26, weight = 400})
surface.CreateFont('ui.25', {font = 'roboto', size = 25, weight = 400})
surface.CreateFont('ui.24', {font = 'roboto', size = 24, weight = 400})
surface.CreateFont('ui.23', {font = 'roboto', size = 23, weight = 400})
surface.CreateFont('ui.22', {font = 'roboto', size = 22, weight = 400})
surface.CreateFont('ui.20', {font = 'roboto', size = 20, weight = 400})
surface.CreateFont('ui.19', {font = 'roboto', size = 19, weight = 400})
surface.CreateFont('ui.18', {font = 'roboto', size = 18, weight = 400})
surface.CreateFont('ui.17', {font = 'roboto', size = 15, weight = 550})
surface.CreateFont('ui.15', {font = 'roboto', size = 15, weight = 550})
surface.CreateFont('ui.12', {font = 'roboto', size = 12, weight = 550})

-- Frames

local blur = Material "pp/blurscreen"
local function DrawBlur(panel, amount)
	local x, y = panel:LocalToScreen(0, 0)
	local scrW, scrH = ScrW(), ScrH()
	surface.SetDrawColor(255, 255, 255)
	surface.SetMaterial(blur)
	for i = 1, 3 do
		blur:SetFloat("$blur", (i / 3) * (amount or 6))
		blur:Recompute()
		render.UpdateScreenEffectTexture()
		surface.DrawTexturedRect(x * -1, y * -1, scrW, scrH)
	end
end


function SKIN:PaintFrame(self, w, h)
	DrawBlur( self, 8 )
	draw.RoundedBoxEx(5, 0, 0, w, 30, color_header, true, true, false, false)
	--draw.SimpleText(self.FText or "",self.FFont or "ui.18", 8,6,Color(255,255,255,255))
	if (self.Accent) then
		draw.RoundedBox(5, 0, 0, 3, 30, color_os)
	end

	
	draw.RoundedBox(5, 0, 0, w, h, color_background)
	
end

function SKIN:PaintFrameLoading(self, w, h)
	if self.ShowIsLoadingAnim then
		draw.OutlinedBox(0, 27, w, h - 27, color_background, color_outline)

		local t = SysTime() * 5
		draw.NoTexture()
		surface.SetDrawColor(255, 255, 255)
		surface.DrawArc(w * 0.5, h * 0.5, 41, 46, t * 80, t * 80 + 180, 20)
	end
end

function SKIN:PaintFrameTitleAnim(self, w, h)
	local perc = self.TitleAnimDelta

	local pa = color_os.a
	color_os.a = perc * 255
	draw.Box(1, 1, 3, 28, color_os)
	color_os.a = pa

	if (perc == 1) then
		self.Accent = true
	end
end

function SKIN:PaintPanel(self, w, h)
	--draw.OutlinedBox(0, 0, w, h, color_background, color_outline)
end

function SKIN:PaintShadow() end


-- Buttons
function SKIN:PaintButton(self, w, h)
	if (not self.m_bBackground) then return end

	if self:GetDisabled() then
		draw.OutlinedBox(0, 0, w, h, color_flat_black, color_outline)
	elseif (self.Active == true) then
		draw.OutlinedBox(0, 0, w, h, self.BackgroundColor or color_os, color_outline)
	else
		draw.OutlinedBox(0, 0, w, h, (self.Hovered and color_button_hover or color_button), color_outline)
	end

	self:SetTextColor(self.TextColor or ((self.Hovered and (not self:GetDisabled()) and (not self.Active)) and color_black or color_white))

	if (not self.fontset) then
		self:SetFont('ui.20')
		self.fontset = true
	end
end

function SKIN:PaintAvatarImage(self, w, h)
	if self.AvatarMaterial then
		surface.SetDrawColor(255, 255, 255)
		surface.SetMaterial(self.AvatarMaterial)
		surface.DrawTexturedRect(0, 0, w, h)
	end

	if self.Hovered then
		draw.Box(0, 0, w, h, color_hover)
	end
end

function SKIN:PaintPlayerButton(self, w, h)
	if self.Active then
		draw.OutlinedBox(0, 0, w, h, color_flat_black, color_outline)
		return
	else
		draw.OutlinedBox(0, 0, w, h, self.PlayerColor or color_background, color_outline)
	end

	if self:IsHovered() then
		draw.Box(0, 0, w, h, color_hover)
	end
end


-- Close Button
function SKIN:PaintWindowCloseButton(panel, w, h)
	if (not panel.m_bBackground) then return end

	draw.Box(0, 0, w , h, panel.Hovered and color_close_hover or color_close_bg, color_outline)

	surface.SetDrawColor(color_close)

	local xX = math.floor((w / 2) - 5)
	local xY = math.floor((h / 2) - 5)

	render.PushFilterMin(3)
		render.PushFilterMag(3)
			surface.DrawLine(xX, xY, xX + 10, xY + 10)
			surface.DrawLine(xX, xY + 10, xX + 10, xY)
		render.PopFilterMag()
	render.PopFilterMin()
end

function SKIN:PaintWindowMinimizeButton(panel, w, h) end
function SKIN:PaintWindowMaximizeButton( panel, w, h ) end





-- Scrollbar
function SKIN:PaintVScrollBar(self, w, h) end
function SKIN:PaintButtonUp(self, w, h) end
function SKIN:PaintButtonDown(self, w, h) end
function SKIN:PaintButtonLeft(self, w, h) end
function SKIN:PaintButtonRight(self, w, h) end

function SKIN:PaintScrollBarGrip(self, w, h)
	draw.Box(0, 0, w, h, color_os)
end

function SKIN:PaintScrollPanel(self, w, h)
	draw.OutlinedBox(0, 0, w, h, color_background, color_outline)
end

function SKIN:PaintUIScrollBar(self, w, h)
	draw.Box(0, self.scrollButton.y, w, self.height, color_os)
end


-- Slider
function SKIN:PaintUISlider(self, w, h)
	SKIN:PaintPanel(self, w, h)

	draw.Box(1, 1, w -2, h - 2, color_flat_black)

	if self.Vertical then
		draw.Box(1, self:GetValue() * h, w - 2, h - (self:GetValue() * h), color_os)
	else
		draw.Box(41, 1, self:GetValue() * (w - 40) - self:GetValue() * 16, h - 2, color_os)

		draw.SimpleText(math.ceil(self:GetValue() * 100) .. '%', 'ui.18', 20, h * 0.5 , color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
end

function SKIN:PaintSliderButton(self, w, h)
	draw.OutlinedBox(0, 0, w, h, self:IsHovered() and color_button_hover or color_offwhite, color_outline)
end

-- Text Entry
function SKIN:PaintTextEntry(self, w, h)
	draw.OutlinedBox(0, 0, w, h, color_offwhite, color_outline)

	-- Hack on a hack, but this produces the most close appearance to what it will actually look if text was actually there
	if ( self.GetPlaceholderText && self.GetPlaceholderColor && self:GetPlaceholderText() && self:GetPlaceholderText():Trim() != "" && self:GetPlaceholderColor() && ( !self:GetText() || self:GetText() == "" ) ) then

		local oldText = self:GetText()

		local str = self:GetPlaceholderText()
		if ( str:StartWith( "#" ) ) then str = str:sub( 2 ) end
		str = language.GetPhrase( str )

		self:SetText( str )
		self:DrawTextEntryText( self:GetPlaceholderColor(), self:GetHighlightColor(), self:GetCursorColor() )
		self:SetText( oldText )

		return
	end

	self:DrawTextEntryText(color_black, color_os, color_black)
end


-- List View

function SKIN:PaintUIListView(self, w, h)
	draw.RoundedBox(5, 0, 0, w, h, ui.col.Background)
end

function SKIN:PaintListView(self, w, h)
	--draw.OutlinedBox(0, 0, w, h, color_offwhite, color_outline)
end

function SKIN:PaintListViewLine(self, w, h) -- todo, just make a new control and never use this
	if self.m_bAlt then
		draw.Box(0, 0, w, h, (self:IsSelected() or self:IsHovered()) and color_os or color_hover)
	else
		draw.Box(0, 0, w, h, (self:IsSelected() or self:IsHovered()) and color_os or color_background)
	end

	for k, v in ipairs(self.Columns) do
		if (self:IsSelected() or self:IsHovered()) then
			v:SetTextColor(color_black)
			v:SetFont('ui.20')
		else
			v:SetTextColor(color_white)
			v:SetFont('ui.15')
		end
	end
end


-- Checkbox
function SKIN:PaintCheckBox(self, w, h)
	local checked = self:GetChecked() -- check urself before u rek urself

	draw.OutlinedBox(0, 0, w, h, self:IsHovered() and color_button_hover or color_offwhite, color_outline)

	draw.Box(checked and 1 or (w * 0.5), 1, (w * 0.5) - 1, h - 2, checked and color_os or color_flat_black)
end


-- Tabs
local color_tab = color_os
function SKIN:PaintTabButton(self, w, h)
	self:SetTextColor(self.TextColor or color_white)

	if IsValid(self.m_Image) then
		draw.OutlinedBox(0, 0, h, h, color_header, color_outline)
		draw.OutlinedBox(h - 1, 0, (w - h) + 1, h, color_background, color_outline)


		if self.Hovered or self.Active then
		--	draw.Box(1, 1, 38, h - 2, color_tab)

			if self.Hovered then
				draw.Box(w - 3, 1, 6, h - 2, color_tab)
			elseif self.Active then
				draw.Box(w - 3, 1, 6, h - 2, color_tab)
			end
		end
	else
		draw.OutlinedBox(0, 0, w, h, color_background, color_outline)

		if self.Hovered then
			draw.Box(1, 1, 3, h - 2, color_tab)
			draw.Box(w - 3, 1, 6, h - 2, color_tab)
		elseif self.Active then
			draw.Box(1, 1, 3, h - 2, color_tab)
			draw.Box(w - 3, 1, 6, h - 2, color_tab)
		end
	end


end

function SKIN:PaintTabListPanel(self, w, h)
	draw.OutlinedBox(159, 0, w - 159, h, color_background, color_outline)
end


-- ComboBox
function SKIN:PaintComboBox(self, w, h)
	if IsValid(self.Menu) and (not self.Menu.SkinSet) then
		self.Menu:SetSkin('OS')
		self.Menu.SkinSet = true
	end

	self:SetTextColor(((self.Hovered or self.Depressed or self:IsMenuOpen()) and color_black or color_white))

	draw.OutlinedBox(0, 0, w, h, ((self.Hovered or self.Depressed or self:IsMenuOpen()) and color_button_hover or color_background), color_outline)
end

function SKIN:PaintComboDownArrow(self, w, h)
	surface.SetDrawColor(color_os)
	draw.NoTexture()
	surface.DrawPoly({
		{x = 0, y = w * .5},
		{x = h, y = 0},
		{x = h, y = w}
	})
end


-- DMenu
function SKIN:PaintMenu(self, w, h)
end

function SKIN:PaintMenuOption(self, w, h)
	if (not self.FontSet) then
		self:SetFont('ui.22')
		self.FontSet = true
	end

	self:SetTextColor(color_white)

	draw.OutlinedBox(0, 0, w, h + 1, color_black, color_outline)

	if self.m_bBackground and (self.Hovered or self.Highlight) then
		draw.OutlinedBox(0, 0, w, h + 1, color_button_hover, color_outline)
		self:SetTextColor(color_black)
	end
end



-- INVENTORY





function SKIN:PaintTab( panel, w, h )
	if panel:IsActive() then
		draw.RoundedBoxEx( 2, 2, 0, w - 5, h - 8, Color( 0, 0, 0, 200 ),
			true, true, false, false )
	else
		draw.RoundedBoxEx( 2, 2, 0, w - 5, h, Color( 0, 0, 0, 150 ),
			true, true, false, false )
	end
end

function SKIN:PaintPropertySheet( panel, w, h )
	surface.SetDrawColor( Color( 0, 0, 0, 200 ) )
	surface.DrawRect( 0, 20, w, h )
end

function SKIN:PaintCategoryList( panel, w, h )
end

function SKIN:PaintCollapsibleCategory( panel, w, h )
	surface.SetDrawColor( Color( 0, 0, 0, 150 ) )
	surface.DrawRect( 0, 0, w, 20 )

	surface.SetDrawColor( Color( 0, 0, 0, 150 ) )
	surface.DrawRect( 0, 0, w, h )
end

derma.DefineSkin('OS', 'Orbital\'s derma skin', SKIN)

