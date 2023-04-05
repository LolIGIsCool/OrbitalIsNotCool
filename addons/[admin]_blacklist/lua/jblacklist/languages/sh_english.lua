local LANGUAGE = {}
LANGUAGE.Name = "English"
LANGUAGE.Author = "Jompe"
LANGUAGE.Version = "2.3.2"

--[[-------------------------------------------------------------------------
GENERAL
---------------------------------------------------------------------------]]
LANGUAGE["OUTDATED_LANG"] = "This language may not be compatible with this version of JBlacklist!"

LANGUAGE["INFO_LOADINGDATA"] = "[Blacklist] Loading data from player."

LANGUAGE["INFO_NOTAUTHORIZED"] = "You don't have the required rank to do this."

--TAGS: %C = Command
LANGUAGE["BLACKLISTED_COMMAND_INFO"] = "Type %C to show more information."

--TAGS: %A = AdminName, %P = Targets separated by comma, %R = Reason, %T = Formated Time, %B = Blacklist types seperated by a comma.
LANGUAGE["BLACKLISTED_ADVERT"] = "%A blacklisted (%P) for %R. (%B) (%T)"

--TAGS: %A = AdminName, %P = Target, %R = Reason, %T = Formated Time, %B = Blacklist types seperated by a comma.
LANGUAGE["BLACKLISTED_PERSONAL"] = "You have been blacklisted by %A for %R. (%B) (%T)"

--TAGS: %A = AdminName, %P = Target, %I = BlacklistID 
LANGUAGE["REMOVED_ADVERT"] = "%A removed a blacklist from %P. (%I)"

--TAGS: %A = AdminName, %P = Target
LANGUAGE["ERASED_ADVERT"] = "%A erased all playerdata from %P."

--TAGS: %B = Name of blacklist
LANGUAGE["BLACKLIST_EXPIRED"] = "Your %B blacklist has expired."

LANGUAGE["LOG_WARNING"] = "This will be logged to prevent abusive actions."

--TAGS: %L = Length in minutes.
LANGUAGE["LENGTH_CHANGED"] = "The length of the blacklist was changed to %L minutes due to limited access."

--[[-------------------------------------------------------------------------
VGUI - GENERAL
---------------------------------------------------------------------------]]

LANGUAGE["TITLE_ADMIN"] = "Admin Panel"
LANGUAGE["TITLE_OVERVIEW"] = "Blacklists Overview"
LANGUAGE["TITLE_NOTIFICATION"] = "Notification"
LANGUAGE["TITLE_QUERY"] = "Verify"
LANGUAGE["TITLE_STRINGREQUEST"] = "Input"
LANGUAGE["TITLE_UPDATE"] = "Update"

LANGUAGE["CONFIRM"] = "Confirm"
LANGUAGE["CANCEL"] = "Cancel"

LANGUAGE["OK"] = "OK"

LANGUAGE["ISSUEBUTTON"] = "Issue"
LANGUAGE["MANAGEBUTTON"] = "Manage"
LANGUAGE["STATSBUTTON"] = "Statistics"

LANGUAGE["INPUTSTEAMID"] = "Input SteamID"
LANGUAGE["INPUTSTEAMID_TITLE"] = "Add SteamID"
LANGUAGE["INPUTSTEAMID_QUARY"] = "Input the SteamID you want to add."
LANGUAGE["INPUTSTEAMID_INCORRECTFORMAT"] = "Incorrect SteamID format!"
LANGUAGE["INPUTSTEAMID_ALREADYADDED"] = "This SteamID have already been added."

LANGUAGE["ENTER_SEARCHWORD"] = "Enter search word..."

LANGUAGE["MULTISELECTOR_DONE"] = "Done"

LANGUAGE["NOACCESS"] = "NO ACCESS"

LANGUAGE["LOADING_DATA"] = "Loading Data"

LANGUAGE["LOADING_WAIT"] = "Please wait while the required data is being loaded..."

--[[-------------------------------------------------------------------------
VGUI - ISSUE TAB
---------------------------------------------------------------------------]]

LANGUAGE["ISSUE_TYPE"] = "Type"
LANGUAGE["ISSUE_TARGET"] = "Target"
LANGUAGE["ISSUE_LENGTH"] = "Length"
LANGUAGE["ISSUE_REASON"] = "Reason"

LANGUAGE["ISSUE_CHOOSE_TYPE"] = "Choose Blacklist Type"
LANGUAGE["ISSUE_CHOOSE_TARGET"] = "Choose Target"

LANGUAGE["ISSUE_SILENT"] = "Silent"
LANGUAGE["ISSUE_ISSUE"] = "Issue"

LANGUAGE["ISSUE_MISSING_TYPES"] = "Please select at least one Blacklist Type before issuing blacklist."
LANGUAGE["ISSUE_MISSING_TARGETS"] = "Please select at least one Target before issuing blacklist."

