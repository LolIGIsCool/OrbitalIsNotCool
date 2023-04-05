--[[-------------------------------------------------------------------------
DO NOT TOUCH ANYTHING IN THIS FILE. CONFIGURATION IS DONE INGAME BY USING THE
CONSOLECOMMAND JBLACKLIST_CONFIG


DO NOT TOUCH ANYTHING IN THIS FILE. CONFIGURATION IS DONE INGAME BY USING THE
CONSOLECOMMAND JBLACKLIST_CONFIG


DO NOT TOUCH ANYTHING IN THIS FILE. CONFIGURATION IS DONE INGAME BY USING THE
CONSOLECOMMAND JBLACKLIST_CONFIG


DO NOT TOUCH ANYTHING IN THIS FILE. CONFIGURATION IS DONE INGAME BY USING THE
CONSOLECOMMAND JBLACKLIST_CONFIG


DO NOT TOUCH ANYTHING IN THIS FILE. CONFIGURATION IS DONE INGAME BY USING THE
CONSOLECOMMAND JBLACKLIST_CONFIG

DO NOT TOUCH ANYTHING IN THIS FILE. CONFIGURATION IS DONE INGAME BY USING THE
CONSOLECOMMAND JBLACKLIST_CONFIG

---------------------------------------------------------------------------]]

--Create some shared enums used for creating configtypes.
JBLACKLIST_CONFIG_BOOL = 1
JBLACKLIST_CONFIG_STRING = 2
JBLACKLIST_CONFIG_NUMBER = 3
JBLACKLIST_CONFIG_TABLE = 4

--Create a shared workspace table for the configurator.
jBlacklist.Configurator = jBlacklist.Configurator or {
	Config = {},
	Usergroups = {}
}


--Create a shared workspace table for the configuration.
jBlacklist.Configuration = jBlacklist.Configuration or {
	Config = {},
	Usergroups = {}
}

--[[-------------------------------------------------------------------------
Functions used to add config-options.
---------------------------------------------------------------------------]]

--Create function to add new configoptions.
function jBlacklist.Configuration.AddConfig( ID, tbl )

	--Add the configtype to the configtable
	jBlacklist.Configurator.Config[ID] = {
		ShortDesc = tbl.ShortDesc,
		ConfigType = tbl.TypeEnum,
		Description = tbl.Description,
		Value = tbl.Default,
		Order = tbl.Order,
		InitializeFunc = tbl.Initialize or function( ) end,
		AcceptedValues = tbl.AcceptedValues,
		SortTable = tbl.Sort or false,
	}

end

--Create function to add new configoptions for specific usergroups.
function jBlacklist.Configuration.AddUserconfig( ID, tbl )

	--Add the configtype to the configtable
	jBlacklist.Configurator.Usergroups[ID] = {
		ShortDesc = tbl.ShortDesc,
		ConfigType = tbl.TypeEnum,
		Description = tbl.Description,
		Value = tbl.Default,
		Order = tbl.Order,
		AcceptedValues = tbl.AcceptedValues,
		SortTable = tbl.Sort or false,
	}

end

--[[-------------------------------------------------------------------------
Config functions
---------------------------------------------------------------------------]]

--Create function used to get the configurations.
function jBlacklist.Configuration.GetConfigValue( ID )

	--Check so the ID is valid.
	if !jBlacklist.Configuration.Config[ID] then return false, jBlacklist.LoadedLanguage["WARNING_ERROR_CONFIGNOTEXIST"] end

	--Return value.
	return jBlacklist.Configuration.Config[ID]

end

--[[-------------------------------------------------------------------------
Access functions.
---------------------------------------------------------------------------]]

--Create function to check if a player has access to something.
function jBlacklist.Configuration.GetUsergroupConfigValue( ply, ID )

	--Check so the usergroup exist.
	if !jBlacklist.Configuration.Usergroups[ply:GetUserGroup()] then return false end

	--Check so the ID was valid.
	if !jBlacklist.Configuration.Usergroups[ply:GetUserGroup()][ID] then return false end

	--Return the value.
	return jBlacklist.Configuration.Usergroups[ply:GetUserGroup()][ID]

end

--[[-------------------------------------------------------------------------
Clientside only stuff
---------------------------------------------------------------------------]]

