--[[-------------------------------------------------------------------------
Derma Settings
---------------------------------------------------------------------------]]
local FrameWidth, FrameHeight = ScrW() * 0.5, ScrH() * 0.5
local HeaderHeight = FrameHeight * 0.15
local ClosebuttonSize, ClosebuttonOffset = HeaderHeight * 0.25, HeaderHeight * 0.2
local BottomHeight = FrameHeight * 0.05
local PanelHeight = FrameHeight - HeaderHeight - BottomHeight

--Type functiontable.
local dataTypes = {
	[JBLACKLIST_CONFIG_BOOL] = isbool,
	[JBLACKLIST_CONFIG_STRING] = isstring,
	[JBLACKLIST_CONFIG_NUMBER] = isnumber,
	[JBLACKLIST_CONFIG_TABLE] = isstring,
}

--Give frame a bigger scope.
local Frame

--[[-------------------------------------------------------------------------
DermaObject Functions
---------------------------------------------------------------------------]]

local function CreateConfigChooser( isGeneral, cfgID, parent, cfgTable, width, height, usergroup )

	--Cache values needed.
	local ConfigTable_Cached = isGeneral and jBlacklist.Configurator.Config[cfgID] or jBlacklist.Configurator.Usergroups[cfgID]

	--Create a panel.
	local Panel = vgui.Create("DPanel", parent)
	Panel:SetSize(width,height)

	--Create Panel paint function.
	Panel.Paint = function( )

		--Draw the shortdesc.
		draw.SimpleText(ConfigTable_Cached.ShortDesc,"jBlacklist_HUD_Small_Bold",width * 0.01,height * 0.1,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)

		--Draw the description.
		draw.SimpleText(ConfigTable_Cached.Description,"jBlacklist_HUD_Small",width * 0.01,height * 0.3,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)

	end

	--Create value-modifier.
	local ValueModifier = vgui.Create(ConfigTable_Cached.ConfigType == JBLACKLIST_CONFIG_BOOL and "DButton" or (ConfigTable_Cached.ConfigType == JBLACKLIST_CONFIG_STRING or ConfigTable_Cached.ConfigType == JBLACKLIST_CONFIG_NUMBER) and "DTextEntry" or ConfigTable_Cached.ConfigType == JBLACKLIST_CONFIG_TABLE and "DComboBox", Panel)
	ValueModifier:SetSize(FrameWidth * 0.25,PanelHeight * 0.05)
	ValueModifier:SetPos(width * 0.01,height * 0.45)
	ValueModifier:SetTextColor(Color(255,255,255))


	if isGeneral == true then
		ValueModifier.Value = cfgTable.Config[cfgID]
	else
		ValueModifier.Value = cfgTable.Usergroups[usergroup][cfgID]
	end

	--Do different stuff depending on what type we created.
	if ConfigTable_Cached.ConfigType == JBLACKLIST_CONFIG_BOOL then

		--Set the text.
		ValueModifier:SetText(tostring(ValueModifier.Value):upper())
		ValueModifier:SetFont("jBlacklist_HUD_Small_Bold")

		--Create a DoClick function.
		ValueModifier.DoClick = function( )
			ValueModifier.Value = !ValueModifier.Value
			ValueModifier:SetText(tostring(ValueModifier.Value):upper())
		end

	elseif ConfigTable_Cached.ConfigType == JBLACKLIST_CONFIG_NUMBER then

		--Set the DTextEntry to only allow numbers.
		ValueModifier:SetNumeric(true)

		--Set the value as text.
		ValueModifier:SetText(ValueModifier.Value)
		ValueModifier:SetFont("jBlacklist_HUD_Mini")

		--Create OnChange function for ValueModifier.
		ValueModifier.OnChange = function( )
			ValueModifier.Value = tonumber(ValueModifier:GetValue())
		end

	elseif ConfigTable_Cached.ConfigType == JBLACKLIST_CONFIG_STRING then

		--Set the value as text.
		ValueModifier:SetText(ValueModifier.Value)
		ValueModifier:SetFont("jBlacklist_HUD_Mini")

		--Create OnChange function for ValueModifier.
		ValueModifier.OnChange = function( )
			ValueModifier.Value = ValueModifier:GetValue()
		end

	elseif ConfigTable_Cached.ConfigType == JBLACKLIST_CONFIG_TABLE then

		ValueModifier:SetSortItems(jBlacklist.Configurator.Config[cfgID].SortTable)

		--Add all choices.
		for k,v in pairs(isGeneral and jBlacklist.Configurator.Config[cfgID].AcceptedValues or jBlacklist.Configurator.Usergroups[cfgID].AcceptedValues) do
			ValueModifier:AddChoice(v, v)
		end

		--Set the value as text.
		ValueModifier:SetText(ValueModifier.Value)
		ValueModifier:SetFont("jBlacklist_HUD_Mini")

		--Create OnSelect function.
		ValueModifier.OnSelect = function( _, _, value)
			ValueModifier.Value = value
		end

	end

	--Create paint function for ValueModifier.
	ValueModifier.Paint = function( s, w, h )

		surface.SetDrawColor(s:IsHovered() and Color(120,120,120) or Color(100,100,100))
		surface.DrawRect(0,0,w,h)

		surface.SetDrawColor(36,36,36)
		surface.DrawOutlinedRect(0,0,w,h)

		if ConfigTable_Cached.ConfigType == JBLACKLIST_CONFIG_STRING or JBLACKLIST_CONFIG_NUMBER then
			s:DrawTextEntryText(Color(255,255,255),Color(158, 217, 255),Color(0,0,0))
		end

	end

	--Return panel.
	return {Modifier = ValueModifier, Panel = Panel}

