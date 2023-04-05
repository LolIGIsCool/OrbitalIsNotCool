local LANGUAGE = {}
LANGUAGE.Name = "German"
LANGUAGE.Author = "Halokey"
LANGUAGE.Version = "1.1.4"

--[[-------------------------------------------------------------------------
GENERAL
---------------------------------------------------------------------------]]
LANGUAGE["OUTDATED_LANG"] = "Diese Sprache könnte eventuell nicht kompatibel mit der version von JBlacklist sein!"

LANGUAGE["INFO_LOADINGDATA"] = "Lade Informationen vom Spieler."

LANGUAGE["INFO_NOTAUTHORIZED"] = "Sie besitzen nicht den benötigten Rang um dies zu tun."

--TAGS: %C = Command
LANGUAGE["BLACKLISTED_COMMAND_INFO"] = "Art %C to show more information."

--TAGS: %A = AdminName, %P = Spielers separated by comma, %R = Grund, %T = Formated Time, %B = Blacklist types seperated by a comma.
LANGUAGE["BLACKLISTED_ADVERT"] = "%A wurde auf die Schwarze Liste gesetzt (%P) für %R. (%B) (%T)"

--TAGS: %A = AdminName, %R = Grund, %T = Formated Time, %B = Blacklist types seperated by a comma.
LANGUAGE["BLACKLISTED_PERSONAL"] = "Sie wurde auf die Schwarze Liste gesetzt von %A für %R. (%B) (%T)"

--TAGS: %A = AdminName, %P = Spieler, %I = BlacklistID 
LANGUAGE["REMOVED_ADVERT"] = "%A entfernte einen Namen von der Schwarzen Liste von %P. (%I)"

--TAGS: %A = AdminName, %P = Spieler
LANGUAGE["ERASED_ADVERT"] = nil --ENGLISH: %A erased all playerdata from %P.

--TAGS: %B = Name of blacklist
LANGUAGE["BLACKLIST_EXPIRED"] = nil --ENGLISH: Your %B blacklist has expired.

LANGUAGE["LOG_WARNING"] = nil --ENGLISH: This will be logged to prevent abusive actions.

--TAGS: %L = Länge in minutes.
LANGUAGE["LENGTH_CHANGED"] = nil --ENGLISH: The length of the blacklist was changed to %L minutes due to limited access.

--[[-------------------------------------------------------------------------
VGUI - GENERAL
---------------------------------------------------------------------------]]

LANGUAGE["TITLE_ADMIN"] = "Admin Konsole"
LANGUAGE["TITLE_OVERVIEW"] = "Schwarze Liste Übersicht"
LANGUAGE["TITLE_NOTIFICATION"] = nil --ENGLISH: Notification
LANGUAGE["TITLE_QUERY"] = nil --ENGLISH: Verify
LANGUAGE["TITLE_STRINGREQUEST"] = nil --ENGLISH: Input
LANGUAGE["TITLE_UPDATE"] = nil --ENGLISH: Update

LANGUAGE["CONFIRM"] = nil --ENGLISH: Confirm
LANGUAGE["CANCEL"] = nil --ENGLISH: Cancel

LANGUAGE["OK"] = nil --ENGLISH: OK

LANGUAGE["ISSUEBUTTON"] = "Angelegenheit"
LANGUAGE["MANAGEBUTTON"] = "Verwalten"
LANGUAGE["STATSBUTTON"] = "Statistiken"

LANGUAGE["INPUTSTEAMID"] = "Eingabe SteamID"
LANGUAGE["INPUTSTEAMID_TITLE"] = "Hinzufügen SteamID"
LANGUAGE["INPUTSTEAMID_QUARY"] = "Füge die SteamID ein welche du hinzuzufügen möchtest."
LANGUAGE["INPUTSTEAMID_INCORRECTFORMAT"] = "Unkorrektes SteamID Format!"
LANGUAGE["INPUTSTEAMID_ALREADYADDED"] = "Diese SteamID liegt bereits im System vor."

LANGUAGE["ENTER_SEARCHWORD"] = nil --ENGLISH: Enter search word...

LANGUAGE["MULTISELECTOR_DONE"] = nil --ENGLISH: Done

LANGUAGE["NOACCESS"] = nil --ENGLISH: NO ACCESS

LANGUAGE["LOADING_DATA"] = nil --ENGLISH: Loading Data

LANGUAGE["LOADING_WAIT"] = nil --ENGLISH: Please wait while the required data is being loaded...

