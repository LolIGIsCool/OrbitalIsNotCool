--[[-------------------------------------------------------------------------
Create the blacklist.
---------------------------------------------------------------------------]]

--Create a new blacklist table to work in.
local BLACKLIST = {}

--Define some basic vars for the blacklist.
BLACKLIST.Name = "Voice Chat"
BLACKLIST.Enabled = true

--Register the blacklist.
jBlacklist.RegisterBL(BLACKLIST)

--[[-------------------------------------------------------------------------
Non-optional functions.
---------------------------------------------------------------------------]]

--Create a function to get the blacklist description.
BLACKLIST.GetDescription = function(  )
	return jBlacklist.LoadedLanguage["BLACKLISTDESC_VOICECHAT"]
end

--Create a function to get the blacklist's blacklisted-phrase.
BLACKLIST.GetBlacklistedPhrase = function()
	return jBlacklist.LoadedLanguage["BLACKLIST_VOICECHAT"]
end

--[[-------------------------------------------------------------------------
Optional functions.
---------------------------------------------------------------------------]]

BLACKLIST.OnIssued = function( ply )

	net.Start("jBlacklist_VoiceChatBlacklist_UpdateStatus")
		net.WriteBool(true)
	net.Send(ply)

end

BLACKLIST.OnExpire = function( ply )

	net.Start("jBlacklist_VoiceChatBlacklist_UpdateStatus")
		net.WriteBool(false)
	net.Send(ply)

end

--[[-------------------------------------------------------------------------
Hooks & Misc
---------------------------------------------------------------------------]]

--Add PlayerSpawnedProp hook to avoid propspawning.
jBlacklist.AddHook("PlayerCanHearPlayersVoice","jBlacklist_VoiceBlacklist",function( _, ply )

	--Add this to prevent this action if the player's blacklists havent loaded in yet.
	if !ply.jBlacklist then return false end

	if ply:IsBlacklisted(BLACKLIST) then
		return false
	end

end)

--Check if we are running clientside.
if CLIENT then

	--Create a var that keeps track if we are blacklisted or not.
	local blacklisted = false

	--Add a receiver for jBlacklist_VoiceChatBlacklist_UpdateStatus.
	net.Receive("jBlacklist_VoiceChatBlacklist_UpdateStatus",function(  )
		blacklisted = net.ReadBool() or false
	end)

	--Check for the player starting to talk.
	hook.Add("PlayerStartVoice","jBlacklist_VoiceBlacklist_PlayerStartVoice",function( ply )

		--Check if the player is the local player and if the player is blacklisted.
		if ply == LocalPlayer() and blacklisted then
			net.Start("jBlacklist_VoiceBlacklist_ShowPopup")
			net.SendToServer()
		end

	end)

else

	--Pool network message.
	util.AddNetworkString("jBlacklist_VoiceChatBlacklist_UpdateStatus")
	util.AddNetworkString("jBlacklist_VoiceBlacklist_ShowPopup")

	--Add a receiver for jBlacklist_VoiceBlacklist_ShowPopup.
	net.Receive("jBlacklist_VoiceBlacklist_ShowPopup",function( _, ply )

		--Check if we got a cooldown.
		if ply.jBlacklist.NetCooldown > CurTime() then return end

		--Set a cooldown for sending a new network message.
		ply.jBlacklist.NetCooldown = CurTime() + 0.5

		--Check so the player is blacklisted.
		if !ply:IsBlacklisted(BLACKLIST) then return end

		--Show the blacklist popup.
		jBlacklist.ShowBlacklistedPopup( ply, BLACKLIST )

	end)

	--Check for a player blacklist change.
	hook.Add("jBlacklist_PlayerLoaded","jBlacklist_VoiceBlacklist_PlayerLoaded",function( ply )

		net.Start("jBlacklist_VoiceChatBlacklist_UpdateStatus")
			net.WriteBool(ply:IsBlacklisted(BLACKLIST))
		net.Send(ply)

	end)

end