end

function CreateUsergroupPanel( parent, usergroup, cfgTbl, onRemove )

	--Create the DPanel.
	local UsergroupPanel = vgui.Create("DPanel",parent)
	UsergroupPanel:SetSize(parent:GetWide(),parent:GetTall() * 0.25)
	UsergroupPanel.cfgTbl = cfgTbl

	--Paint the DPanel and draw text.
	UsergroupPanel.Paint = function( s, w, h)

		--Set drawcolor for the panel.
		surface.SetDrawColor(61,61,61)

		--Draw the panel.
		surface.DrawRect(0,0,w,h)

		--Set the drawcolor of the underline.
		surface.SetDrawColor(31,31,31)

		--Draw the underline.
		surface.DrawRect(0,h - 1,w,1)

		--Draw the text.
		draw.SimpleText(usergroup,"jBlacklist_HUD_Small_Bold",w * 0.025,h / 2,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)

	end

	--Create the removebutton.
	local RemoveButton = vgui.Create("DButton",UsergroupPanel)
	RemoveButton:SetSize(UsergroupPanel:GetWide() * 0.225,UsergroupPanel:GetTall() * 0.5)
	RemoveButton:SetPos(UsergroupPanel:GetWide() - RemoveButton:GetWide() - (UsergroupPanel:GetTall() - RemoveButton:GetTall()) / 2, (UsergroupPanel:GetTall() - RemoveButton:GetTall()) / 2)
	RemoveButton:SetText("Remove")
	RemoveButton:SetFont("jBlacklist_HUD_Small")
	RemoveButton:SetTextColor(Color(255,255,255))

	--Craete paintfunction for the RemoveButton.
	RemoveButton.Paint = function( s, w, h )

		--Set drawcolor of the outline.
		surface.SetDrawColor(150,53,53)

		--Draw the outline.
		surface.DrawRect(0,0,w,h)

		--Set the color of the button.
		surface.SetDrawColor(s:IsDown() and Color(255, 116, 116) or s:IsHovered() and Color(252, 103, 103) or Color(248,87,87))

		--Draw the button.
		surface.DrawRect(1,1,w - 2,h - 2)

	end

	--Create doclick function for RemoveButton.
	RemoveButton.DoClick = function( )

		--Create a popup that asks if you would like to save the changes made.
		jBlacklist.DermaQuery("Are you sure you want to remove this usergroup?\nAll permissions associated with it will be erased.", function( )

			--Call onRemove function.
			onRemove()

			--Remove value from maintable.
			parent:GetParent():GetParent().cfgTable.Usergroups[usergroup] = nil

			--Remove the DPanel.
			UsergroupPanel:Remove()

		end)

		--Play sound.
		surface.PlaySound("buttons/button16.wav")

	end

	--Create modifybutton.
	local ModifyButton = vgui.Create("DButton",UsergroupPanel)
	ModifyButton:SetSize(UsergroupPanel:GetWide() * 0.225,UsergroupPanel:GetTall() * 0.5)
	ModifyButton:SetPos(UsergroupPanel:GetWide() - ModifyButton:GetWide() * 2 - (UsergroupPanel:GetTall() - ModifyButton:GetTall()), (UsergroupPanel:GetTall() - ModifyButton:GetTall()) / 2)
	ModifyButton:SetText("Modify")
	ModifyButton:SetFont("jBlacklist_HUD_Small")
	ModifyButton:SetTextColor(Color(255,255,255))


	--Craete paintfunction for the ModifyButton.
	ModifyButton.Paint = function( s, w, h )

		--Set drawcolor of the outline.
		surface.SetDrawColor(34,77,137)

		--Draw the outline.
		surface.DrawRect(0,0,w,h)

		--Set the color of the button.
		surface.SetDrawColor(s:IsDown() and Color(73, 147, 255) or s:IsHovered() and Color(63, 141, 255) or Color(32,125,255))

		--Draw the button.
		surface.DrawRect(1,1,w - 2,h - 2)

	end

	--Create DoClick function for the ModifyButton.
	ModifyButton.DoClick = function( )

		local PanelParent = parent:GetParent()

		--Create DPanel.
		local ModifyPanel = vgui.Create("DScrollPanel",PanelParent)
		ModifyPanel:SetSize(FrameWidth,PanelHeight * 0.8)

		--Paint scrollbar.
		jBlacklist.VGui.ColorScrollbars( ModifyPanel.VBar )

		--Create paintfunction for ModifyPanel.
		ModifyPanel.Paint = function( _, w, h )

			--Set drawcolor.
			surface.SetDrawColor(61,61,61)

			--Draw panel.
			surface.DrawRect(0,0,w,h)

		end

		--Creating table of all ConfigEditors.
		local CfgEditors = {}

		--Create configs.
		for k,_ in SortedPairsByMemberValue(jBlacklist.Configurator.Usergroups, "Order") do

			--Check so the value exists in the UsergroupPanel.cfgTbl table.
			if UsergroupPanel.cfgTbl[k] == nil then continue end

			--Add configmodifier.
			CfgEditors[k] = CreateConfigChooser( false, k, ModifyPanel, PanelParent:GetParent().cfgTable,FrameWidth, PanelHeight / 4, usergroup)
			CfgEditors[k].Panel:DockMargin(0,PanelHeight * 0.05,0,0)
			CfgEditors[k].Panel:Dock(TOP)

		end

		--Create DPanel for the button.
		local DoneButtonPanel = vgui.Create("DPanel",PanelParent)
		DoneButtonPanel:SetSize(FrameWidth,PanelHeight * 0.2)
		DoneButtonPanel:SetPos(0,PanelHeight * 0.8)

		--Paint the DoneButtonPanel.
		DoneButtonPanel.Paint = function( _, w, h )

			--Set drawcolor.
			surface.SetDrawColor(61,61,61)

			--Draw panel.
			surface.DrawRect(0,0,w,h)

			--Set color for line.
			surface.SetDrawColor(31,31,31)

			--Draw line at the top.
			surface.DrawLine(0,0,w,0)

		end

		--Create DoneButton in the end.
		local DoneButton = vgui.Create("DButton",DoneButtonPanel)
		DoneButton:SetSize(FrameWidth * 0.18,PanelHeight * 0.1)
		DoneButton:Center()
		DoneButton:SetText("Save Changes")
		DoneButton:SetFont("jBlacklist_HUD_Small_Bold")
		DoneButton:SetTextColor(Color(255,255,255))

		--Craete paintfunction for the ModifyButton.
		DoneButton.Paint = function( s, w, h )

			--Set drawcolor of the outline.
			surface.SetDrawColor(34,77,137)

			--Draw the outline.
			surface.DrawRect(0,0,w,h)

			--Set the color of the button.
			surface.SetDrawColor(s:IsDown() and Color(73, 147, 255) or s:IsHovered() and Color(63, 141, 255) or Color(32,125,255))

			--Draw the button.
			surface.DrawRect(1,1,w - 2,h - 2)

		end

		--Create doclick function for DoneButton.
		DoneButton.DoClick = function( )

			--Update all the information.
			for k,v in pairs(CfgEditors) do
				PanelParent:GetParent().cfgTable.Usergroups[usergroup][k] = v.Modifier.Value
			end

			--Remove editor.
			ModifyPanel:Remove()
			DoneButtonPanel:Remove()

		end

	end

	--Return button.
	return UsergroupPanel