--[[-------------------------------------------------------------------------
VGUI - MANAGE TAB
---------------------------------------------------------------------------]]

LANGUAGE["MANAGE_DETAILSTITLE"] = "Blacklist Details"
LANGUAGE["MANAGE_MODIFYTITLE"] = "Modify Blacklist"

LANGUAGE["MANAGE_CHOOSE_PLAYER"] = "Choose a player..."

LANGUAGE["MANAGE_ID"] = "ID"
LANGUAGE["MANAGE_USERNAME"] = "Username"
LANGUAGE["MANAGE_STEAMID"] = "SteamID"
LANGUAGE["MANAGE_TYPE"] = "Type"
LANGUAGE["MANAGE_REASON"] = "Reason"
LANGUAGE["MANAGE_DESCRIPTION"] = "Description"
LANGUAGE["MANAGE_GIVENON"] = "Given On"
LANGUAGE["MANAGE_TIMELEFT"] = "Expires In"
LANGUAGE["MANAGE_GIVENBY"] = "Given By"
LANGUAGE["MANAGE_UPDATED"] = "Last Update"

LANGUAGE["MANAGE_DETAILS"] = "Details"
LANGUAGE["MANAGE_MODIFY"] = "Modify"
LANGUAGE["MANAGE_REMOVE"] = "Remove"
LANGUAGE["MANAGE_INFO"] = "Information"
LANGUAGE["MANAGE_COPYUSERNAME"] = "Copy Username"
LANGUAGE["MANAGE_COPYSTEAMID"] = "Copy SteamID"
LANGUAGE["MANAGE_COPYSTEAMID64"] = "Copy SteamID64"
LANGUAGE["MANAGE_COPYREASON"] = "Copy Reason"
LANGUAGE["MANAGE_OPENSTEAMPROFILE"] = "Steam Profile"

LANGUAGE["MANAGE_ALL"] = "All"
LANGUAGE["MANAGE_GOTOPAGE"] = "What page would you like to go to?"
LANGUAGE["MANAGE_ACTIONALL"] = "You cannot perform this action on all players."

LANGUAGE["MANAGE_UPDATEBUTTON"] = "Update Blacklist"

LANGUAGE["MANAGE_DETAILS_QUARY"] = "Are you sure you want to delete this blacklist?"

LANGUAGE["MANAGE_LOADMORE_BUTTON"] = "Load More"

LANGUAGE["MANAGE_EXTMGT_ERASEPLYDATA"] = "Erase PlayerData"
LANGUAGE["MANAGE_EXTMGT_SELECTPLY"] = "Please select a player first."
LANGUAGE["MANAGE_EXTMGT_CONFIRM_1"] = "Are you sure you want to delete all blacklists from this user?"
LANGUAGE["MANAGE_EXTMGT_CONFIRM_2"] = "Confirm that you want to delete all of this player's data."
LANGUAGE["MANAGE_EXTMGT_WRONGANSWER"] = "Please enter the correct answer to erase data."

--TAGS: %Q = Math Question (Ex. 2 + 2)
LANGUAGE["MANAGE_EXTMGT_QUESTION"] = "Please enter what %Q is below to erase data."

LANGUAGE["MANAGE_STATISTICS_TOTAL"] = "Total Blacklists"
LANGUAGE["MANAGE_STATISTICS_COMMON"] = "Common Blacklist"

LANGUAGE["MANAGE_UPDATEOCCURRED"] = "A change occurred in this player's blacklists."
LANGUAGE["MANAGE_UPDATELIST"] = "Do you wish to update the list?"

--[[-------------------------------------------------------------------------
VGUI - Statistics
---------------------------------------------------------------------------]]

LANGUAGE["STATISTICS_ISSUED"] = "Total Issued"
LANGUAGE["STATISTICS_REMOVED"] = "Total Removed"
LANGUAGE["STATISTICS_COMMON"] = "Common Blacklist"
LANGUAGE["STATISTICS_TOP"] = "Most Issued"

LANGUAGE["MANAGE_STATISTICS_NONE"] = "None"

--[[-------------------------------------------------------------------------
TIME TYPES
---------------------------------------------------------------------------]]

LANGUAGE["EXPIRED"] = "Expired"
LANGUAGE["TIME_SECONDS"] = "Seconds"
LANGUAGE["TIME_MINUTES"] = "Minutes"
LANGUAGE["TIME_HOURS"] = "Hours"
LANGUAGE["TIME_DAYS"] = "Days"
LANGUAGE["TIME_WEEKS"] = "Weeks"
LANGUAGE["TIME_MONTHS"] = "Months"
LANGUAGE["TIME_YEARS"] = "Years"
LANGUAGE["TIME_PERMANENT"] = "Never"