--Clientside only code.
if CLIENT then

	--Create a receiver for jBlacklist_UpdateClientConfig.
	net.Receive("jBlacklist_UpdateClientConfig",function( )

		--Update the configtable.
		jBlacklist.Configuration.Config = net.ReadTable()
		jBlacklist.Configuration.Usergroups = net.ReadTable()

		--Call initalize functions.
		for k,v in pairs(jBlacklist.Configuration.Config) do

			jBlacklist.Configurator.Config[k].InitializeFunc(v)

		end

	end)

end

--[[-------------------------------------------------------------------------
ADDING CONFIG-OPTIONS BELOW - DO NOT TOUCH THESE.
---------------------------------------------------------------------------]]

--[[-------------------------------------------------------------------------
General configs.
---------------------------------------------------------------------------]]

jBlacklist.Configuration.AddConfig( "SERVERLANGUAGE", {
	ShortDesc = "Server Language",
	Description = "What language should be used for jBlacklist on the server.",
	TypeEnum = JBLACKLIST_CONFIG_TABLE,
	Default = "English",
	Order = 1,
	AcceptedValues = table.GetKeys(jBlacklist.RegistredLanguages),
	Sort = true,
	Initialize = function( value )

		--Make sure it only run's on the server.
		if SERVER then

			--Set the language after we have loaded it.
			jBlacklist.ChangeLang( value )

		end

	end
} )

jBlacklist.Configuration.AddConfig( "CONTENT_DOWNLOAD", {
	ShortDesc = "Content Download",
	Description = "How should the content required to use jBlacklist be downloaded. (Requires Restart)",
	TypeEnum = JBLACKLIST_CONFIG_TABLE,
	Default = "Workshop (Default)",
	Order = 2,
	AcceptedValues = {"Workshop (Default)", "File Download", "None"},
} )

jBlacklist.Configuration.AddConfig( "LOGGING", {
	ShortDesc = "Addon Logging",
	Description = "How should all actions done with jBlacklist be logged. (Requires Restart)",
	TypeEnum = JBLACKLIST_CONFIG_TABLE,
	Default = "Console",
	Order = 3,
	AcceptedValues = {"Console", "Billy's Logs (bLogs)","Console & Billy's Logs (bLogs)", "None"},
} )

jBlacklist.Configuration.AddConfig( "ADMINCMD", {
	ShortDesc = "Admin Command",
	Description = "What command should be used to open the adminmenu.",
	TypeEnum = JBLACKLIST_CONFIG_STRING,
	Default = "!jblacklist",
	Order = 4
} )

jBlacklist.Configuration.AddConfig( "OVERVIEWCMD", {
	ShortDesc = "Overview Command",
	Description = "What command should be used to open the overviewmenu.",
	TypeEnum = JBLACKLIST_CONFIG_STRING,
	Default = "!blacklists",
	Order = 5
} )

jBlacklist.Configuration.AddConfig( "VGUI_FONT", {
	ShortDesc = "Font",
	Description = "What font should the addon use.",
	TypeEnum = JBLACKLIST_CONFIG_TABLE,
	Default = "DermaLarge",
	Order = 6,
	AcceptedValues = {"DermaLarge", "Roboto", "Akbar", "Coolvetica", "Marlett"},
	Initialize = function( value )

		--Make sure it only run's on the client.
		if CLIENT then

			--Update fonts.
			surface.CreateFont( "jBlacklist_HUD_Mini", {
				font = value,
				size = ScreenScale(5),
				weight = 0,
				antialias = true,
			} )

			surface.CreateFont( "jBlacklist_HUD_Small", {
				font = value,
				size = ScreenScale(7),
				weight = 0,
				antialias = true,
			} )

			surface.CreateFont( "jBlacklist_HUD_Small_Bold", {
				font = value,
				size = ScreenScale(7),
				weight = 550,
				antialias = true,
			} )

			surface.CreateFont( "jBlacklist_HUD_Big", {
				font = value,
				size = ScreenScale(15),
				weight = 500,
				antialias = true,
			} )

			surface.CreateFont( "jBlacklist_Stats_Small", {
				font = value,
				size = ScreenScale(8),
				weight = 500,
				antialias = true,
			} )

			surface.CreateFont( "jBlacklist_Stats_Big", {
				font = value,
				size = ScreenScale(25),
				weight = 1000,
				antialias = true,
			} )

		end

	end
} )

jBlacklist.Configuration.AddConfig( "NOTIFY_TARGET_ONISSUED", {
	ShortDesc = "Should target be notified when it receives a blacklist.",
	Description = "Should a notification be shown to the player in the chat that the player has been blacklisted.",
	TypeEnum = JBLACKLIST_CONFIG_BOOL,
	Default = true,
	Order = 7
} )