end

--[[-------------------------------------------------------------------------
Derma Functions
---------------------------------------------------------------------------]]

local function CreateGeneralPanel( parent )

	--Create panel
	local Panel = vgui.Create( "DScrollPanel", parent )
	Panel:SetSize(FrameWidth,PanelHeight)
	Panel:SetPos(0,HeaderHeight)

	--Create paint function for the panel.
	Panel.Paint = function( _, w, h )

		--Paint the background of the panel.
		surface.SetDrawColor(61,61,61)
		surface.DrawRect(0,0,w,h)

	end

	--Paint VBar.
	jBlacklist.VGui.ColorScrollbars( Panel.VBar )

	--Creating table of all ConfigEditors.
	local CfgEditors = {}

	--Create configs.
	for k,_ in SortedPairsByMemberValue(jBlacklist.Configurator.Config, "Order") do

		--Check so the same key exists in the parent.cfgTable.Config table.
		if parent.cfgTable.Config[k] == nil then continue end

		--Create and position the configmodifier.
		CfgEditors[k] = CreateConfigChooser( true, k, Panel, Panel:GetParent().cfgTable,FrameWidth, PanelHeight / 4 )
		CfgEditors[k].Panel:DockMargin(0,PanelHeight * 0.05,0,0)
		CfgEditors[k].Panel:Dock(TOP)

	end

	--Return the panel.
	return Panel, CfgEditors

