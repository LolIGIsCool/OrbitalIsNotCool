--Create a table to store all blacklists in.
jBlacklist.RegistredBlacklists = {}

--Find the player metatable to create a metafunction.
local PLAYER = FindMetaTable("Player")

--Create a function to check if a player is blacklisted.
function PLAYER:IsBlacklisted( BL )

	--Make the function server only.
	if CLIENT then
		ErrorNoHalt("This function may only be ran on the server.")
		return
	end

	--Check if the blacklist is disabled.
	if BL.Enabled == false then return false end

	--Make sure the player has loaded correctly.
	if !self.jBlacklist then return false end

	--Check if the player got a registred blacklist.
	if !self.jBlacklist.Blacklists[BL.Name] then return false end

	--Cache the blacklisttime.
	local Time = self.jBlacklist.Blacklists[BL.Name]

	--Check if the blacklist have expired.
	local Expired = Time < os.time() and Time != -1

	--Remove the blacklist from the users registred blacklist if it has expired.
	if Expired == true then

		--Remove the blacklist from the user's loaded blacklists.
		self.jBlacklist.Blacklists[BL.Name] = nil

		--Set the advertMEssage.
		local AdvertMessage = jBlacklist.LoadedLanguage["BLACKLIST_EXPIRED"]

		--Replace tags with their information.
		AdvertMessage = string.Replace(AdvertMessage,"%B",BL.Name)

		--INform the player that their blacklist has expired.
		jBlacklist.Notify(JBLACKLIST_NOTIFYENUM_POPUP, AdvertMessage , self)

		--Call the OnExpire function.
		jBlacklist.RegistredBlacklists[BL.Name].OnExpire(self)

	end

	--Return if the blacklist was expired.
	return !Expired

end

--Create a function format time.
function jBlacklist.FormatBlacklistTime( Time )

	--Make sure the time is not below -1.
	Time = math.max(Time, -1)

	--Check if the blacklist is permanent.
	if Time == -1 then return jBlacklist.LoadedLanguage["TIME_PERMANENT"] end

	local TimeTable = {}

	TimeTable.Years = math.floor(Time / 31556926)
	TimeTable.Months = math.floor((Time / 2629743) % (31556926 / 2629743))
	TimeTable.Days = math.floor((Time / 86400) % (2629743 / 86400))
	TimeTable.Hours = math.floor((Time / 3600) % (86400 / 3600))
	TimeTable.Minutes = math.floor((Time / 60) % (3600 / 60))
	TimeTable.Seconds = math.floor(Time % 60)

	if TimeTable.Years > 0 then

		local FormattedTime = jBlacklist.LoadedLanguage["FORMATTEDTIME_YM"]
		FormattedTime = string.Replace(FormattedTime,"%Y",TimeTable.Years)
		FormattedTime = string.Replace(FormattedTime,"%M",TimeTable.Months)

		return FormattedTime

	elseif TimeTable.Months > 0 then

		local FormattedTime = jBlacklist.LoadedLanguage["FORMATTEDTIME_MD"]
		FormattedTime = string.Replace(FormattedTime,"%M",TimeTable.Months)
		FormattedTime = string.Replace(FormattedTime,"%D",TimeTable.Days)

		return FormattedTime

	elseif TimeTable.Days > 0 then

		local FormattedTime = jBlacklist.LoadedLanguage["FORMATTEDTIME_DH"]
		FormattedTime = string.Replace(FormattedTime,"%D",TimeTable.Days)
		FormattedTime = string.Replace(FormattedTime,"%H",TimeTable.Hours)

		return FormattedTime

	elseif TimeTable.Hours > 0 then

		local FormattedTime = jBlacklist.LoadedLanguage["FORMATTEDTIME_HM"]
		FormattedTime = string.Replace(FormattedTime,"%H",TimeTable.Hours)
		FormattedTime = string.Replace(FormattedTime,"%M",TimeTable.Minutes)

		return FormattedTime

	elseif TimeTable.Minutes > 0 then

		local FormattedTime = jBlacklist.LoadedLanguage["FORMATTEDTIME_MS"]
		FormattedTime = string.Replace(FormattedTime,"%M",TimeTable.Minutes)
		FormattedTime = string.Replace(FormattedTime,"%S",TimeTable.Seconds)

		return FormattedTime

	else

		local FormattedTime = jBlacklist.LoadedLanguage["FORMATTEDTIME_S"]
		FormattedTime = string.Replace(FormattedTime,"%S",TimeTable.Seconds)

		return FormattedTime

	end

