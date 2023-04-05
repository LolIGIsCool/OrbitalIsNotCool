--Create a hook where we wait for the gamemode to initialize
hook.Add("Initialize","jBlacklist_Cinema_AwaitGamemode",function(  )

	--Check if we are running the cinema gamemode.
	if engine.ActiveGamemode() == "cinema" then

		--[[-------------------------------------------------------------------------
		Create the blacklist.
		---------------------------------------------------------------------------]]

		--Create a new blacklist table to work in.
		local BLACKLIST = {}

		--Define some basic vars for the blacklist.
		BLACKLIST.Name = "[Cinema] Request Video"
		BLACKLIST.Enabled = true

		--Register the blacklist.
		jBlacklist.RegisterBL(BLACKLIST)

		--[[-------------------------------------------------------------------------
		Non-optional functions.
		---------------------------------------------------------------------------]]

		--Create a function to get the blacklist description.
		BLACKLIST.GetDescription = function(  )
			return jBlacklist.LoadedLanguage["BLACKLISTDESC_CINEMA_REQUESTVIDEO"]
		end

		--Create a function to get the blacklist's blacklisted-phrase.
		BLACKLIST.GetBlacklistedPhrase = function()
			return jBlacklist.LoadedLanguage["BLACKLIST_CINEMA_REQUESTVIDEO"]
		end

		--[[-------------------------------------------------------------------------
		Hooks
		---------------------------------------------------------------------------]]

		jBlacklist.AddHook("PreVideoQueued","jBlacklist_Cinema_RequestVideoBlacklist",function( Video )

			--Get the player.
			local ply = Video:GetOwner()

			--Make sure the player is valid.
			if !IsValid(ply) then return end

			--Add this to prevent this action if the player's blacklists havent loaded in yet.
			if !ply.jBlacklist then return false end

			--Check if the player is blacklisted.
			if ply:IsBlacklisted(BLACKLIST) then

				jBlacklist.ShowBlacklistedPopup( ply, BLACKLIST )

				return false

			end

		end)

	end

end)