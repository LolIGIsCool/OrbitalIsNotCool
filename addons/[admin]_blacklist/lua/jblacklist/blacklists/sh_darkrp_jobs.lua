--Function to load the module.
local function loadModule(  )

	local Jobs = {}

	for k,v in pairs(RPExtraTeams) do

		--[[-------------------------------------------------------------------------
		Create the blacklist.
		---------------------------------------------------------------------------]]

		--Create a new blacklist table to work in.
		local BLACKLIST = {}

		--Define some basic vars for the blacklist.
		BLACKLIST.Name = "[TEAM] " .. v.name
		BLACKLIST.Enabled = true

		--Register the blacklist.
		jBlacklist.RegisterBL(BLACKLIST)
		Jobs[k] = BLACKLIST

		--[[-------------------------------------------------------------------------
		Non-optional functions.
		---------------------------------------------------------------------------]]

		--Create a function to get the blacklist description.
		BLACKLIST.GetDescription = function(  )
			return jBlacklist.LoadedLanguage["BLACKLISTDESC_DarkRPJobs"]
		end

		--Create a function to get the blacklist's blacklisted-phrase.
		BLACKLIST.GetBlacklistedPhrase = function()
			return jBlacklist.LoadedLanguage["BLACKLIST_TEAM"]
		end

		--[[-------------------------------------------------------------------------
		Optional functions.
		---------------------------------------------------------------------------]]

		--Create onissued function.
		BLACKLIST.OnIssued = function( ply )
			if ply:Team() == k then
				ply:changeTeam(GAMEMODE.DefaultTeam, true)
			end
		end

	end

	--[[-------------------------------------------------------------------------
	Hooks
	---------------------------------------------------------------------------]]

	--Stop the player from respawning.
	jBlacklist.AddHook("playerCanChangeTeam","jBlacklist_TEAMBLACKLIST",function( ply, index )

		--Add this to prevent this action if the player's blacklists havent loaded in yet.
		if !ply.jBlacklist then return false end

		if !Jobs[index] then return end

		if ply:IsBlacklisted(Jobs[index]) then

			jBlacklist.ShowBlacklistedPopup( ply, Jobs[index] )

			return false

		end

	end)

end

timer.Simple(0,function (  )

	if ezJobs then

		hook.Add("ezJobsLoaded","jBlacklist_LoadDarkRPJobs_EzJobs",function(  )

			timer.Simple(1,function(  )
				loadModule()
			end)

		end)

	elseif DCONFIG then

		hook.Add("DConfigDataLoaded","jBlacklist_LoadDarkRPJobs_DConfig",function (  )

			timer.Simple(1,function(  )
				loadModule()
			end)

		end)

	else

		--Check if DarkRPModification already is loaded.
		if DarkRP and DarkRP.disabledDefaults then
			loadModule()
		else
			hook.Add("loadCustomDarkRPItems","jBlacklist_LoadDarkRPJobs",function(  )
				loadModule()
			end)
		end

	end

end)