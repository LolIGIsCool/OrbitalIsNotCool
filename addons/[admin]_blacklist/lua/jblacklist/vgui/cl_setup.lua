--[[-------------------------------------------------------------------------
Vars, etc.
---------------------------------------------------------------------------]]

--Creating some vars.
local FrameWidth, FrameHeight = ScrW() * 0.2, ScrH() * 0.4
local Frame

--[[-------------------------------------------------------------------------
Fonts
---------------------------------------------------------------------------]]

surface.CreateFont( "jBlacklist_SetupTool_Small_Bold", {
	font = "Roboto",
	size = ScreenScale(7),
	weight = 550,
	antialias = true,
} )

surface.CreateFont( "jBlacklist_SetupTool_Big", {
	font = "Roboto",
	size = ScreenScale(15),
	weight = 500,
	antialias = true,
} )

--[[-------------------------------------------------------------------------
Functions
---------------------------------------------------------------------------]]

--Create a function to create the StartPage.
local function CreateStartPage( parent, nextFunc )

	--Create a new DPanel.
	local DPanel = vgui.Create("DPanel", parent)
	DPanel:SetSize(parent:GetWide(),parent:GetTall())

	--Paint the DPanel.
	DPanel.Paint = function( s, w, h)

		--Make the headerText.
		draw.SimpleText("Welcome to","jBlacklist_SetupTool_Big",w / 2,h * 0.3,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		draw.SimpleText("JBlacklist V2","jBlacklist_SetupTool_Big",w / 2,h * 0.4,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

	end

	--Create a continuebutton.
	local continueBtn = vgui.Create("DButton",DPanel)
	continueBtn:SetSize(FrameWidth * 0.35,FrameHeight * 0.1)
	continueBtn:SetPos(FrameWidth / 2 - continueBtn:GetWide() / 2, FrameHeight * 0.8)
	continueBtn:SetText("Continue")
	continueBtn:SetFont("jBlacklist_SetupTool_Small_Bold")
	continueBtn:SetTextColor(Color(255,255,255))

	--Create a paint function for the button.
	continueBtn.Paint = function( s, w, h )

		--Draw a outline for the button.
		draw.RoundedBox(8,0,0,w,h,Color(0, 99, 24))

		--Draw the background for the button.
		draw.RoundedBox(8,1,1,w - 2,h - 2,s:IsHovered() and Color(58, 193, 90) or Color(38, 181, 72))

	end

	--Create a DoClick function for the continueBtn..
	continueBtn.DoClick = function( )

		nextFunc()

		DPanel:MoveTo(-FrameWidth,0,0.5,0,-1,function( )
			DPanel:Remove()
		end)

	end

	--Return the DPanel.
	return DPanel

end

--Create a function to create the Configure page.
local function CreateConfigurePage( parent, nextFunc )

	--Create a new DPanel.
	local DPanel = vgui.Create("DPanel", parent)
	DPanel:SetSize(parent:GetWide(),parent:GetTall())
	DPanel:SetPos(FrameWidth,0)

	--Make the DPanel invisible.
	DPanel.Paint = function( s, w, h )

		draw.SimpleText("In-Game Config","jBlacklist_SetupTool_Big",w / 2,h * 0.2,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

		surface.SetFont("jBlacklist_SetupTool_Big")
		surface.SetDrawColor(255,255,255)
		surface.DrawRect(w / 2 - (surface.GetTextSize("In-Game Config") + w * 0.1) / 2,h * 0.26,surface.GetTextSize("In-Game Config") + w * 0.1,h * 0.005)

		draw.SimpleText("JBlacklist have been upgraded with an","jBlacklist_SetupTool_Small_Bold",w / 2,h * 0.3,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		draw.SimpleText("ingame configurator. Click the button","jBlacklist_SetupTool_Small_Bold",w / 2,h * 0.35,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		draw.SimpleText("below to start configuring jBlacklist.","jBlacklist_SetupTool_Small_Bold",w / 2,h * 0.4,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		draw.SimpleText("You can later use the consolecommand","jBlacklist_SetupTool_Small_Bold",w / 2,h * 0.45,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		draw.SimpleText("jblacklist_config or the chatcommand","jBlacklist_SetupTool_Small_Bold",w / 2,h * 0.5,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		draw.SimpleText("!jblacklist_config to open the","jBlacklist_SetupTool_Small_Bold",w / 2,h * 0.55,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		draw.SimpleText("configurator again.","jBlacklist_SetupTool_Small_Bold",w / 2,h * 0.6,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

	end

	--Create a continuebutton.
	local continueBtn = vgui.Create("DButton",DPanel)
	continueBtn:SetSize(FrameWidth * 0.35,FrameHeight * 0.1)
	continueBtn:SetPos(FrameWidth / 2 - continueBtn:GetWide() / 2, FrameHeight * 0.8)
	continueBtn:SetText("Continue")
	continueBtn:SetFont("jBlacklist_SetupTool_Small_Bold")
	continueBtn:SetTextColor(Color(255,255,255))

	--Create a paint function for the button.
	continueBtn.Paint = function( s, w, h )

		--Draw a outline for the button.
		draw.RoundedBox(8,0,0,w,h,Color(0, 99, 24))

		--Draw the background for the button.
		draw.RoundedBox(8,1,1,w - 2,h - 2,s:IsHovered() and Color(58, 193, 90) or Color(38, 181, 72))

	end

	--Create a DoClick function for the continueBtn..
	continueBtn.DoClick = function( )

		nextFunc()

		DPanel:MoveTo(-FrameWidth,0,0.5,0,-1,function( )
			DPanel:Remove()
		end)

	end

	--Create a readmorebtn.
	local readmorebtn = vgui.Create("DButton",DPanel)
	readmorebtn:SetSize(FrameWidth * 0.35,FrameHeight * 0.1)
	readmorebtn:SetPos(FrameWidth / 2 - continueBtn:GetWide() / 2, FrameHeight * 0.675)
	readmorebtn:SetText("Configure")
	readmorebtn:SetFont("jBlacklist_SetupTool_Small_Bold")
	readmorebtn:SetTextColor(Color(255,255,255))

	--Create a paint function for the button.
	readmorebtn.Paint = function( s, w, h )

		--Draw a outline for the button.
		draw.RoundedBox(8,0,0,w,h,Color(34,77,137))

		--Draw the background for the button.
		draw.RoundedBox(8,1,1,w - 2,h - 2,s:IsHovered() and Color(63, 141, 255) or Color(32,125,255))

	end

	--Create a DoClick function for the continueBtn..
	readmorebtn.DoClick = function( )

		RunConsoleCommand("jblacklist_config")

	end

	--Return the DPanel.
	return DPanel

end

--Create a function to create the MySQL info page.
local function CreateMySQLInfoPage( parent, nextFunc )

	--Create a new DPanel.
	local DPanel = vgui.Create("DPanel", parent)
	DPanel:SetSize(parent:GetWide(),parent:GetTall())
	DPanel:SetPos(FrameWidth,0)

	--Make the DPanel invisible.
	DPanel.Paint = function( s, w, h )

		draw.SimpleText("MySQL","jBlacklist_SetupTool_Big",w / 2,h * 0.2,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

		surface.SetFont("jBlacklist_SetupTool_Big")
		surface.SetDrawColor(255,255,255)
		surface.DrawRect(w / 2 - (surface.GetTextSize("MySQL") + w * 0.1) / 2,h * 0.26,surface.GetTextSize("MySQL") + w * 0.1,h * 0.005)

		draw.SimpleText("JBlacklist V2 has support for MySQL","jBlacklist_SetupTool_Small_Bold",w / 2,h * 0.3,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		draw.SimpleText("which allow you to sync your","jBlacklist_SetupTool_Small_Bold",w / 2,h * 0.35,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		draw.SimpleText("blacklists between multiple servers.","jBlacklist_SetupTool_Small_Bold",w / 2,h * 0.4,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		draw.SimpleText("Click the button below to read more","jBlacklist_SetupTool_Small_Bold",w / 2,h * 0.45,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		draw.SimpleText("on how to setup MySQL for jBlacklist.","jBlacklist_SetupTool_Small_Bold",w / 2,h * 0.5,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

	end

	--Create a continuebutton.
	local continueBtn = vgui.Create("DButton",DPanel)
	continueBtn:SetSize(FrameWidth * 0.35,FrameHeight * 0.1)
	continueBtn:SetPos(FrameWidth / 2 - continueBtn:GetWide() / 2, FrameHeight * 0.8)
	continueBtn:SetText("Continue")
	continueBtn:SetFont("jBlacklist_SetupTool_Small_Bold")
	continueBtn:SetTextColor(Color(255,255,255))

	--Create a paint function for the button.
	continueBtn.Paint = function( s, w, h )

		--Draw a outline for the button.
		draw.RoundedBox(8,0,0,w,h,Color(0, 99, 24))

		--Draw the background for the button.
		draw.RoundedBox(8,1,1,w - 2,h - 2,s:IsHovered() and Color(58, 193, 90) or Color(38, 181, 72))

	end

	--Create a DoClick function for the continueBtn..
	continueBtn.DoClick = function( )

		nextFunc()

		DPanel:MoveTo(-FrameWidth,0,0.5,0,-1,function( )
			DPanel:Remove()
		end)

	end

	--Create a readmorebtn.
	local readmorebtn = vgui.Create("DButton",DPanel)
	readmorebtn:SetSize(FrameWidth * 0.35,FrameHeight * 0.1)
	readmorebtn:SetPos(FrameWidth / 2 - continueBtn:GetWide() / 2, FrameHeight * 0.675)
	readmorebtn:SetText("Read More")
	readmorebtn:SetFont("jBlacklist_SetupTool_Small_Bold")
	readmorebtn:SetTextColor(Color(255,255,255))

	--Create a paint function for the button.
	readmorebtn.Paint = function( s, w, h )

		--Draw a outline for the button.
		draw.RoundedBox(8,0,0,w,h,Color(34,77,137))

		--Draw the background for the button.
		draw.RoundedBox(8,1,1,w - 2,h - 2,s:IsHovered() and Color(63, 141, 255) or Color(32,125,255))

	end

	--Create a DoClick function for the continueBtn..
	readmorebtn.DoClick = function( )

		gui.OpenURL("https://jompe.phy.sx/jblacklist_docs/installation.html#mysql-section")

	end

	--Return the DPanel.
	return DPanel

end

--Create a function to create the StartPage.
local function CreateDataStoragePage( parent, nextFunc )

	--Create a new DPanel.
	local DPanel = vgui.Create("DPanel", parent)
	DPanel:SetSize(parent:GetWide(),parent:GetTall())
	DPanel:SetPos(FrameWidth,0)

	--Make the DPanel invisible.
	DPanel.Paint = function( s, w, h)

		draw.SimpleText("Datastorage Info","jBlacklist_SetupTool_Big",w / 2,h * 0.2,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

		surface.SetFont("jBlacklist_SetupTool_Big")
		surface.SetDrawColor(255,255,255)
		surface.DrawRect(w / 2 - (surface.GetTextSize("Datastorage Info") + w * 0.1) / 2,h * 0.26,surface.GetTextSize("Datastorage Info") + w * 0.1,h * 0.005)

		draw.SimpleText("JBlacklist V2 has an upgraded storage","jBlacklist_SetupTool_Small_Bold",w / 2,h * 0.3,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		draw.SimpleText("system and therefore requires you to","jBlacklist_SetupTool_Small_Bold",w / 2,h * 0.35,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		draw.SimpleText("convert all your old playerdata if you","jBlacklist_SetupTool_Small_Bold",w / 2,h * 0.4,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		draw.SimpleText("want to keep it with the V2 update.","jBlacklist_SetupTool_Small_Bold",w / 2,h * 0.45,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		draw.SimpleText("Click the button below to read more","jBlacklist_SetupTool_Small_Bold",w / 2,h * 0.5,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		draw.SimpleText("on how to convert your old savedata.","jBlacklist_SetupTool_Small_Bold",w / 2,h * 0.55,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

	end

	--Create a continuebutton.
	local continueBtn = vgui.Create("DButton",DPanel)
	continueBtn:SetSize(FrameWidth * 0.35,FrameHeight * 0.1)
	continueBtn:SetPos(FrameWidth / 2 - continueBtn:GetWide() / 2, FrameHeight * 0.8)
	continueBtn:SetText("Continue")
	continueBtn:SetFont("jBlacklist_SetupTool_Small_Bold")
	continueBtn:SetTextColor(Color(255,255,255))

	--Create a paint function for the button.
	continueBtn.Paint = function( s, w, h )

		--Draw a outline for the button.
		draw.RoundedBox(8,0,0,w,h,Color(0, 99, 24))

		--Draw the background for the button.
		draw.RoundedBox(8,1,1,w - 2,h - 2,s:IsHovered() and Color(58, 193, 90) or Color(38, 181, 72))

	end

	--Create a DoClick function for the continueBtn..
	continueBtn.DoClick = function( )

		nextFunc()

		DPanel:MoveTo(-FrameWidth,0,0.5,0,-1,function( )
			DPanel:Remove()
		end)

	end

	--Create a readmorebtn.
	local readmorebtn = vgui.Create("DButton",DPanel)
	readmorebtn:SetSize(FrameWidth * 0.35,FrameHeight * 0.1)
	readmorebtn:SetPos(FrameWidth / 2 - continueBtn:GetWide() / 2, FrameHeight * 0.675)
	readmorebtn:SetText("Read More")
	readmorebtn:SetFont("jBlacklist_SetupTool_Small_Bold")
	readmorebtn:SetTextColor(Color(255,255,255))

	--Create a paint function for the button.
	readmorebtn.Paint = function( s, w, h )

		--Draw a outline for the button.
		draw.RoundedBox(8,0,0,w,h,Color(34,77,137))

		--Draw the background for the button.
		draw.RoundedBox(8,1,1,w - 2,h - 2,s:IsHovered() and Color(63, 141, 255) or Color(32,125,255))

	end

	--Create a DoClick function for the continueBtn..
	readmorebtn.DoClick = function( )

		gui.OpenURL("http://www.jompe.phy.sx/jblacklist_docs/installation.html#convertplayerdata")

	end

	--Return the DPanel.
	return DPanel

end

--Create a function to create the StartPage.
local function CreateChangelogsPage( parent, nextFunc )

	--Create a new DPanel.
	local DPanel = vgui.Create("DPanel", parent)
	DPanel:SetSize(parent:GetWide(),parent:GetTall())
	DPanel:SetPos(FrameWidth,0)

	--Make the DPanel invisible.
	DPanel.Paint = function( s, w, h)

		draw.SimpleText("Changelogs","jBlacklist_SetupTool_Big",w / 2,h * 0.2,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

		surface.SetFont("jBlacklist_SetupTool_Big")
		surface.SetDrawColor(255,255,255)
		surface.DrawRect(w / 2 - (surface.GetTextSize("Changelogs") + w * 0.1) / 2,h * 0.26,surface.GetTextSize("Changelogs") + w * 0.1,h * 0.005)

		draw.SimpleText("There is also a lot of other new","jBlacklist_SetupTool_Small_Bold",w / 2,h * 0.3,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		draw.SimpleText("exciting features to discover.","jBlacklist_SetupTool_Small_Bold",w / 2,h * 0.35,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		draw.SimpleText("Click the button below to see","jBlacklist_SetupTool_Small_Bold",w / 2,h * 0.4,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		draw.SimpleText("what else is new.","jBlacklist_SetupTool_Small_Bold",w / 2,h * 0.45,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

	end

	--Create a continuebutton.
	local continueBtn = vgui.Create("DButton",DPanel)
	continueBtn:SetSize(FrameWidth * 0.35,FrameHeight * 0.1)
	continueBtn:SetPos(FrameWidth / 2 - continueBtn:GetWide() / 2, FrameHeight * 0.8)
	continueBtn:SetText("Continue")
	continueBtn:SetFont("jBlacklist_SetupTool_Small_Bold")
	continueBtn:SetTextColor(Color(255,255,255))

	--Create a paint function for the button.
	continueBtn.Paint = function( s, w, h )

		--Draw a outline for the button.
		draw.RoundedBox(8,0,0,w,h,Color(0, 99, 24))

		--Draw the background for the button.
		draw.RoundedBox(8,1,1,w - 2,h - 2,s:IsHovered() and Color(58, 193, 90) or Color(38, 181, 72))

	end

	--Create a DoClick function for the continueBtn..
	continueBtn.DoClick = function( )

		nextFunc()

		DPanel:MoveTo(-FrameWidth,0,0.5,0,-1,function( )
			DPanel:Remove()
		end)

	end

	--Create a readmorebtn.
	local readmorebtn = vgui.Create("DButton",DPanel)
	readmorebtn:SetSize(FrameWidth * 0.35,FrameHeight * 0.1)
	readmorebtn:SetPos(FrameWidth / 2 - continueBtn:GetWide() / 2, FrameHeight * 0.675)
	readmorebtn:SetText("Read More")
	readmorebtn:SetFont("jBlacklist_SetupTool_Small_Bold")
	readmorebtn:SetTextColor(Color(255,255,255))

	--Create a paint function for the button.
	readmorebtn.Paint = function( s, w, h )

		--Draw a outline for the button.
		draw.RoundedBox(8,0,0,w,h,Color(34,77,137))

		--Draw the background for the button.
		draw.RoundedBox(8,1,1,w - 2,h - 2,s:IsHovered() and Color(63, 141, 255) or Color(32,125,255))

	end

	--Create a DoClick function for the continueBtn..
	readmorebtn.DoClick = function( )

		gui.OpenURL("https://www.gmodstore.com/scripts/view/4397/versions")

	end

	--Return the DPanel.
	return DPanel

end

--Create a function to create the StartPage.
local function CreateFinishPage( parent )

	--Create a new DPanel.
	local DPanel = vgui.Create("DPanel", parent)
	DPanel:SetSize(parent:GetWide(),parent:GetTall())
	DPanel:SetPos(FrameWidth,0)

	--Make the DPanel invisible.
	DPanel.Paint = function( s, w, h)

		draw.SimpleText("Thank You","jBlacklist_SetupTool_Big",w / 2,h * 0.2,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

		surface.SetFont("jBlacklist_SetupTool_Big")
		surface.SetDrawColor(255,255,255)
		surface.DrawRect(w / 2 - (surface.GetTextSize("Thank You") + w * 0.1) / 2,h * 0.26,surface.GetTextSize("Thank You") + w * 0.1,h * 0.005)

		draw.SimpleText("Thank you for purchasing jBlacklist.","jBlacklist_SetupTool_Small_Bold",w / 2,h * 0.3,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		draw.SimpleText("Click the button below to","jBlacklist_SetupTool_Small_Bold",w / 2,h * 0.4,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		draw.SimpleText("start using jBlacklist V2.","jBlacklist_SetupTool_Small_Bold",w / 2,h * 0.45,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

	end

	--Create a continuebutton.
	local continueBtn = vgui.Create("DButton",DPanel)
	continueBtn:SetSize(FrameWidth * 0.35,FrameHeight * 0.1)
	continueBtn:SetPos(FrameWidth / 2 - continueBtn:GetWide() / 2, FrameHeight * 0.8)
	continueBtn:SetText("Finish")
	continueBtn:SetFont("jBlacklist_SetupTool_Small_Bold")
	continueBtn:SetTextColor(Color(255,255,255))

	--Create a paint function for the button.
	continueBtn.Paint = function( s, w, h )

		--Draw a outline for the button.
		draw.RoundedBox(8,0,0,w,h,Color(0, 99, 24))

		--Draw the background for the button.
		draw.RoundedBox(8,1,1,w - 2,h - 2,s:IsHovered() and Color(58, 193, 90) or Color(38, 181, 72))

	end

	--Create a DoClick function for the continueBtn..
	continueBtn.DoClick = function( )

		parent:AlphaTo(0,0.5,0,function(  )
			parent:Remove()
		end)

	end

	--Return the DPanel.
	return DPanel

end

--Create a function to open the setuptool.
function jBlacklist.VGui.OpenSetup(  )

	--Check so it's the owner opening the setup.
	if LocalPlayer():SteamID64() != jBlacklist.Owner then
		jBlacklist.Notify(JBLACKLIST_NOTIFYENUM_CHAT, jBlacklist.LoadedLanguage["INFO_NOTAUTHORIZED"])
		return
	end

	--Check if frame is already open.
	if Frame then Frame:Remove() end

	--Create a new DFrame.
	Frame = vgui.Create("DFrame")
	Frame:SetSize(FrameWidth,FrameHeight)
	Frame:Center()
	Frame:MakePopup()
	Frame:SetDraggable(false)
	Frame:SetTitle("")
	Frame:ShowCloseButton(false)

	--Create a paintfunction for the Frame.
	Frame.Paint = function( s, w, h )

		--Draw the border of the frame.
		draw.RoundedBox(8,0,0,w,h,Color(31,31,31))

		--Draw the background of the frame.
		draw.RoundedBox(8,1,1,w - 2,h - 2,Color(61,61,61))

	end

	--Create the pages.
	local FinishPage = CreateFinishPage(Frame)

	local ChangelogsPage = CreateChangelogsPage(Frame, function(  )
		FinishPage:MoveTo(0,0,0.5)
	end)

	local DataStrPage = CreateDataStoragePage(Frame, function(  )
		ChangelogsPage:MoveTo(0,0,0.5)
	end)

	local MySQLInfoPage = CreateMySQLInfoPage(Frame, function(  )
		DataStrPage:MoveTo(0,0,0.5)
	end)

	local ConfigPage = CreateConfigurePage(Frame, function(  )
		MySQLInfoPage:MoveTo(0,0,0.5)
	end)

	local StartPage = CreateStartPage(Frame, function(  )
		ConfigPage:MoveTo(0,0,0.5)
	end)

end

--[[-------------------------------------------------------------------------
Misc
---------------------------------------------------------------------------]]

--Add consolecommand
concommand.Add("jblacklist_setup",jBlacklist.VGui.OpenSetup)