--TAGS: %Y = Years (Number), %M = Months (Number)
LANGUAGE["FORMATTEDTIME_YM"] = "%Y years and %M months"

--TAGS: %M = Months (Number), %D = Days (Number)
LANGUAGE["FORMATTEDTIME_MD"] = "%M months and %D days"

--TAGS: %D = Days (Number), %H = Hours (Number)
LANGUAGE["FORMATTEDTIME_DH"] = "%D days and %H hours"

--TAGS: %H = Hours (Number), %M = Minutes (Number)
LANGUAGE["FORMATTEDTIME_HM"] = "%H hours and %M minutes"

--TAGS: %M = Minutes (Number), %S = Seconds (Number)
LANGUAGE["FORMATTEDTIME_MS"] = "%M minutes and %S seconds"

--TAGS: %S = Seconds (Number)
LANGUAGE["FORMATTEDTIME_S"] = "%S seconds"

--[[-------------------------------------------------------------------------
Warning Messages.
---------------------------------------------------------------------------]]
LANGUAGE["WARNING_ADDBL_FAIL"] = "Failed to add blacklist."
LANGUAGE["WARNING_REMOVEBL_FAIL"] = "Failed to remove blacklist."
LANGUAGE["WARNING_UPDATEBL_FAIL"] = "Failed to update blacklist."
LANGUAGE["WARNING_READBLTABLE_FAIL"] = "Failed to read blacklist table."
LANGUAGE["WARNING_ERASEBLACKLISTS_FAIL"] = "Failed to erase blacklists."
LANGUAGE["WARNING_GETBLPAGE_FAIL"] = "Failed to load page of blacklists."

LANGUAGE["WARNING_ADDBL_SUCCESS"] = "Successfully added blacklist."
LANGUAGE["WARNING_REMOVEBL_SUCCESS"] = "Successfully removed blacklist."
LANGUAGE["WARNING_UPDATEBL_SUCCESS"] = "Successfully updated blacklist."
LANGUAGE["WARNING_READBLTABLE_SUCCESS"] = "Successfully read blacklist table."
LANGUAGE["WARNING_ERASEBLACKLISTS_SUCCESS"] = "Successfully erased blacklists."
LANGUAGE["WARNING_GETBLPAGE_SUCCESS"] = "Successfully read page of blacklists."

LANGUAGE["WARNING_LOADPLAYER_FAIL"] = "Failed to load player."
LANGUAGE["WARNING_GETALLBL_NOTHINGTOREAD"] = "There are no blacklists to load on this page."

LANGUAGE["WARNING_ERROR_MISSINGARGS"] = "Missing arguments"
LANGUAGE["WARNING_ERROR_WRONGDATATYPE"] = "Wrong data type"
LANGUAGE["WARNING_ERROR_INCORRECTSTEAMIDFORMAT"] = "Incorrect SteamID format"
LANGUAGE["WARNING_ERROR_BLNOTEXIST"] = "Blacklist doesn't exist"
LANGUAGE["WARNING_ERROR_INCORRECTBLFORMAT"] = "Incorrect blacklist format"
LANGUAGE["WARNING_ERROR_CONFIGNOTEXIST"] = "Config-ID does not exist."
LANGUAGE["WARNING_ERROR_TYPENOTEXIST"] = "Blacklist type does not exist"
LANGUAGE["WARNING_ERROR_SQLERROR"] = "MySQL/SQLite Error"

