require 'texture'

cvar.Register 'ChatboxSize'

cvar.Register 'chat_sounds'
	:SetDefault(true, true)
	:AddMetadata('Catagory', 'Chat')
	:AddMetadata('Menu', 'Play chat sounds')

cvar.Register 'PMNotify'
	:SetDefault(false)
	:AddMetadata('Catagory', 'Chat')
	:AddMetadata('Menu', 'Play PM sounds')

cvar.Register 'DisableEmotes'
	:SetDefault(false)
	:AddMetadata('Catagory', 'Chat')
	:AddMetadata('Menu', 'Disable emotes')

chat.OldAddText = chat.OldAddText or chat.AddText
function chat.AddText(...)
	if IsValid(LocalPlayer()) then
		CHATBOX = CHATBOX or os.CreateChatBox()
		CHATBOX:AddMessage({...})
	end
	return chat.OldAddText(...)
end

function chat.EnableEmotes(enable)
	if IsValid(CHATBOX) then
		CHATBOX.DoEmotes = enable
	end
end

function chat.SetTab(tab, responseCommand)
	if IsValid(CHATBOX) then
		CHATBOX.PendingChatTab = tab
		CHATBOX.ChatResponseCommand = responseCommand
	end
end

function chat.AddTabbedText(tab, ...)
	if IsValid(LocalPlayer()) then
		CHATBOX = CHATBOX or os.CreateChatBox()
		CHATBOX:AddTabbedMessage(tab, {...})
	end
	return chat.OldAddText(...)
end

function chat.GetChatBoxSize(setup)
	if (setup or !IsValid(CHATBOX)) then
		local saved = cvar.GetValue('ChatboxSize')
		if (!saved) then
			return ScrW() * .4, ScrH() * .3
		else
			return math.Clamp(saved[1], 265, ScrW() - 20), math.Clamp(saved[2], 155, ScrH() - 20)
		end
	end

	return CHATBOX:GetSize()
end

function chat.GetChatBoxPos(w, h)
	local _, _h = chat.GetChatBoxSize()
	h = h or _h

	return chat.GetChatBoxLeftBound(), chat.GetChatBoxBottomBound() - h
end

function chat.GetChatBoxLeftBound()
	return 10
end

function chat.GetChatBoxBottomBound()
	return ScrH() - 10
end

function chat.IsOpen()
	return IsValid(CHATBOX) and CHATBOX._Open
end

function PLAYER:ChatPrint(...)
	chat.AddText(...)
end

hook.Add('HUDShouldDraw', 'HideDefaultChat', function(name)
	if (name == 'CHudChat') then
		return false
	end
end)

hook.Add('PlayerBindPress', 'OpenChatbox', function(ply, bind, pressed)
	if (!pressed) then return end

	CHATBOX = CHATBOX or os.CreateChatBox()
	CHATBOX.ShowEmotes = true

	if (string.find(bind, 'messagemode2')) then
			CHATBOX:Open(true)
		return true
	elseif (string.find(bind, 'messagemode')) then
		CHATBOX:Open(false)
		return true
	end
end)

local function ToggleChat(b)
	net.Start('os.ToggleChat')
		net.WriteBool(b)
	net.SendToServer()
end
hook.Add('StartChat', 'os.chat.StartChat', function() ToggleChat(true) end)
hook.Add('FinishChat', 'os.chat.FinishChat', function() ToggleChat(false) end)


hook.Add('ChatText', function(plInd, plName, Text, Type)
	if (Type == 'joinleave') then return true end
end)