end

local function CreateUsergroupsPanel( parent )

	--[[-------------------------------------------------------------------------
	Create panel
	---------------------------------------------------------------------------]]

	--Create panel
	local Panel = vgui.Create( "DPanel", parent )
	Panel:SetSize(FrameWidth,PanelHeight)
	Panel:SetPos(0,HeaderHeight)

	--Create paint function for the panel.
	Panel.Paint = function( _, w, h )

		--Paint the background of the panel.
		surface.SetDrawColor(61,61,61)
		surface.DrawRect(0,0,w,h)

	end

	--[[-------------------------------------------------------------------------
	Create usergroupspanel
	---------------------------------------------------------------------------]]

	--Create usergroupsPanel.
	local usergroupsPanel = vgui.Create("DScrollPanel", Panel)
	usergroupsPanel:SetSize(FrameWidth * 0.5,PanelHeight * 0.55)
	usergroupsPanel:Center()

	--Create paint function for usergroupsPanel.
	usergroupsPanel.Paint = function( _, w, h )

		--Set drawcolor for the DPanel.
		surface.SetDrawColor(80,80,80)

		--Draw the DPanel.
		surface.DrawRect(0,0,w,h)

	end

	--Create PaintOVer function for usergroupspanel.
	usergroupsPanel.PaintOver = function( _, w, h )

		--Set the drawcolor for the outline.
		surface.SetDrawColor(31,31,31)

		--Draw outline.
		surface.DrawOutlinedRect(0,0,w,h)

	end

	--Paint scrollbar.
	jBlacklist.VGui.ColorScrollbars( usergroupsPanel.VBar )

	--[[-------------------------------------------------------------------------
	Add usergroups from config.
	---------------------------------------------------------------------------]]

	--Create table to store all panels in.
	local UsergroupPanels = {}

	--Loop through the config of usergroups-
	for k,v in pairs(parent.cfgTable.Usergroups) do

		--Create usergroupbutton.
		UsergroupPanels[k] = CreateUsergroupPanel(usergroupsPanel, k, v, function( )

			--Remove from table.
			UsergroupPanels[k] = nil

			--Set all panelpositions again.
			for _,v2 in pairs(UsergroupPanels) do
				v2:SetPos(0,0)
				v2:Dock(TOP)
			end

		end)

		--Dock the Panel to the top.
		UsergroupPanels[k]:Dock(TOP)

	end


	--[[-------------------------------------------------------------------------
	AddUserButton
	---------------------------------------------------------------------------]]

	--Create AddUserButton.
	local AddUserButton = vgui.Create("DButton",Panel)
	AddUserButton:SetSize(FrameWidth * 0.2,PanelHeight * 0.085)
	AddUserButton:SetPos(FrameWidth / 2 - AddUserButton:GetWide() / 2, PanelHeight * 0.825)
	AddUserButton:SetText("Add Usergroup")
	AddUserButton:SetTextColor(Color(255,255,255))
	AddUserButton:SetFont("jBlacklist_HUD_Small_Bold")

	--Create paint function for the AddUserButton.
	AddUserButton.Paint = function( s, w, h )

		--Set drawcolor for the button.
		surface.SetDrawColor(s:IsDown() and Color(110,110,110) or s:IsHovered() and Color(120,120,120) or Color(100,100,100))

		--Draw the button.
		surface.DrawRect(0,0,w,h)

		--Set the outline color.
		surface.SetDrawColor(31,31,31)

		--Draw the outline.
		surface.DrawOutlinedRect(0,0,w,h)

	end

	--Create DoClick function for AddUserButton.
	AddUserButton.DoClick = function( )

		--Request the name of the group.
		jBlacklist.StringRequest("What is the name of the usergroup you want to add. (CASE SENSITIVE)","",function( text )

			--Check so the user typed something.
			if text == "" then return end

			--Check so the usergroup doesn't exist.
			if parent.cfgTable.Usergroups[text] then
				jBlacklist.Notify(JBLACKLIST_NOTIFYENUM_WINDOW, "This usergroup does already exist.")
				return
			end

			--Add usergroup to table.
			parent.cfgTable.Usergroups[text] = {}

			--Add all values.
			for k,v in pairs(jBlacklist.Configurator.Usergroups) do
				parent.cfgTable.Usergroups[text][k] = v.Value
			end

			--Add Panel.
			UsergroupPanels[text] = CreateUsergroupPanel(usergroupsPanel, text, parent.cfgTable.Usergroups[text], function( )

				--Remove from table.
				UsergroupPanels[text] = nil

				--Set all panelpositions again.
				for _,v2 in pairs(UsergroupPanels) do
					v2:SetPos(0,0)
					v2:Dock(TOP)
				end

			end)

			--Dock the Panel to the top.
			UsergroupPanels[text]:Dock(TOP)

		end)

	end

	--[[-------------------------------------------------------------------------
	Other
	---------------------------------------------------------------------------]]

	--Return the panel.
	return Panel