--[[-------------------------------------------------------------------------
VGUI - ISSUE TAB
---------------------------------------------------------------------------]]

LANGUAGE["ISSUE_TYPE"] = "Art"
LANGUAGE["ISSUE_TARGET"] = "Spieler"
LANGUAGE["ISSUE_LENGTH"] = "Länge"
LANGUAGE["ISSUE_REASON"] = "Grund"

LANGUAGE["ISSUE_CHOOSE_TYPE"] = "Choose Blacklist Art"
LANGUAGE["ISSUE_CHOOSE_TARGET"] = "Wähle Spieler"

LANGUAGE["ISSUE_SILENT"] = nil --ENGLISH: Silent
LANGUAGE["ISSUE_ISSUE"] = "Angelegenheit"

LANGUAGE["ISSUE_MISSING_TYPES"] = nil --ENGLISH: Please select at least one Blacklist Type before issuing blacklist.
LANGUAGE["ISSUE_MISSING_TARGETS"] = nil --ENGLISH: Please select at least one Target before issuing blacklist.

--[[-------------------------------------------------------------------------
VGUI - MANAGE TAB
---------------------------------------------------------------------------]]

LANGUAGE["MANAGE_DETAILSTITLE"] = "Schawarz Listen Details"
LANGUAGE["MANAGE_MODIFYTITLE"] = "Schwarze Liste Ändern"

LANGUAGE["MANAGE_CHOOSE_PLAYER"] = "Wähle einen Spieler..."

LANGUAGE["MANAGE_ID"] = "ID"
LANGUAGE["MANAGE_USERNAME"] = "Nutzername"
LANGUAGE["MANAGE_STEAMID"] = "SteamID"
LANGUAGE["MANAGE_TYPE"] = "Art"
LANGUAGE["MANAGE_REASON"] = "Grund"
LANGUAGE["MANAGE_DESCRIPTION"] = nil --ENGLISH: Description
LANGUAGE["MANAGE_GIVENON"] = "Angegeben auf"
LANGUAGE["MANAGE_TIMELEFT"] = "Verbleibende Zeit"
LANGUAGE["MANAGE_GIVENBY"] = "Angegeben von"
LANGUAGE["MANAGE_UPDATED"] = "Letzte Aktualisierung"

LANGUAGE["MANAGE_DETAILS"] = "Details"
LANGUAGE["MANAGE_MODIFY"] = "Ändern"
LANGUAGE["MANAGE_REMOVE"] = "Entfernen"
LANGUAGE["MANAGE_INFO"] = nil --ENGLISH: Information
LANGUAGE["MANAGE_COPYUSERNAME"] = nil --ENGLISH: Copy Username
LANGUAGE["MANAGE_COPYSTEAMID"] = nil --ENGLISH: Copy SteamID
LANGUAGE["MANAGE_COPYSTEAMID64"] = nil --ENGLISH: Copy SteamID64
LANGUAGE["MANAGE_COPYREASON"] = nil --ENGLISH: Copy Reason
LANGUAGE["MANAGE_OPENSTEAMPROFILE"] = nil --ENGLISH: Steam Profile

LANGUAGE["MANAGE_ALL"] = nil --ENGLISH: All
LANGUAGE["MANAGE_GOTOPAGE"] = nil --ENGLISH: What page would you like to go to?
LANGUAGE["MANAGE_ACTIONALL"] = nil --ENGLISH: You cannot perform this action on all players.

LANGUAGE["MANAGE_UPDATEBUTTON"] = "Schwarze Liste Aktualisieren"

LANGUAGE["MANAGE_DETAILS_QUARY"] = "Sind sie sicher, dass sie diese Schwarze Liste löschen wollen?"

LANGUAGE["MANAGE_LOADMORE_BUTTON"] = "Mehr laden"

LANGUAGE["MANAGE_EXTMGT_ERASEPLYDATA"] = nil --ENGLISH: Erase PlayerData
LANGUAGE["MANAGE_EXTMGT_SELECTPLY"] = nil --ENGLISH: Please select a player first.
LANGUAGE["MANAGE_EXTMGT_CONFIRM_1"] = nil --ENGLISH: Are you sure you want to delete all blacklists from this user?
LANGUAGE["MANAGE_EXTMGT_CONFIRM_2"] = nil --ENGLISH: Confirm that you want to delete all of this player's data.
LANGUAGE["MANAGE_EXTMGT_WRONGANSWER"] = nil --ENGLISH: Please enter the correct answer to erase data.

