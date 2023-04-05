--[[-------------------------------------------------------------------------
Create the blacklist.
---------------------------------------------------------------------------]]

--Create a new blacklist table to work in.
local BLACKLIST = {}

--Define some basic vars for the blacklist.
BLACKLIST.Name = "NLR"
BLACKLIST.Enabled = true

--Register the blacklist.
jBlacklist.RegisterBL(BLACKLIST)

--[[-------------------------------------------------------------------------
Non-optional functions.
---------------------------------------------------------------------------]]

--Create a function to get the blacklist description.
BLACKLIST.GetDescription = function(  )
	return jBlacklist.LoadedLanguage["BLACKLISTDESC_NLR"]
end

--Create a function to get the blacklist's blacklisted-phrase.
BLACKLIST.GetBlacklistedPhrase = function()
	return false
end

--[[-------------------------------------------------------------------------
Hooks
---------------------------------------------------------------------------]]

--jBlacklist.AddHook will only be called on the server. (It works the same)
jBlacklist.AddHook("PlayerDeath","jBlacklist_NLRBlacklist",function( ply )

	if ply:IsBlacklisted(BLACKLIST) then

		--Add variable for when the player can respawn again.
		ply.jBlacklist.NLRTimer = CurTime() + jBlacklist.BLConfig.RespawnTimer * 60

		--Create NLRWarningMessage.
		local NLRWarningMessage = string.Replace(jBlacklist.LoadedLanguage["BLACKLIST_NLR"],"%T",jBlacklist.BLConfig.RespawnTimer)

		jBlacklist.ShowBlacklistedPopup( ply, BLACKLIST )
		jBlacklist.Notify(JBLACKLIST_NOTIFYENUM_WINDOW, NLRWarningMessage, ply)

		--Check if we should tell the player.
		if jBlacklist.BLConfig.DrawNLRTime then
			net.Start("jBlacklist_NLRBlacklist_UpdatePlayer")
				net.WriteBool(true)
			net.Send(ply)
		end

	elseif jBlacklist.BLConfig.DrawNLRTime then

		--Tell the client it doesn't have an NLR blacklist.
		net.Start("jBlacklist_NLRBlacklist_UpdatePlayer")
			net.WriteBool(false)
		net.Send(ply)

	end

end)

--Stop the player from respawning.
jBlacklist.AddHook("PlayerDeathThink","jBlacklist_NLRBlacklist_StopRespawn",function( ply )

	if ply:IsBlacklisted(BLACKLIST) && ply.jBlacklist.NLRTimer > CurTime() then
		return false
	end

end)

--Check if we are running clientside and if we should draw the time on the player's screen.
if CLIENT and jBlacklist.BLConfig.DrawNLRTime then

	timer.Simple(1,function(  )

		--[[-------------------------------------------------------------------------
		Set things up
		---------------------------------------------------------------------------]]

		--Get the player.
		local ply

		--Set some variables.
		local timeLeft = 0
		local blacklisted = false

		--Set the game to listen for entity_killed.
		gameevent.Listen("entity_killed")

		--[[-------------------------------------------------------------------------
		Add hooks.
		---------------------------------------------------------------------------]]

		--Add a hook for entity_killed.
		hook.Add("entity_killed","jBlacklist_NLRBlacklist_DetectDeath",function( data )

			local ent = Entity(data.entindex_killed)

			if IsValid(ent) and ent == ply then
				timeLeft = CurTime() + jBlacklist.BLConfig.RespawnTimer * 60
			end

		end)

		--Draw on the player's screen how long the player has left before respawning.
		hook.Add("HUDPaint","jBlacklist_NLRBlacklist_DrawTime",function(  )

			--Make sure to set ply to LocalPlayer
			ply = ply or LocalPlayer()

			--Check if the player is dead.
			if !ply:Alive() and blacklisted and timeLeft > CurTime() then

				local ExpireMessage = jBlacklist.LoadedLanguage["BLACKLIST_NLR_RESPAWN"]
				ExpireMessage = string.Replace(ExpireMessage,"%T", jBlacklist.FormatBlacklistTime(timeLeft - CurTime()))

				draw.SimpleText(ExpireMessage,"jBlacklist_Stats_Small",ScrW() / 2,ScrH() * 0.75,Color(255, 91, 91),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

			end

		end)

		--Add a receiver for jBlacklist_NLRBlacklist_UpdatePlayer.
		net.Receive("jBlacklist_NLRBlacklist_UpdatePlayer",function(  )
			blacklisted = net.ReadBool()
		end)

	end)

elseif SERVER and jBlacklist.BLConfig.DrawNLRTime then

	--Pool network message.
	util.AddNetworkString("jBlacklist_NLRBlacklist_UpdatePlayer")

end