--[[-------------------------------------------------------------------------
Blacklist specific translations.
---------------------------------------------------------------------------]]
LANGUAGE["BLACKLIST_GRAVGUN"] = "You are not allowed to use the Gravity Gun due to being blacklisted!"
LANGUAGE["BLACKLIST_TEAM"] = "You are not allowed to become this job due to being blacklisted!"
LANGUAGE["BLACKLIST_OOC"] = "You are not allowed to use OOC chat due to being blacklisted!"
LANGUAGE["BLACKLIST_PHYSGUN"] = "You are not allowed to use the Physics Gun due to being blacklisted!"
LANGUAGE["BLACKLIST_PROPS"] = "You are not allowed to spawn props or entities due to being blacklisted!"
LANGUAGE["BLACKLIST_TOOLGUN"] = "You are not allowed to use the Tool Gun due to being blacklisted!"
LANGUAGE["BLACKLIST_WEAPONS"] = "You are not allowed to use weapons due to being blacklisted!"
LANGUAGE["BLACKLIST_VEHICLES"] = "You are not allowed to drive vehicles due to being blacklisted!"
LANGUAGE["BLACKLIST_WIREMOD"] = "You are not allowed to use Wiremod due to being blacklisted!"
LANGUAGE["BLACKLIST_TOOL"] = "You are not allowed to use this tool due to being blacklisted!"
LANGUAGE["BLACKLIST_BUYAMMO"] = "You are not allowed to buy ammo due to being blacklisted!"
LANGUAGE["BLACKLIST_BUYENTITY"] = "You are not allowed to buy entities due to being blacklisted!"
LANGUAGE["BLACKLIST_BUYPISTOL"] = "You are not allowed to buy pistols due to being blacklisted!"
LANGUAGE["BLACKLIST_BUYSHIPMENT"] = "You are not allowed to buy shipments due to being blacklisted!"
LANGUAGE["BLACKLIST_CANADVERT"] = "You are not allowed to advert due to being blacklisted!"
LANGUAGE["BLACKLIST_LOCKPICK"] = "You are not allowed to lockpick due to being blacklisted!"
LANGUAGE["BLACKLIST_CINEMA_REQUESTVIDEO"] = "You are not allowed to add videos to the queue due to being blacklisted!"
LANGUAGE["BLACKLIST_TEXTCHAT"] = "You are not allowed to type non-commands in text chat due to being blacklisted!"
LANGUAGE["BLACKLIST_CAMERASWEP"] = "You are not allowed to use the camera SWEP due to being blacklisted!"
LANGUAGE["BLACKLIST_VOICECHAT"] = "You are not allowed to talk in voice chat due to being blacklisted!"

--%T = Time
LANGUAGE["BLACKLIST_NLR"] = "You have to wait %T minutes before respawning due to being blacklisted!"

--%T = Time
LANGUAGE["BLACKLIST_NLR_RESPAWN"] = "You can respawn in %T."

--[[-------------------------------------------------------------------------
Blacklist Descriptions
---------------------------------------------------------------------------]]

--%T = FORMATTED TIME
LANGUAGE["BLACKLIST_EXPIRESIN"] = "Expires in: %T"

LANGUAGE["BLACKLISTDESC_DarkRPBuyAmmo"] = "Restricts the user from purchasing ammunation in the DarkRP gamemode."
LANGUAGE["BLACKLISTDESC_DarkRPBuyPistol"] = "Restricts the user from purchasing pistols in the DarkRP gamemode."
LANGUAGE["BLACKLISTDESC_DarkRPBuyEntity"] = "Restricts the user from purchasing entities in the DarkRP gamemode."
LANGUAGE["BLACKLISTDESC_DarkRPBuyShipment"] = "Restricts the user from purchasing shipments in the DarkRP gamemode."
LANGUAGE["BLACKLISTDESC_DarkRPAdvert"] = "Restricts the user from making adverts in the DarkRP gamemode."
LANGUAGE["BLACKLISTDESC_DarkRPJobs"] = "Restrcits the user from becoming said job in the DarkRP gamemode."
LANGUAGE["BLACKLISTDESC_DarkRPOOC"] = "Restricts the user from using the OOC-chat in the DarkRP gamemode."
LANGUAGE["BLACKLISTDESC_DarkRPLockpick"] = "Restricts the user from using the lockpick in the DarkRP gamemode."
LANGUAGE["BLACKLISTDESC_GravityGun"] = "Restricts the user from using the Gravity Gun."
LANGUAGE["BLACKLISTDESC_PhysGun"] = "Restricts the user from using the Physics Gun."
LANGUAGE["BLACKLISTDESC_ToolGun"] = "Restricts the user from using the Tool Gun."
LANGUAGE["BLACKLISTDESC_NLR"] = "Restricts the user from spawning in certain minutes after dying."
LANGUAGE["BLACKLISTDESC_Props"] = "Restricts the user from spawning props/entities/vehicles."
LANGUAGE["BLACKLISTDESC_Tools"] = "Restricts the user from using said tool."
LANGUAGE["BLACKLISTDESC_Vehicles"] = "Restricts the user from driving vehicles."
LANGUAGE["BLACKLISTDESC_Weapons"] = "Restricts the user from using certain weapons."
LANGUAGE["BLACKLISTDESC_WireMod"] = "Restricts the user from using the Wiremod tools."
LANGUAGE["BLACKLISTDESC_CINEMA_REQUESTVIDEO"] = "Restricts the user from adding new videos to the queue in the cinema gamemode."
LANGUAGE["BLACKLISTDESC_TextChat"] = "Restricts the user from typing non-commands in the text chat."
LANGUAGE["BLACKLISTDESC_CAMERASWEP"] = "Restricts the user from using the camera SWEP."
LANGUAGE["BLACKLISTDESC_VOICECHAT"] = "Restricts the user from talking in voice chat."

--[[-------------------------------------------------------------------------
REGISTER THE BLACKLIST.
---------------------------------------------------------------------------]]

--Register the language.
jBlacklist.RegisterLang(LANGUAGE)