end

--Create a function to create new blacklists.
function jBlacklist.RegisterBL(BL)

	--Check if the blacklist is disabled.
	if BL.Disabled == true then return end

	--Check so all neccessary vars have been created.
	BL.Name = BL.Name or Error("Missing name for blacklist.")
	BL.OnIssued = BL.OnIssued or function( ) end
	BL.OnExpire = BL.OnExpire or function( ) end

	--Insert the blacklist into a global table.
	jBlacklist.RegistredBlacklists[BL.Name] = BL

	--Run the hook jBlacklist_BlacklistRegistered.
	hook.Run("jBlacklist_BlacklistRegistered", BL)

end

--Create a function to send a message to the client about their blacklist.
function jBlacklist.ShowBlacklistedPopup( ply, BlacklistTbl )

	--Make sure we got a value.
	ply.jBlacklist.MsgCooldowns[BlacklistTbl.Name] = ply.jBlacklist.MsgCooldowns[BlacklistTbl.Name] or 0

	--Check if we got a cooldown.
	if ply.jBlacklist.MsgCooldowns[BlacklistTbl.Name] > CurTime() then return end

	--Apply value.
	ply.jBlacklist.MsgCooldowns[BlacklistTbl.Name] = CurTime() + 1

	--Get the command-msg.
	local Message = jBlacklist.LoadedLanguage["BLACKLISTED_COMMAND_INFO"]
	Message = string.Replace(Message,"%C", jBlacklist.Configuration.GetConfigValue( "OVERVIEWCMD" ))

	--Get the expire-msg.
	local ExpireMessage = jBlacklist.LoadedLanguage["BLACKLIST_EXPIRESIN"]
	ExpireMessage = string.Replace(ExpireMessage,"%T", jBlacklist.FormatBlacklistTime(ply.jBlacklist.Blacklists[BlacklistTbl.Name] - os.time()))

	--Get the custom phrase for the current blacklist-type.
	local phrase = BlacklistTbl.GetBlacklistedPhrase()

	--Notify the client.
	jBlacklist.Notify(JBLACKLIST_NOTIFYENUM_POPUP, ExpireMessage, ply)
	jBlacklist.Notify(JBLACKLIST_NOTIFYENUM_POPUP, Message, ply)

	if phrase then
		jBlacklist.Notify(JBLACKLIST_NOTIFYENUM_POPUP, phrase, ply)
	end

end

if CLIENT then
	jBlacklist.AddHook = function(  ) end
end

--[[-------------------------------------------------------------------------
Load blacklists.
---------------------------------------------------------------------------]]

--Find all blacklists installed.
local BlacklistsInstalled = file.Find("jblacklist/blacklists/*","LUA")

--Loop through all blacklists.
for i = 1,#BlacklistsInstalled do

	--Check so the blacklist have the correct name.
	if string.Left(BlacklistsInstalled[i],3) == "sh_" then

		--Check if the code is running serverside and tell the client to download the blacklist.
		if SERVER then AddCSLuaFile("jblacklist/blacklists/" .. BlacklistsInstalled[i]) end

		--Include the blacklist.
		include("jblacklist/blacklists/" .. BlacklistsInstalled[i])

	end

end

--Run the hook jBlacklist_BlacklistsFinishedLoading.
hook.Run("jBlacklist_BlacklistsFinishedLoading")