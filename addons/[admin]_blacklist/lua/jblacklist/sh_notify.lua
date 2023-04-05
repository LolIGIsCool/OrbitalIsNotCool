if SERVER then
	--Pool network messages.
	util.AddNetworkString("jBlacklist_Notify")
end

--Create ENUMS.
JBLACKLIST_NOTIFYENUM_WINDOW = 1
JBLACKLIST_NOTIFYENUM_POPUP = 2
JBLACKLIST_NOTIFYENUM_CHAT = 3

--Create table of what configuration-value the enums are connected to.
local Enum_ConfigValues = {
	[JBLACKLIST_NOTIFYENUM_WINDOW] = "PLAY_NOTIFICATION_SOUND_WINDOW",
	[JBLACKLIST_NOTIFYENUM_POPUP] = "PLAY_NOTIFICATION_SOUND_POPUP",
	[JBLACKLIST_NOTIFYENUM_CHAT] = "PLAY_NOTIFICATION_SOUND_CHAT"
}

--Create a function to create a notification.
function jBlacklist.Notify( Type, Message, ply, silent)

	silent = silent or false

	--Check if we are running serverside or clientside.
	if SERVER then

		--Start to send a network message to the client.
		net.Start("jBlacklist_Notify")
			net.WriteInt(Type,3)
			net.WriteString(Message)
			net.WriteBool(silent)

		--Check who we should send it to.
		if ply then net.Send(ply) else net.Broadcast() end

	else

		--Show the choosen notifcation type.
		if Type == JBLACKLIST_NOTIFYENUM_WINDOW then

			--Create a new derma_message-window.
			local Window = Derma_Message(Message,"JBlacklist - " .. jBlacklist.LoadedLanguage["TITLE_NOTIFICATION"],jBlacklist.LoadedLanguage["OK"])

			--Paint the window.
			Window.Paint = function( _, w, h)
				surface.SetDrawColor(61,61,61)
				surface.DrawRect(0,0,w,h)

				surface.SetDrawColor(36,36,36)
				surface.DrawRect(0,0,w,23)

				surface.SetDrawColor(31,31,31)
				surface.DrawOutlinedRect(0,0,w,h)
			end

			--Get the OK_Button of the Window.
			local OK_Button = Window:GetChildren()[6]:GetChildren()[1]

			--Paint the button.
			OK_Button.Paint = function( s, w, h)
				surface.SetDrawColor(s:IsDown() and Color(110,110,110) or s:IsHovered() and Color(120,120,120) or Color(100,100,100))
				surface.DrawRect(0,0,w,h)

				surface.SetDrawColor(36,36,36)
				surface.DrawOutlinedRect(0,0,w,h)
			end

			--Change the textcolor of the button.
			OK_Button:SetTextColor(Color(255,255,255))

			--Print the notification to the console as well.
			jBlacklist.ConNotify("NOTIFICATION", Message)

		elseif Type == JBLACKLIST_NOTIFYENUM_POPUP then

			--Add a notification in the lower right.
			notification.AddLegacy(Message,NOTIFY_ERROR,10)
			jBlacklist.ConNotify("NOTIFICATION", Message)

		elseif Type == JBLACKLIST_NOTIFYENUM_CHAT then

			--Print notification to chat.
			chat.AddText(Color(28, 117, 219), "[JBlacklist] ", silent == true and Color(50,50,50), silent == true and ("(" .. jBlacklist.LoadedLanguage["ISSUE_SILENT"] .. ") "), Color(255,255,255), Message)

		end

		--Check if a sound should be played.
		if jBlacklist.Configuration.GetConfigValue( Enum_ConfigValues[Type] ) == false then return end

		--Play a sound.
		surface.PlaySound("buttons/button16.wav")

	end

end

--Create function to create a console notification.
function jBlacklist.ConNotify( Title, Message )

	--Print notification to console.
	print("[JBLACKLIST] : [" .. Title .. "] : " .. Message)

end