--TAGS: %Q = Math Question (Ex. 2 + 2)
LANGUAGE["MANAGE_EXTMGT_QUESTION"] = nil --ENGLISH: Please enter what %Q is below to erase data.

LANGUAGE["MANAGE_STATISTICS_TOTAL"] = nil --ENGLISH: Total Blacklists
LANGUAGE["MANAGE_STATISTICS_COMMON"] = nil --ENGLISH: Häufige Art der Einschränkung

LANGUAGE["MANAGE_UPDATEOCCURRED"] = nil --ENGLISH: A change occurred in this player's blacklists.
LANGUAGE["MANAGE_UPDATELIST"] = nil --ENGLISH: Do you wish to update the list?

--[[-------------------------------------------------------------------------
VGUI - Statistiken
---------------------------------------------------------------------------]]

LANGUAGE["STATISTICS_ISSUED"] = "Total Angelegenheitd"
LANGUAGE["STATISTICS_REMOVED"] = "Gesamt Entfernt"
LANGUAGE["STATISTICS_COMMON"] = nil --ENGLISH: Häufige Art der Einschränkung
LANGUAGE["STATISTICS_TOP"] = "Top Schwarzlister"

LANGUAGE["MANAGE_STATISTICS_NONE"] = nil --ENGLISH: None

--[[-------------------------------------------------------------------------
TIME TYPES
---------------------------------------------------------------------------]]

LANGUAGE["EXPIRED"] = nil --ENGLISH: Expired
LANGUAGE["TIME_SECONDS"] = "Sekunden"
LANGUAGE["TIME_MINUTES"] = "Minuten"
LANGUAGE["TIME_HOURS"] = "Stunden"
LANGUAGE["TIME_DAYS"] = "Tage"
LANGUAGE["TIME_WEEKS"] = "Wochen"
LANGUAGE["TIME_MONTHS"] = "Monate"
LANGUAGE["TIME_YEARS"] = "Jahre"
LANGUAGE["TIME_PERMANENT"] = nil --ENGLISH: Never

--TAGS: %Y = Years (Number), %M = Months (Number)
LANGUAGE["FORMATTEDTIME_YM"] = nil --ENGLISH: %Y years and %M months

--TAGS: %M = Months (Number), %D = Days (Number)
LANGUAGE["FORMATTEDTIME_MD"] = nil --ENGLISH: %M months and %D days

--TAGS: %D = Days (Number), %H = Hours (Number)
LANGUAGE["FORMATTEDTIME_DH"] = nil --ENGLISH: %D days and %H hours

--TAGS: %H = Hours (Number), %M = Minutes (Number)
LANGUAGE["FORMATTEDTIME_HM"] = nil --ENGLISH: %H hours and %M minutes

--TAGS: %M = Minutes (Number), %S = Seconds (Number)
LANGUAGE["FORMATTEDTIME_MS"] = nil --ENGLISH: %M minutes and %S seconds

--TAGS: %S = Seconds (Number)
LANGUAGE["FORMATTEDTIME_S"] = nil --ENGLISH: %S seconds

--[[-------------------------------------------------------------------------
Warning Messages.
---------------------------------------------------------------------------]]
LANGUAGE["WARNING_ADDBL_FAIL"] = "Hinzufügen der Schwarzen Liste fehlgeschlagen."
LANGUAGE["WARNING_REMOVEBL_FAIL"] = "Das Entfernen ist fehlgeschlagen."
LANGUAGE["WARNING_UPDATEBL_FAIL"] = "Aktualisieren der Schwarzen Liste ist fehlgeschlagen."
LANGUAGE["WARNING_READBLTABLE_FAIL"] = "Das lesen der Schwarzlisten Tabelle ist fehlgeschlagen."
LANGUAGE["WARNING_ERASEBLACKLISTS_FAIL"] = nil --ENGLISH: Failed to erase blacklists.
LANGUAGE["WARNING_GETBLPAGE_FAIL"] = nil --ENGLISH: Failed to load page of blacklists.

LANGUAGE["WARNING_ADDBL_SUCCESS"] = "Hinzufügen der Schwarzen Liste war erfolgreich."
LANGUAGE["WARNING_REMOVEBL_SUCCESS"] = "Entfernen der Schwarzen Liste war erfolgreich."
LANGUAGE["WARNING_UPDATEBL_SUCCESS"] = "Aktualisieren der Schwarzen Liste war erfolgreich."
LANGUAGE["WARNING_READBLTABLE_SUCCESS"] = "Die Tabelle der Schwarzen Liste konnte erfolgreich gelesen werden."
LANGUAGE["WARNING_ERASEBLACKLISTS_SUCCESS"] = nil --ENGLISH: Successfully erased blacklists.
LANGUAGE["WARNING_GETBLPAGE_SUCCESS"] = nil --ENGLISH: Successfully read page of blacklists.

