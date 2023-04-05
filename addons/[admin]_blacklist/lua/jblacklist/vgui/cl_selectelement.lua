--Creating function to create a selector.
function jBlacklist.VGui.CreateSelector( parent, width, height, xPos, yPos, buttonHeight )

	--Creating global table.
	local Selector = {TotalAllowed = 15}

	--Creating a close button.
	Selector.CloseButton = vgui.Create("DButton",parent)
	Selector.CloseButton:SetSize(width * 0.1,buttonHeight)
	Selector.CloseButton:SetPos(xPos + width * 0.9, yPos)
	Selector.CloseButton:SetText(jBlacklist.LoadedLanguage["MULTISELECTOR_DONE"])
	Selector.CloseButton:SetTextColor(Color(255,255,255))
	Selector.CloseButton:SetFont("jBlacklist_HUD_Mini")

	Selector.CloseButton.Paint = function( s, w, h )
		surface.SetDrawColor(s:IsDown() and Color(188, 43, 70) or s:IsHovered() and Color(173, 28, 55) or Color(158,13,40))
		surface.DrawRect(0,0,w,h)

		surface.SetDrawColor(Color(55,0,0))
		surface.DrawOutlinedRect(-1,0,w + 1,h)
	end

	Selector.CloseButton.DoClick = function(  )
		Selector.SelectorPanel:SetVisible(false)
		Selector.SearchField:SetText("")
		Selector.SearchField:SetWidth(width)
		Selector.SelectorPanel.VBar:SetScroll(0)
		Selector.SelectorPanel:SetTall(height - buttonHeight)

		for k,v in pairs(Selector.SelectorPanel:GetChildren()[1]:GetChildren()) do
			v:SetVisible(true)
			v:SetPos(0,0)
			v:Dock(TOP)
		end

		Selector.SelectorPanel.ActiveObjects = table.Count(Selector.SelectorPanel.pnlCanvas:GetChildren())
		Selector.SelectorPanel.UsedHeight = math.Min(Selector.SelectorPanel.pnlCanvas:GetChildren()[1]:GetTall() * Selector.SelectorPanel.ActiveObjects, Selector.SelectorPanel:GetTall())
	end

	--Creating a button to toggle the box.
	Selector.SearchField = vgui.Create("DTextEntry",parent)
	Selector.SearchField:SetSize(width,buttonHeight)
	Selector.SearchField:SetPos(xPos, yPos)
	Selector.SearchField:SetText("")
	Selector.SearchField.HelpText = "Helptext"
	Selector.SearchField:SetFont("jBlacklist_HUD_Mini")

	Selector.SearchField.OnChange = function(  )

		Selector.SelectorPanel.ActiveObjects = 0

		Selector.SelectorPanel:SetTall(height)

		for k,v in pairs(Selector.SelectorPanel:GetChildren()[1]:GetChildren()) do
			v:SetPos(0,0)
			if string.match(string.lower(v:GetText()),string.lower(Selector.SearchField:GetText())) == nil then
				v:SetVisible(false)
			else
				v:SetVisible(true)
				Selector.SelectorPanel.ActiveObjects = Selector.SelectorPanel.ActiveObjects + 1
			end
			v:Dock(TOP)
		end

		Selector.SelectorPanel.UsedHeight = math.Min(Selector.SelectorPanel.pnlCanvas:GetChildren()[1]:GetTall() * Selector.SelectorPanel.ActiveObjects, Selector.SelectorPanel:GetTall())
		Selector.SelectorPanel.VBar:SetScroll(0)
		Selector.SelectorPanel.VBar:SetVisible(Selector.SelectorPanel.UsedHeight != 0)
		Selector.SelectorPanel:SetTall(Selector.SelectorPanel.UsedHeight)

	end

	--Creating paint function for the SearchField.
	Selector.SearchField.Paint = function( s, w, h )

		surface.SetDrawColor(100,100,100)
		surface.DrawRect(0,0,w,h)

		surface.SetDrawColor(36,36,36)
		surface.DrawOutlinedRect(0,0,w,h)
		s:DrawTextEntryText(Color(255,255,255),Color(158, 217, 255),Color(0,0,0))

		local Editing = s:IsEditing()
		local isActive = Selector.SelectorPanel:IsVisible()
		local Wide = s:GetWide()

		if isActive then
			s:SetWidth(Lerp(FrameTime() * 8,Wide,width * 0.9))
		end

		if s:GetText() == "" and !Editing then
			draw.SimpleText(s.HelpText,s:GetFont(),width / 2,h / 2,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		elseif s:GetText() == "" and Editing then
			draw.SimpleText(jBlacklist.LoadedLanguage["ENTER_SEARCHWORD"],s:GetFont(),width * 0.01,h / 2,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
		end

	end

	--Creating Selector.SelectorPanel
	Selector.SelectorPanel = vgui.Create("DScrollPanel", parent)
	Selector.SelectorPanel:SetPos(xPos, yPos + buttonHeight)
	Selector.SelectorPanel:SetSize(width,height - buttonHeight)
	Selector.SelectorPanel:SetVisible(false)
	Selector.SelectorPanel.ActiveObjects = 0
	Selector.SelectorPanel.UsedHeight = 0

	Selector.SelectorPanel.PaintOver = function( s, w, h)

		surface.SetDrawColor(36,36,36)
		surface.DrawRect(w - 1,0,1,s.UsedHeight)
		surface.DrawRect(0,0,1,s.UsedHeight)
		surface.DrawRect(0,s.UsedHeight - 1,w,1)
	end

	--Creating OnGetFocus function for the SearchField.
	Selector.SearchField.OnGetFocus = function()
		Selector.SelectorPanel:SetVisible(true)
		Selector.SelectorPanel:MoveToFront()
		Selector.SearchField.OnChange()
	end

	--Paint scrollbar.
	jBlacklist.VGui.ColorScrollbars( Selector.SelectorPanel.VBar )

	--Return the selector.
	return Selector

end

--Creating function to add more buttons to a selector.
function jBlacklist.VGui.AddSelectorItem( Selector, name )

	--Creating the item.
	local Item = vgui.Create("DButton", Selector.SelectorPanel)
	Item:SetText(name)
	Item:Dock( TOP )
	Item:SetTextColor(Color(255,255,255,255))
	Item:SetFont("jBlacklist_HUD_Mini")

	Selector.SelectorPanel.ActiveObjects = table.Count(Selector.SelectorPanel.pnlCanvas:GetChildren())
	Selector.SelectorPanel.UsedHeight = math.Min(Selector.SelectorPanel.pnlCanvas:GetChildren()[1]:GetTall() * Selector.SelectorPanel.ActiveObjects, Selector.SelectorPanel:GetTall())

	--Injecting some vars.
	Item.Selected = false

	Item.SetHelptext = function( helpText )

		local helpButtonSize = Item:GetTall() * 0.75

		local helpButton = vgui.Create("DImageButton",Item)
		helpButton:SetSize(helpButtonSize,helpButtonSize)
		helpButton:SetPos(Selector.SelectorPanel:GetWide() - helpButtonSize * 2, Item:GetTall() / 2 - helpButtonSize / 2)
		helpButton:SetImage("icon16/help.png")

		helpButton.DoClick = function(  )

			jBlacklist.Notify( JBLACKLIST_NOTIFYENUM_WINDOW, name .. ": " .. helpText)

		end

	end

	--Creating Paint function for the button.
	Item.Paint = function( _, w, h )
		surface.SetDrawColor(Item:IsHovered() and Item.Selected == true and Color(65, 139, 155) or Item:IsHovered() and Color(81,81,81) or Item.Selected == true and Color(51, 110, 123) or Color(61,61,61))
		surface.DrawRect(0,0,w,h)

		surface.SetDrawColor(36,36,36)
		surface.DrawRect(0,h - 1,w,1)
	end

	--Creating DoClick function for the button.
	Item.DoClick = function(  )

		local TotalSelected = 0

		for k,v in pairs(Selector.SelectorPanel.pnlCanvas:GetChildren()) do
			if v.Selected == true then TotalSelected = TotalSelected + 1 end
		end

		Item.Selected = !Item.Selected

		if TotalSelected >= Selector.TotalAllowed then Item.Selected = false end

	end

	--Return the item.
	return Item

end