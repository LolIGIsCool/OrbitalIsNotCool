--Creating function used to create a new timeselector.
function jBlacklist.VGui.CreateTimeselector( parent, width, height, xPos, yPos )

	--Creating global table.
	local Selector = {}

	--Creating the Selector.NumberEntry.
	Selector.NumberEntry = vgui.Create("DTextEntry",parent)
	Selector.NumberEntry:SetSize(width * 0.8, height)
	Selector.NumberEntry:SetPos(xPos, yPos)
	Selector.NumberEntry:SetNumeric(true)
	Selector.NumberEntry:SetText("8")
	Selector.NumberEntry:SetFont("jBlacklist_HUD_Mini")

	--Creating paint function for the Selector.NumberEntry.
	Selector.NumberEntry.Paint = function( s, w, h )
		surface.SetDrawColor(Color(36,36,36))
		surface.DrawRect(0,0,w,h)

		surface.SetDrawColor(s:GetDisabled() and Color(135,135,135) or Color(100,100,100))
		surface.DrawRect(1,1,w - 1,h - 2)
		s:DrawTextEntryText(Color(255,255,255),Color(158, 217, 255),Color(0,0,0))
	end

	--Creating the Selector.TimeType.
	Selector.TimeType = vgui.Create("DComboBox",parent)
	Selector.TimeType:SetSize(width * 0.2,height)
	Selector.TimeType:SetPos(xPos + Selector.NumberEntry:GetWide(), yPos)
	Selector.TimeType:SetSortItems(false)
	Selector.TimeType:SetTextColor(Color(255,255,255))
	Selector.TimeType:SetFont("jBlacklist_HUD_Mini")

	--Creating paint function for the Selector.TimeType.
	Selector.TimeType.Paint = function( _, w, h )
		surface.SetDrawColor(Color(36,36,36))
		surface.DrawRect(0,0,w,h)

		surface.SetDrawColor(80,80,80)
		surface.DrawRect(1,1,w - 2,h - 2)
	end

	--Creating paint function for the Selector.TimeType.DropButton.
	Selector.TimeType.DropButton.Paint = function( _, w, h )
		draw.SimpleText("▼","jBlacklist_HUD_Mini",w * 0.65,h / 2,Selector.TimeType:IsHovered() and Color(255,255,255) or Color(200,200,200),TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

	--Creating OnSelect function for the Selector.TimeType.
	Selector.TimeType.OnSelect = function( _, index )
		Selector.NumberEntry:SetDisabled(index == 8)
	end

	--Adding choices for the Selector.TimeType.
	Selector.TimeType:AddChoice(jBlacklist.LoadedLanguage["TIME_SECONDS"], 1)
	Selector.TimeType:AddChoice(jBlacklist.LoadedLanguage["TIME_MINUTES"], 60)
	Selector.TimeType:AddChoice(jBlacklist.LoadedLanguage["TIME_HOURS"], 3600, true)
	Selector.TimeType:AddChoice(jBlacklist.LoadedLanguage["TIME_DAYS"], 86400)
	Selector.TimeType:AddChoice(jBlacklist.LoadedLanguage["TIME_WEEKS"], 604800)
	Selector.TimeType:AddChoice(jBlacklist.LoadedLanguage["TIME_MONTHS"], 2629743)
	Selector.TimeType:AddChoice(jBlacklist.LoadedLanguage["TIME_YEARS"], 31556926)
	Selector.TimeType:AddChoice(jBlacklist.LoadedLanguage["TIME_PERMANENT"], -1)

	--Return the selector.
	return Selector

end