LANGUAGE["WARNING_LOADPLAYER_FAIL"] = "Laden des Spieler ist fehlgeschlagen."
LANGUAGE["WARNING_GETALLBL_NOTHINGTOREAD"] = nil --ENGLISH: There are no blacklists to load on this page.

LANGUAGE["WARNING_ERROR_MISSINGARGS"] = "Fehlende Argumente"
LANGUAGE["WARNING_ERROR_WRONGDATATYPE"] = "Falsche Dateien Art"
LANGUAGE["WARNING_ERROR_INCORRECTSTEAMIDFORMAT"] = "Unkorrektes SteamID Format"
LANGUAGE["WARNING_ERROR_BLNOTEXIST"] = "Schwarze Liste existiert nicht."
LANGUAGE["WARNING_ERROR_INCORRECTBLFORMAT"] = "Unkorrektes Schwarzlisten Format"
LANGUAGE["WARNING_ERROR_CONFIGNOTEXIST"] = nil --ENGLISH: Config-ID does not exist.
LANGUAGE["WARNING_ERROR_TYPENOTEXIST"] = nil --ENGLISH: Blacklist type does not exist
LANGUAGE["WARNING_ERROR_SQLERROR"] = nil --ENGLISH: MySQL/SQLite Error

--[[-------------------------------------------------------------------------
Blacklist specific translations.
---------------------------------------------------------------------------]]
LANGUAGE["BLACKLIST_GRAVGUN"] = "Sie sind nicht berechtigt die Gravity Gun zu nutzen, da ihr Name sich auf der Schwarzen Liste befindet!"
LANGUAGE["BLACKLIST_TEAM"] = "Sie sind nicht berechtigt diesen Job zu nutzen, da ihr Name sich auf der Schwarzen Liste befindet!"
LANGUAGE["BLACKLIST_OOC"] = "Sie sind nicht berechtigt den OOC Chat zu nutzen, da ihr Name sich auf der Schwarzen Liste befindet!"
LANGUAGE["BLACKLIST_PHYSGUN"] = "Sie sind nicht berechtigt die Physic Gun zu nutzen, da ihr Name sich auf der Schwarzen Liste befindet!"
LANGUAGE["BLACKLIST_PROPS"] = "Sie sind nicht berechtigt Props oder Entities zu erschaffen, da ihr Name sich auf der Schwarzen Liste befindet!"
LANGUAGE["BLACKLIST_TOOLGUN"] = "Sie sind nicht berechtigt die Tool Gun zu nutzen, da ihr Name sich auf der Schwarzen Liste befindet!"
LANGUAGE["BLACKLIST_WEAPONS"] = "Sie sind nicht berechtigt diese Waffen zu nutzen, da ihr Name sich auf der Schwarzen Liste befindet!"
LANGUAGE["BLACKLIST_VEHICLES"] = "Sie sind nicht berechtigt Fahrzeuge zu fahren, da ihr Name sich auf der Schwarzen Liste befindet!"
LANGUAGE["BLACKLIST_WIREMOD"] = nil --ENGLISH: You are not allowed to use Wiremod due to being blacklisted!
LANGUAGE["BLACKLIST_TOOL"] = nil --ENGLISH: You are not allowed to use this tool due to being blacklisted!
LANGUAGE["BLACKLIST_BUYAMMO"] = nil --ENGLISH: You are not allowed to buy ammo due to being blacklisted!
LANGUAGE["BLACKLIST_BUYENTITY"] = nil --ENGLISH: You are not allowed to buy entities due to being blacklisted!
LANGUAGE["BLACKLIST_BUYPISTOL"] = nil --ENGLISH: You are not allowed to buy pistols due to being blacklisted!
LANGUAGE["BLACKLIST_BUYSHIPMENT"] = nil --ENGLISH: You are not allowed to buy shipments due to being blacklisted!
LANGUAGE["BLACKLIST_CANADVERT"] = nil --ENGLISH: You are not allowed to advert due to being blacklisted!
LANGUAGE["BLACKLIST_Lockpick"] = nil --ENGLISH: You are not allowed to lockpick due to being blacklisted!
LANGUAGE["BLACKLIST_CINEMA_REQUESTVIDEO"] = nil --ENGLISH: You are not allowed to add videos to the queue due to being blacklisted!
LANGUAGE["BLACKLIST_TEXTCHAT"] = nil --ENGLISH: You are not allowed to type non-commands in text chat due to being blacklisted!
LANGUAGE["BLACKLIST_CAMERASWEP"] = nil --ENGLISH: You are not allowed to use the camera SWEP due to being blacklisted!
LANGUAGE["BLACKLIST_VOICECHAT"] = nil --ENGLISH: You are not allowed to talk in voice chat due to being blacklisted!