jBlacklist.Configuration.AddConfig( "NOTIFY_SERVER_ONISSUED", {
	ShortDesc = "Should the server be notified when someone receives a blacklist.",
	Description = "Should a notification be shown to the whole server in the chat when someone receives a blacklist. (Except silent blacklists)",
	TypeEnum = JBLACKLIST_CONFIG_BOOL,
	Default = true,
	Order = 8
} )

jBlacklist.Configuration.AddConfig( "PLAY_NOTIFICATION_SOUND_WINDOW", {
	ShortDesc = "Play Notification Sound - Window",
	Description = "Should a sound be played when a notification is received in form of a winow. (Center of the screen)",
	TypeEnum = JBLACKLIST_CONFIG_BOOL,
	Default = true,
	Order = 9
} )

jBlacklist.Configuration.AddConfig( "PLAY_NOTIFICATION_SOUND_POPUP", {
	ShortDesc = "Play Notification Sound - Popup",
	Description = "Should a sound be played when a notification is received in form of a popup. (Lower right of the screen)",
	TypeEnum = JBLACKLIST_CONFIG_BOOL,
	Default = true,
	Order = 10
} )

jBlacklist.Configuration.AddConfig( "PLAY_NOTIFICATION_SOUND_CHAT", {
	ShortDesc = "Play Notification Sound - Chat",
	Description = "Should a sound be played when a notification is received in form of a chat message. (In the chat)",
	TypeEnum = JBLACKLIST_CONFIG_BOOL,
	Default = false,
	Order = 11
} )

--[[-------------------------------------------------------------------------
Usergroups Configs
---------------------------------------------------------------------------]]

jBlacklist.Configuration.AddUserconfig( "CANCONFIG", {
	ShortDesc = "Can Configure",
	Description = "Should this usergroup be able to modify and configure all jBlacklist settings.",
	TypeEnum = JBLACKLIST_CONFIG_BOOL,
	Default = false,
	Order = 1
} )

jBlacklist.Configuration.AddUserconfig( "ACCESSADMINMENU", {
	ShortDesc = "Can open adminmenu",
	Description = "Should this usergroup be able to open the adminmenu used to blacklist and manage players.",
	TypeEnum = JBLACKLIST_CONFIG_BOOL,
	Default = false,
	Order = 2
} )

jBlacklist.Configuration.AddUserconfig( "CANISSUE", {
	ShortDesc = "Can Blacklist",
	Description = "Should this usergroup be able to blacklist other players.",
	TypeEnum = JBLACKLIST_CONFIG_BOOL,
	Default = false,
	Order = 3
} )

jBlacklist.Configuration.AddUserconfig( "ISSUEMAXLENGTH", {
	ShortDesc = "Blacklist MAX Length",
	Description = "What should be the maximum length this usergroup can blacklist someone in minutes. (0 for no limit)",
	TypeEnum = JBLACKLIST_CONFIG_NUMBER,
	Default = 180,
	Order = 4
} )

jBlacklist.Configuration.AddUserconfig( "CANMODIFYBLACKLIST", {
	ShortDesc = "Can Modify Blacklists",
	Description = "Should this usergroup be able to modify a player's blacklists.",
	TypeEnum = JBLACKLIST_CONFIG_BOOL,
	Default = false,
	Order = 5
} )

jBlacklist.Configuration.AddUserconfig( "CANREMOVE", {
	ShortDesc = "Can Remove Blacklists",
	Description = "Should this usergroup be able to remove blacklists from a player.",
	TypeEnum = JBLACKLIST_CONFIG_BOOL,
	Default = false,
	Order = 6
} )

jBlacklist.Configuration.AddUserconfig( "ERASEDATA", {
	ShortDesc = "Can erase all blacklists from a player",
	Description = "Should this usergroup be able to erase all blacklists from a player.",
	TypeEnum = JBLACKLIST_CONFIG_BOOL,
	Default = false,
	Order = 7
} )

jBlacklist.Configuration.AddUserconfig( "SEESILENCED", {
	ShortDesc = "Can see silenced jBlacklist messages",
	Description = "Should this usergroup be able to see jBlacklist messages which was silenced from the chat.",
	TypeEnum = JBLACKLIST_CONFIG_BOOL,
	Default = false,
	Order = 8
} )