end

-- Create a function to open the configurator.
function jBlacklist.VGui.ConfigAddon( configTbl )

	if Frame then Frame:Remove() end

	--Check so the configTbl argument was given.
	if !configTbl then return end 

	--Check if the user got the required rank or is owner.
	if !(jBlacklist.Configuration.GetUsergroupConfigValue( LocalPlayer(), "CANCONFIG" ) or LocalPlayer():SteamID64() == jBlacklist.Owner) then
		jBlacklist.Notify(JBLACKLIST_NOTIFYENUM_CHAT, jBlacklist.LoadedLanguage["INFO_NOTAUTHORIZED"])
		return
	end

	--Warn user about configurating the addon at the same time as someone else.
	jBlacklist.Notify( JBLACKLIST_NOTIFYENUM_WINDOW, "WARNING: Configurating the addon at the same time as someone else may create issues with saving of the configuration.")

	--[[-------------------------------------------------------------------------
	Creating frame
	---------------------------------------------------------------------------]]

	--Create DFrame.
	Frame = vgui.Create("DFrame")
	Frame:SetSize(FrameWidth, FrameHeight)
	Frame:Center()
	Frame:MakePopup()
	Frame:SetTitle("")
	Frame:ShowCloseButton(false)
	Frame:SetDraggable(false)

	--Save the cfgTable as a variable in the frame.
	Frame.cfgTable = configTbl

	--Creating Paint function.
	Frame.Paint = function( _, w, h )

		--Creating gray header.
		surface.SetDrawColor(36,36,36)
		surface.DrawRect(0,0,w,HeaderHeight)

		--Draw header text.
		draw.SimpleText("JBlacklist - Configuration Panel","jBlacklist_HUD_Small",w / 2,HeaderHeight * 0.2,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

		--Draw gray actions area.
		surface.SetDrawColor(61,61,61)
		surface.DrawRect(0,HeaderHeight,w,h - HeaderHeight)

		--Draw bottom.
		surface.SetDrawColor(36,36,36)
		surface.DrawRect(0,h - BottomHeight,w,BottomHeight)

		surface.SetDrawColor(28,28,28)
		surface.DrawRect(0,h - BottomHeight,w,1)

		draw.SimpleText(jBlacklist.Version .. " | " .. jBlacklist.Owner,"jBlacklist_HUD_Small",w * 0.01,h - BottomHeight / 2,Color(255,255,255),TEXT_ALIGN_LEFT,	TEXT_ALIGN_CENTER)

	end

	--[[-------------------------------------------------------------------------
	Create panels
	---------------------------------------------------------------------------]]
	local GeneralConfigPanel, GeneralCfgEditors = CreateGeneralPanel(Frame)
	local UserGroupsConfigPanel = CreateUsergroupsPanel(Frame)

	--Make UserGroupsConfigPanel invisible.
	UserGroupsConfigPanel:SetVisible(false)

	--[[-------------------------------------------------------------------------
	Adding navigation buttons.
	---------------------------------------------------------------------------]]

	local ButtonWidth, ButtonHeight = FrameWidth / 2, HeaderHeight * 0.5
	local ButtonYPos = HeaderHeight - ButtonHeight

	--Creating GeneralConfig.
	local GeneralConfig = vgui.Create("DButton",Frame)
	GeneralConfig:SetSize(ButtonWidth,ButtonHeight)
	GeneralConfig:SetPos(0,ButtonYPos + 1)
	GeneralConfig:SetText("")

	GeneralConfig.Paint = function( btn, w, h )
		--Set Draw Color
		surface.SetDrawColor(btn:IsDown() and Color(56,56,56) or btn:IsHovered() and Color(46,46,46) or Color(36,36,36))

		--Draw Button Background
		surface.DrawRect(0,0,w,h)

		--Draw button text.
		draw.SimpleText("General","jBlacklist_HUD_Small_Bold",w / 2,h * 0.8 / 2,Color(255,255,255),TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		--Draw underline
		surface.SetDrawColor(102, 165, 255)
		surface.DrawRect(0,h * 0.9,w,h * 0.1)
	end

	--Creating DoClick function for the GeneralConfig button.
	GeneralConfig.DoClick = function( )
		GeneralConfigPanel:SetVisible(true)
		UserGroupsConfigPanel:SetVisible(false)
	end

	--Creating UsergroupsConfig.
	local UsergroupsConfig = vgui.Create("DButton",Frame)
	UsergroupsConfig:SetSize(ButtonWidth,ButtonHeight)
	UsergroupsConfig:SetPos(ButtonWidth,ButtonYPos + 1)
	UsergroupsConfig:SetText("")

	UsergroupsConfig.Paint = function( btn, w, h )
		--Set Draw Color
		surface.SetDrawColor(btn:IsDown() and Color(56,56,56) or btn:IsHovered() and Color(46,46,46) or Color(36,36,36))

		--Draw Button Background
		surface.DrawRect(0,0,w,h)

		--Draw button text.
		draw.SimpleText("Usergroups","jBlacklist_HUD_Small_Bold",w / 2,h * 0.8 / 2,Color(255,255,255),TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		--Draw underline
		surface.SetDrawColor(66, 244, 143)
		surface.DrawRect(0,h * 0.9,w,h * 0.1)
	end

	--Creating DoClick function for the UsergroupsConfig button.
	UsergroupsConfig.DoClick = function( )
		GeneralConfigPanel:SetVisible(false)
		UserGroupsConfigPanel:SetVisible(true)
	end

	--[[-------------------------------------------------------------------------
	CloseButton
	---------------------------------------------------------------------------]]

	--Create a function for leaving a review.
	local function leaveReview( )

		--Check if the player is the owner.
		if LocalPlayer():SteamID64() != jBlacklist.Owner then return end

		--Check if the player have dismissed the message or already left a review.
		if tobool(LocalPlayer():GetPData( "JBlacklist_ReviewNotice", false )) == false then

			Derma_Query(  [[A huge amount of hours has been put into developing JBlacklist to what it is today.
			I would really appreciate if you left a review on Gmodstore of what you think about
			JBlacklist, as this keeps me motivated and further supports my work.

			Kind Regards, Jompe.
			Script author.]], "JBlacklist - Do you like JBlacklist?", "Leave a review",
			function (  )
				gui.OpenURL("https://www.gmodstore.com/market/view/jblacklist-v2-more-control-of-rule-breakers#add-review")
				LocalPlayer():SetPData("JBlacklist_ReviewNotice",true)
			end,"Remind me later", function(  ) end, "Never show this again",
			function(  )
				LocalPlayer():SetPData("JBlacklist_ReviewNotice",true)
			end)

		end

	end

	--Creating button.
	local CloseButton = vgui.Create("DButton",Frame)
	CloseButton:SetSize(ClosebuttonSize,ClosebuttonSize)
	CloseButton:SetPos(FrameWidth - ClosebuttonOffset * 1.5, ClosebuttonOffset - ClosebuttonSize / 2)
	CloseButton:SetText("")

	--Creating paint function for button.
	CloseButton.Paint = function( _, w, h )
		draw.SimpleText("✖","jBlacklist_HUD_Small_Bold",w / 2,h / 2,CloseButton:IsDown() and Color(150,150,150) or CloseButton:IsHovered() and Color(200,200,200) or Color(255,255,255),TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

	--Creating DoClick function for button.
	CloseButton.DoClick = function(  )

		--Create a popup that asks if you would like to save the changes made.
		local query = Derma_Query("Would you like to save the changes made?","JBlacklist - Save changes","Save Changes",function( )

			--Create a table to send.
			local cfgTable = {Config = {}, Usergroups = Frame.cfgTable.Usergroups}

			--Add values to cfgTable.Config.
			for k,v in pairs(GeneralCfgEditors) do
				cfgTable.Config[k] = v.Modifier.Value
			end

			--Send table to server
			net.Start("jBlacklist_ChangeConfig")
				net.WriteTable(cfgTable)
			net.SendToServer()

			--Close the window.
			Frame:Remove()

			--Ask the user about a review.
			leaveReview( )

		end, "Disregard Changes", function( )

			--Close the window.
			Frame:Remove()

			jBlacklist.Notify( JBLACKLIST_NOTIFYENUM_CHAT, "No changes was saved to the configuration.")

			--Ask the user about a review.
			leaveReview( )

		end, "Cancel")

		--Paint the window.
		query.Paint = function( _, w, h)
			surface.SetDrawColor(61,61,61)
			surface.DrawRect(0,0,w,h)

			surface.SetDrawColor(36,36,36)
			surface.DrawRect(0,0,w,23)

			surface.SetDrawColor(31,31,31)
			surface.DrawOutlinedRect(0,0,w,h)
		end

		--Get the buttons.
		local Buttons = query:GetChildren()[6]:GetChildren()

		for i = 1,3 do

			local curButton = Buttons[i]

			curButton:SetTextColor(Color(255,255,255))

			curButton.Paint = function( s, w, h )

				surface.SetDrawColor(s:IsDown() and Color(110,110,110) or s:IsHovered() and Color(120,120,120) or Color(100,100,100))
				surface.DrawRect(0,0,w,h)

				surface.SetDrawColor(36,36,36)
				surface.DrawOutlinedRect(0,0,w,h)

			end

		end

		--Play sound.
		surface.PlaySound("buttons/button16.wav")

	end

	--Create a actionsmenu button.
	local ActionsMenu = vgui.Create("DButton",Frame)
	ActionsMenu:SetSize(FrameWidth * 0.1,BottomHeight)
	ActionsMenu:SetPos(FrameWidth * 0.9,FrameHeight - BottomHeight)
	ActionsMenu:SetText("Actions")
	ActionsMenu:SetFont("jBlacklist_HUD_Small_Bold")
	ActionsMenu:SetTextColor(Color(255,255,255))

	--Paint the ActionsMenubutton.
	ActionsMenu.Paint = function( s, w, h )
		surface.SetDrawColor(s:IsDown() and Color(45,45,45) or s:IsHovered() and Color(35,35,35) or Color(25,25,25))
		surface.DrawRect(0,0,w,h)

		surface.SetDrawColor(0,0,0)
		surface.DrawOutlinedRect(0,0,w,h)
	end

	--Create doclick function for ActionsMenu.
	ActionsMenu.DoClick = function( )

		--Create the dermamenu.
		local Menu = DermaMenu(Frame)

		--Paint the menu.
		Menu.Paint = function( _,w,h )
			surface.SetDrawColor(55,55,55)
			surface.DrawRect(0,0,w,h)
		end

		--[[-------------------------------------------------------------------------
		ExportButton
		---------------------------------------------------------------------------]]

		--Create a exportconfig button.
		local exportConfigBtn = Menu:AddOption("Export Config",function( )

			--Create a table.
			local cfgTable = {Config = {}, Usergroups = Frame.cfgTable.Usergroups}

			--Add values to cfgTable.Config.
			for k,v in pairs(GeneralCfgEditors) do
				cfgTable.Config[k] = v.Modifier.Value
			end

			--Make the client copy the table as JSON.
			SetClipboardText(util.TableToJSON(cfgTable))

			--Tell the client the table was copied.
			jBlacklist.Notify( JBLACKLIST_NOTIFYENUM_WINDOW, "The config have been copied to clipboard as JSON. (Ctrl + V)")

		end)

		--Set textcolor and icon for exportConfigBtn.
		exportConfigBtn:SetTextColor(Color(255,255,255))
		exportConfigBtn:SetIcon("icon16/arrow_out.png")

		--[[-------------------------------------------------------------------------
		ImportButton
		---------------------------------------------------------------------------]]

		--Create a exportconfig button.
		local importConfigBtn = Menu:AddOption("Import Config",function( )

			--Create stringrequest.
			jBlacklist.StringRequest("Please paste the JSON config. (What was copied when exporting the config)","",function( text )

				--Convert JSON to table.
				local Table = util.JSONToTable(text)

				--Check so we succeeded.
				if !Table then
					jBlacklist.Notify( JBLACKLIST_NOTIFYENUM_WINDOW, "Failed to convert JSON to table. (Please try again)")
					return
				end

				--Add missing keys if missing.
				Table.Config = Table.Config or {}
				Table.Usergroups = Table.Usergroups or {}

				--Add missing configoptions.
				for k,v in pairs(jBlacklist.Configurator.Config) do

					--Check if current value is missing or if it's correct.
					if Table.Config[k] == nil or dataTypes[v.ConfigType](Table.Config[k]) == false then
						Table.Config[k] = v.Value
					end

				end

				--Add missing usergroup-configoptions.
				for k,v in pairs(Table.Usergroups) do

					--Loop through needed values.
					for k2,v2 in pairs(jBlacklist.Configurator.Usergroups) do

						--Check if value is missing.
						if v[k2] == nil or dataTypes[v2.ConfigType](v[k2]) == false then
							Table.Usergroups[k][k2] = v2.Value
						end

					end

				end

				--Close the current frame.
				Frame:Remove()

				--Open a new configwindow with the new config.
				jBlacklist.VGui.ConfigAddon( Table )

			end)

		end)

		--Set textcolor and icon for importConfigBtn.
		importConfigBtn:SetTextColor(Color(255,255,255))
		importConfigBtn:SetIcon("icon16/arrow_in.png")

		--[[-------------------------------------------------------------------------
		ResetStorageButton
		---------------------------------------------------------------------------]]

		--Create a exportconfig button.
		local ResetStorageBtn = Menu:AddOption("Reset Configuration",function( )

			--Play a sound.
			surface.PlaySound("buttons/button16.wav")

			local Numbers = {math.random(2,	15), math.random(2,	15)}

			local Question = string.Replace("Please enter what %Q is below to reset configuration.","%Q",Numbers[1] .. " + " .. Numbers[2])

			jBlacklist.StringRequest("Are you sure that you want to reset the jBlacklist configuration. (This cannot be undone)" .. "\n" .. Question,"", function( text )

				--Try to convert to number.
				text = tonumber(text)

				--Check if the user entered the correct answer.
				if text == Numbers[1] + Numbers[2] then

					--Play a sound.
					surface.PlaySound("buttons/button16.wav")

					--Create another confirm query.
					jBlacklist.DermaQuery("Confirm that you want to reset the jBlacklist configuration." .. "\n" .. jBlacklist.LoadedLanguage["LOG_WARNING"], function( )

						--Send table to server
						net.Start("jBlacklist_ChangeConfig")
							net.WriteTable({Config = {}, Usergroups = {}})
						net.SendToServer()

						--Close the Frame.
						Frame:Remove()

						--Tell the client the configuration was reset.
						jBlacklist.Notify( JBLACKLIST_NOTIFYENUM_CHAT, "Configuration have been reset to default.")

					end)

				else
					jBlacklist.Notify(JBLACKLIST_NOTIFYENUM_WINDOW, "Please enter the correct answer to reset the configuration.")
				end

			end)

		end)

		--Set textcolor and icon for ManageDataStorageBtn.
		ResetStorageBtn:SetTextColor(Color(255,255,255))
		ResetStorageBtn:SetIcon("icon16/drive_error.png")

		--[[-------------------------------------------------------------------------
		SupportButton
		---------------------------------------------------------------------------]]

		--Create a exportconfig button.
		local ScriptSupportBtn = Menu:AddOption("Script Support",function( )

			gui.OpenURL( "https://www.gmodstore.com/dashboard/support/tickets/create/4397/" )

		end)

		--Set textcolor and icon for ManageDataStorageBtn.
		ScriptSupportBtn:SetTextColor(Color(255,255,255))
		ScriptSupportBtn:SetIcon("icon16/group.png")

		--[[-------------------------------------------------------------------------
		Other stuff
		---------------------------------------------------------------------------]]

		--Get the position of the ActionsMenu.
		local AM_XPos, AM_YPos = ActionsMenu:GetPos()

		--Open the Menu.
		Menu:Open(AM_XPos + FrameWidth / 2, AM_YPos + ActionsMenu:GetTall() + FrameHeight / 2)

	end

end


--[[-------------------------------------------------------------------------
Other stuff.
---------------------------------------------------------------------------]]

--Add receiver for jBlacklist_OpenConfigurator.
net.Receive("jBlacklist_OpenConfigurator",function( )

	--Open the window with the sent tables.
	jBlacklist.VGui.ConfigAddon( {Config = net.ReadTable(), Usergroups = net.ReadTable()} )

end)

--Create consolecommand to open configurator.
concommand.Add("jblacklist_config",function(  )
	net.Start("jBlacklist_OpenConfigurator")
	net.SendToServer()
end)