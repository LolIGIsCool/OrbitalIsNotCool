VoiceBox.FX.Config() -- Don't touch, move or remove this line

--[[  Commenting this out, i'm not configurating this for you guys, should be pretty easy to do.

    
-- Having config troubles?
-- Paste it in here to check syntax: https://fptje.github.io/glualint-web/


-- Player FX
-- Players with these SteamIDs/SteamID64s will automatically have these voice FX applied...

VoiceBox.FX.Config:AddPlayerFX("76561197960279927", "Combine")
VoiceBox.FX.Config:AddPlayerFX("STEAM_0:1:7099", "Combine")

-- You can also add multiple players to one Voice FX like so:
VoiceBox.FX.Config:AddPlayerFX("STEAM_0:1:7099", "76561197960279927", "Combine")


-- Usergroup FX
-- Players in these usergroups (also supports GmodAdminSuite secondary usergroups) will automatically have these voice FX applied...

VoiceBox.FX.Config:AddUsergroupFX("combine-fx", "Combine")
VoiceBox.FX.Config:AddUsergroupFX("stormtrooper-fx", "Stormtrooper")
-- You can also add multiple usergroups to one Voice FX like so:
VoiceBox.FX.Config:AddUsergroupFX("combine-fx", "combine-soldier-fx", "Combine")


-- Team/Job FX
-- Players in teams/jobs will automatically have these voice FX applied...

VoiceBox.FX.Config:AddTeamFX(TEAM_POLICE, "Combine")
VoiceBox.FX.Config:AddTeamFX(TEAM_STORMTROOPER, "Stormtrooper")
-- You can also add multiple teams/jobs to one Voice FX like so:
VoiceBox.FX.Config:AddTeamFX(TEAM_POLICE, TEAM_CHIEF, "Combine")


-- Accessory FX
-- Players wearing these accessories will automatically have these voice FX applied...
-- For a list of what accessory scripts are supported, please see the script page

VoiceBox.FX.Config:AddAccessoryFX("Ginger Bread", "Stormtrooper")
VoiceBox.FX.Config:AddAccessoryFX("Helmet", "Combine")
-- You can also add multiple accessories to one Voice FX like so:
VoiceBox.FX.Config:AddTeamFX("Helmet", "Gas Mask", "Masked")


-- Model FX
-- Players with these playermodels will automatically have these voice FX applied...

VoiceBox.FX.Config:AddModelFX("models/player/combine_soldier_prisonguard.mdl", "Combine")
-- You can also add multiple models to one Voice FX like so:
VoiceBox.FX.Config:AddModelFX("models/player/combine_soldier_prisonguard.mdl", "models/player/combine_soldier.mdl", "Combine")


-- Bodygroup FX
-- Players with these playermodels and bodygroups will automatically have these voice FX applied...

VoiceBox.FX.Config:AddBodygroupFX(
	-- Model
	"models/player/zombie_classic.mdl",

	-- Bodygroup Name or ID
	"Headcrab1",

	-- Bodygroup Value
	1,

	-- Voice FX
	"Stormtrooper"
)

]]