--Check if we are running clientside.
if CLIENT then

	--Create a function to create a confirmwindow.
	function jBlacklist.DermaQuery( subtitle, confirmFunc, cancelFunc)

		--Make sure we got all functions.
		confirmFunc = confirmFunc or function( ) end
		cancelFunc = cancelFunc or function( ) end

		--Create a Derma_Query-Window.
		local Window = Derma_Query(subtitle,"JBlacklist - " .. jBlacklist.LoadedLanguage["TITLE_QUERY"],jBlacklist.LoadedLanguage["CONFIRM"],confirmFunc, jBlacklist.LoadedLanguage["CANCEL"] ,cancelFunc)

		--Paint the window.
		Window.Paint = function( _, w, h)
			surface.SetDrawColor(61,61,61)
			surface.DrawRect(0,0,w,h)

			surface.SetDrawColor(36,36,36)
			surface.DrawRect(0,0,w,23)

			surface.SetDrawColor(31,31,31)
			surface.DrawOutlinedRect(0,0,w,h)
		end

		--Get the buttons.
		local Buttons = Window:GetChildren()[6]:GetChildren()

		for i = 1,2 do

			local curButton = Buttons[i]

			curButton:SetTextColor(Color(255,255,255))

			curButton.Paint = function( s, w, h )

				surface.SetDrawColor(s:IsDown() and Color(110,110,110) or s:IsHovered() and Color(120,120,120) or Color(100,100,100))
				surface.DrawRect(0,0,w,h)

				surface.SetDrawColor(36,36,36)
				surface.DrawOutlinedRect(0,0,w,h)

			end

		end

	end

	--Create a function to create a stringrequest.
	function jBlacklist.StringRequest( subtitle, default, confirmFunc, cancelFunc)

		--Make sure we got all functions.
		confirmFunc = confirmFunc or function( ) end
		cancelFunc = cancelFunc or function( ) end


		--Create a Derma_StringRequest-Window.
		local Window = Derma_StringRequest("JBlacklist - " .. jBlacklist.LoadedLanguage["TITLE_STRINGREQUEST"],subtitle,default,confirmFunc,cancelFunc,jBlacklist.LoadedLanguage["CONFIRM"], jBlacklist.LoadedLanguage["CANCEL"])

		--Paint the window.
		Window.Paint = function( _, w, h)
			surface.SetDrawColor(61,61,61)
			surface.DrawRect(0,0,w,h)

			surface.SetDrawColor(36,36,36)
			surface.DrawRect(0,0,w,23)

			surface.SetDrawColor(31,31,31)
			surface.DrawOutlinedRect(0,0,w,h)
		end

		--Get the window's children.
		local WindowChildren = Window:GetChildren()

		--Paint the DTextEntry.
		WindowChildren[5]:GetChildren()[2].Paint = function( s, w, h)

			surface.SetDrawColor(Color(100,100,100))
			surface.DrawRect(0,0,w,h)

			surface.SetDrawColor(36,36,36)
			surface.DrawOutlinedRect(0,0,w,h)
			s:DrawTextEntryText(Color(255,255,255),Color(158, 217, 255),Color(0,0,0))

		end

		--Get the buttons.
		local Buttons = WindowChildren[6]:GetChildren()

		for i = 1,2 do

			local curButton = Buttons[i]

			curButton:SetTextColor(Color(255,255,255))

			curButton.Paint = function( s, w, h )

				surface.SetDrawColor(s:IsDown() and Color(110,110,110) or s:IsHovered() and Color(120,120,120) or Color(100,100,100))
				surface.DrawRect(0,0,w,h)

				surface.SetDrawColor(36,36,36)
				surface.DrawOutlinedRect(0,0,w,h)

			end

		end

		--Return the Window.
		return Window

	end

	--Create a receiver for jBlacklist_Notify.
	net.Receive("jBlacklist_Notify",function(  )

		local type = net.ReadInt(3)
		local msg = net.ReadString()
		local silent = net.ReadBool()

		jBlacklist.Notify( type, msg, nil, silent)
	end)

end