--%T = Time
LANGUAGE["BLACKLIST_NLR"] = "Sie müssen %T Minuten warten bevor sie wiederbelebt werden, da ihr Name sich auf der Schwarzen Liste befindet!"

--%T = Time
LANGUAGE["BLACKLIST_NLR_RESPAWN"] = nil --ENGLISH: You can respawn in %T.

--[[-------------------------------------------------------------------------
Blacklist Descriptions
---------------------------------------------------------------------------]]

--%T = FORMATTED TIME
LANGUAGE["BLACKLIST_EXPIRESIN"] = nil --ENGLISH: Expires in: %T

LANGUAGE["BLACKLISTDESC_DarkRPBuyAmmo"] = nil --ENGLISH: Restricts the user from purchasing ammunation in the DarkRP gamemode.
LANGUAGE["BLACKLISTDESC_DarkRPBuyPistol"] = nil --ENGLISH: Restricts the user from purchasing pistols in the DarkRP gamemode.
LANGUAGE["BLACKLISTDESC_DarkRPBuyEntity"] = nil --ENGLISH: Restricts the user from purchasing entities in the DarkRP gamemode.
LANGUAGE["BLACKLISTDESC_DarkRPBuyShipment"] = nil --ENGLISH: Restricts the user from purchasing shipments in the DarkRP gamemode.
LANGUAGE["BLACKLISTDESC_DarkRPAdvert"] = nil --ENGLISH: Restricts the user from making adverts in the DarkRP gamemode.
LANGUAGE["BLACKLISTDESC_DarkRPJobs"] = nil --ENGLISH: Restrcits the user from becoming said job in the DarkRP gamemode.
LANGUAGE["BLACKLISTDESC_DarkRPOOC"] = nil --ENGLISH: Restricts the user from using the OOC-chat in the DarkRP gamemode.
LANGUAGE["BLACKLISTDESC_DarkRPLockpick"] = nil --ENGLISH: Restricts the user from using the lockpick in the DarkRP gamemode.
LANGUAGE["BLACKLISTDESC_GravityGun"] = nil --ENGLISH: Restricts the user from using the Gravity Gun.
LANGUAGE["BLACKLISTDESC_PhysGun"] = nil --ENGLISH: Restricts the user from using the Physics Gun.
LANGUAGE["BLACKLISTDESC_ToolGun"] = nil --ENGLISH: Restricts the user from using the Tool Gun.
LANGUAGE["BLACKLISTDESC_NLR"] = nil --ENGLISH: Restricts the user from spawning in certain minutes after dying.
LANGUAGE["BLACKLISTDESC_Props"] = nil --ENGLISH: Restricts the user from spawning props/entities/vehicles.
LANGUAGE["BLACKLISTDESC_Tools"] = nil --ENGLISH: Restricts the user from using said tool.
LANGUAGE["BLACKLISTDESC_Vehicles"] = nil --ENGLISH: Restricts the user from driving vehicles.
LANGUAGE["BLACKLISTDESC_Weapons"] = nil --ENGLISH: Restricts the user from using certain weapons.
LANGUAGE["BLACKLISTDESC_WireMod"] = nil --ENGLISH: Restricts the user from using the Wiremod tools.
LANGUAGE["BLACKLISTDESC_CINEMA_REQUESTVIDEO"] = nil --ENGLISH: Restricts the user from adding new videos to the queue in the cinema gamemode.
LANGUAGE["BLACKLISTDESC_TextChat"] = nil --ENGLISH: --ENGLISH: Restricts the user from typing non-commands in the text chat.
LANGUAGE["BLACKLISTDESC_CAMERASWEP"] = nil --ENGLISH: Restricts the user from using the camera SWEP.
LANGUAGE["BLACKLISTDESC_VOICECHAT"] = nil --ENGLISH: Restricts the user from talking in voice chat.

--[[-------------------------------------------------------------------------
REGISTER THE BLACKLIST.
---------------------------------------------------------------------------]]

--Register the language.
jBlacklist.RegisterLang(LANGUAGE)