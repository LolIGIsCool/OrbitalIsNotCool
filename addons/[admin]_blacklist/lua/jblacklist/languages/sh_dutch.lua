local LANGUAGE = {}
LANGUAGE.Name = "Dutch"
LANGUAGE.Author = "Mr. Flaminator"
LANGUAGE.Version = "1.1.4"

--[[-------------------------------------------------------------------------
GENERAL
---------------------------------------------------------------------------]]
LANGUAGE["OUTDATED_LANG"] = "Deze taal is misschien niet compatible met deze versie van JBlacklist!"

LANGUAGE["INFO_LOADINGDATA"] = "Data laden van de speler."

LANGUAGE["INFO_NOTAUTHORIZED"] = "Je hebt niet de juiste rank om dit te doen."

--TAGS: %C = Command
LANGUAGE["BLACKLISTED_COMMAND_INFO"] = "Type %C voor meer informatie."

--TAGS: %A = AdminName, %P = Doels separated by comma, %R = Reden, %T = Formated Time, %B = Blacklist types seperated by a comma.
LANGUAGE["BLACKLISTED_ADVERT"] = "%A blacklisted (%P) voor %R. (%B) (%T)"

--TAGS: %A = AdminName, %R = Reden, %T = Formated Time, %B = Blacklist types seperated by a comma.
LANGUAGE["BLACKLISTED_PERSONAL"] = "Je bent geblacklisted door %A voor %R. (%B) (%T)"

--TAGS: %A = AdminName, %P = Doel, %I = BlacklistID 
LANGUAGE["REMOVED_ADVERT"] = "%A heeft een blacklist verwijderd van %P. (%I)"

--TAGS: %A = AdminName, %P = Doel
LANGUAGE["ERASED_ADVERT"] = nil --ENGLISH: %A erased all playerdata from %P.

--TAGS: %B = Name of blacklist
LANGUAGE["BLACKLIST_EXPIRED"] = nil --ENGLISH: Your %B blacklist has expired.

LANGUAGE["LOG_WARNING"] = nil --ENGLISH: This will be logged to prevent abusive actions.

--TAGS: %L = Lengte in minutes.
LANGUAGE["LENGTH_CHANGED"] = nil --ENGLISH: The length of the blacklist was changed to %L minutes due to limited access.

--[[-------------------------------------------------------------------------
VGUI - GENERAL
---------------------------------------------------------------------------]]

LANGUAGE["TITLE_ADMIN"] = "Admin Paneel"
LANGUAGE["TITLE_OVERVIEW"] = "Blacklists overzicht"
LANGUAGE["TITLE_NOTIFICATION"] = nil --ENGLISH: Notification
LANGUAGE["TITLE_QUERY"] = nil --ENGLISH: Verify
LANGUAGE["TITLE_STRINGREQUEST"] = nil --ENGLISH: Input
LANGUAGE["TITLE_UPDATE"] = nil --ENGLISH: Update

LANGUAGE["CONFIRM"] = nil --ENGLISH: Confirm
LANGUAGE["CANCEL"] = nil --ENGLISH: Cancel

LANGUAGE["OK"] = nil --ENGLISH: OK

LANGUAGE["ISSUEBUTTON"] = "Probleem"
LANGUAGE["MANAGEBUTTON"] = "Beheer"
LANGUAGE["STATSBUTTON"] = "Statistieken"

LANGUAGE["INPUTSTEAMID"] = "Invoer SteamID"
LANGUAGE["INPUTSTEAMID_TITLE"] = "Toevoegen SteamID"
LANGUAGE["INPUTSTEAMID_QUARY"] = "Voer de SteamID die je wilt toevoegen."
LANGUAGE["INPUTSTEAMID_INCORRECTFORMAT"] = "Incorrect SteamID formaat!"
LANGUAGE["INPUTSTEAMID_ALREADYADDED"] = "Dit SteamID is al eens toegevoegt."

LANGUAGE["ENTER_SEARCHWORD"] = nil --ENGLISH: Enter search word...

LANGUAGE["MULTISELECTOR_DONE"] = nil --ENGLISH: Done

LANGUAGE["NOACCESS"] = nil --ENGLISH: NO ACCESS

LANGUAGE["LOADING_DATA"] = nil --ENGLISH: Loading Data

LANGUAGE["LOADING_WAIT"] = nil --ENGLISH: Please wait while the required data is being loaded...

--[[-------------------------------------------------------------------------
VGUI - ISSUE TAB
---------------------------------------------------------------------------]]

LANGUAGE["ISSUE_TYPE"] = "Type"
LANGUAGE["ISSUE_TARGET"] = "Doel"
LANGUAGE["ISSUE_LENGTH"] = "Lengte"
LANGUAGE["ISSUE_REASON"] = "Reden"

LANGUAGE["ISSUE_CHOOSE_TYPE"] = "Kies Blacklist Type"
LANGUAGE["ISSUE_CHOOSE_TARGET"] = "Kies Doel"

LANGUAGE["ISSUE_SILENT"] = nil --ENGLISH: Silent
LANGUAGE["ISSUE_ISSUE"] = "Probleem"

LANGUAGE["ISSUE_MISSING_TYPES"] = nil --ENGLISH: Please select at least one Blacklist Type before issuing blacklist.
LANGUAGE["ISSUE_MISSING_TARGETS"] = nil --ENGLISH: Please select at least one Target before issuing blacklist.

--[[-------------------------------------------------------------------------
VGUI - MANAGE TAB
---------------------------------------------------------------------------]]

LANGUAGE["MANAGE_DETAILSTITLE"] = "Blacklist Details"
LANGUAGE["MANAGE_MODIFYTITLE"] = "Wijzig Blacklist"

LANGUAGE["MANAGE_CHOOSE_PLAYER"] = "Kies een speler..."

LANGUAGE["MANAGE_ID"] = "ID"
LANGUAGE["MANAGE_USERNAME"] = "Nicknaam"
LANGUAGE["MANAGE_STEAMID"] = "SteamID"
LANGUAGE["MANAGE_TYPE"] = "Type"
LANGUAGE["MANAGE_REASON"] = "Reden"
LANGUAGE["MANAGE_DESCRIPTION"] = nil --ENGLISH: Description
LANGUAGE["MANAGE_GIVENON"] = "Gegeven op"
LANGUAGE["MANAGE_TIMELEFT"] = "Tijd over"
LANGUAGE["MANAGE_GIVENBY"] = "Gegeven door"
LANGUAGE["MANAGE_UPDATED"] = "Laatste Update"

LANGUAGE["MANAGE_DETAILS"] = "Details"
LANGUAGE["MANAGE_MODIFY"] = "Wijzig"
LANGUAGE["MANAGE_REMOVE"] = "Verwijder"
LANGUAGE["MANAGE_INFO"] = nil --ENGLISH: Information
LANGUAGE["MANAGE_COPYUSERNAME"] = nil --ENGLISH: Copy Username
LANGUAGE["MANAGE_COPYSTEAMID"] = nil --ENGLISH: Copy SteamID
LANGUAGE["MANAGE_COPYSTEAMID64"] = nil --ENGLISH: Copy SteamID64
LANGUAGE["MANAGE_COPYREASON"] = nil --ENGLISH: Copy Reason
LANGUAGE["MANAGE_OPENSTEAMPROFILE"] = nil --ENGLISH: Steam Profile

LANGUAGE["MANAGE_ALL"] = nil --ENGLISH: All
LANGUAGE["MANAGE_GOTOPAGE"] = nil --ENGLISH: What page would you like to go to?
LANGUAGE["MANAGE_ACTIONALL"] = nil --ENGLISH: You cannot perform this action on all players.

LANGUAGE["MANAGE_UPDATEBUTTON"] = "Werk Blacklist bij"

LANGUAGE["MANAGE_DETAILS_QUARY"] = "Ben je zeker dat je deze blacklist wilt verwijderen?"

LANGUAGE["MANAGE_LOADMORE_BUTTON"] = "Laad meer"

LANGUAGE["MANAGE_EXTMGT_ERASEPLYDATA"] = nil --ENGLISH: Erase PlayerData
LANGUAGE["MANAGE_EXTMGT_SELECTPLY"] = nil --ENGLISH: Please select a player first.
LANGUAGE["MANAGE_EXTMGT_CONFIRM_1"] = nil --ENGLISH: Are you sure you want to delete all blacklists from this user?
LANGUAGE["MANAGE_EXTMGT_CONFIRM_2"] = nil --ENGLISH: Confirm that you want to delete all of this player's data.
LANGUAGE["MANAGE_EXTMGT_WRONGANSWER"] = nil --ENGLISH: Please enter the correct answer to erase data.

--TAGS: %Q = Math Question (Ex. 2 + 2)
LANGUAGE["MANAGE_EXTMGT_QUESTION"] = nil --ENGLISH: Please enter what %Q is below to erase data.

LANGUAGE["MANAGE_STATISTICS_TOTAL"] = nil --ENGLISH: Total Blacklists
LANGUAGE["MANAGE_STATISTICS_COMMON"] = nil --ENGLISH: Gemeenschappelijke Blacklists

LANGUAGE["MANAGE_UPDATEOCCURRED"] = nil --ENGLISH: A change occurred in this player's blacklists.
LANGUAGE["MANAGE_UPDATELIST"] = nil --ENGLISH: Do you wish to update the list?

--[[-------------------------------------------------------------------------
VGUI - Statistieken
---------------------------------------------------------------------------]]

LANGUAGE["STATISTICS_ISSUED"] = "Total Probleemd"
LANGUAGE["STATISTICS_REMOVED"] = "Totaal Verwijderd"
LANGUAGE["STATISTICS_COMMON"] = nil --ENGLISH: Gemeenschappelijke Blacklists
LANGUAGE["STATISTICS_TOP"] = "Beste Blacklister"

LANGUAGE["MANAGE_STATISTICS_NONE"] = nil --ENGLISH: None

--[[-------------------------------------------------------------------------
TIME TYPES
---------------------------------------------------------------------------]]

LANGUAGE["EXPIRED"] = nil --ENGLISH: Expired
LANGUAGE["TIME_SECONDS"] = "Seconden"
LANGUAGE["TIME_MINUTES"] = "Minuten"
LANGUAGE["TIME_HOURS"] = "Uren"
LANGUAGE["TIME_DAYS"] = "Dagen"
LANGUAGE["TIME_WEEKS"] = "Weken"
LANGUAGE["TIME_MONTHS"] = "Maanden"
LANGUAGE["TIME_YEARS"] = "Jaren"
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
LANGUAGE["WARNING_ADDBL_FAIL"] = "Mislukt van het toevoegen van een blacklist."
LANGUAGE["WARNING_REMOVEBL_FAIL"] = "Mislukt om blacklist te verwijderen."
LANGUAGE["WARNING_UPDATEBL_FAIL"] = "Mislukt om blacklist te wijzigen."
LANGUAGE["WARNING_READBLTABLE_FAIL"] = "Mislukt om de lijst met blacklists te lezen."
LANGUAGE["WARNING_ERASEBLACKLISTS_FAIL"] = nil --ENGLISH: Failed to erase blacklists.
LANGUAGE["WARNING_GETBLPAGE_FAIL"] = nil --ENGLISH: Failed to load page of blacklists.

LANGUAGE["WARNING_ADDBL_SUCCESS"] = "Blacklist toevoegen gelukt."
LANGUAGE["WARNING_REMOVEBL_SUCCESS"] = "Verwijderen van blacklist gelukt."
LANGUAGE["WARNING_UPDATEBL_SUCCESS"] = "Wijzigen van blacklist gelukt."
LANGUAGE["WARNING_READBLTABLE_SUCCESS"] = "Lezen van de blacklist lijst is gelukt."
LANGUAGE["WARNING_ERASEBLACKLISTS_SUCCESS"] = nil --ENGLISH: Successfully erased blacklists.
LANGUAGE["WARNING_GETBLPAGE_SUCCESS"] = nil --ENGLISH: Successfully read page of blacklists.

LANGUAGE["WARNING_LOADPLAYER_FAIL"] = "Laden van de speler mislukt."
LANGUAGE["WARNING_GETALLBL_NOTHINGTOREAD"] = nil --ENGLISH: There are no blacklists to load on this page.

LANGUAGE["WARNING_ERROR_MISSINGARGS"] = "Ontbrekende argumenten"
LANGUAGE["WARNING_ERROR_WRONGDATATYPE"] = "Verkeerd gegevenstype"
LANGUAGE["WARNING_ERROR_INCORRECTSTEAMIDFORMAT"] = "Incorrect SteamID formaat"
LANGUAGE["WARNING_ERROR_BLNOTEXIST"] = "Blacklist bestaat niet"
LANGUAGE["WARNING_ERROR_INCORRECTBLFORMAT"] = "Onjuiste Blacklist formaat"
LANGUAGE["WARNING_ERROR_CONFIGNOTEXIST"] = nil --ENGLISH: Config-ID does not exist.
LANGUAGE["WARNING_ERROR_TYPENOTEXIST"] = nil --ENGLISH: Blacklist type does not exist
LANGUAGE["WARNING_ERROR_SQLERROR"] = nil --ENGLISH: MySQL/SQLite Error

--[[-------------------------------------------------------------------------
Blacklist specific translations.
---------------------------------------------------------------------------]]
LANGUAGE["BLACKLIST_GRAVGUN"] = "U mag de Gravity Gun niet gebruiken als gevolg van een blacklist!"
LANGUAGE["BLACKLIST_TEAM"] = "U mag deze baan niet worden door een blacklist!"
LANGUAGE["BLACKLIST_OOC"] = "U mag geen OOC-chat gebruiken als gevolg van een blacklist"
LANGUAGE["BLACKLIST_PHYSGUN"] = "U mag de Physics Gun niet gebruiken als gevolg van een blacklist!"
LANGUAGE["BLACKLIST_PROPS"] = "U mag geen props of entities plaatsen als gevolg van een blacklist!"
LANGUAGE["BLACKLIST_TOOLGUN"] = "U mag de Toolgun niet gebruiken als gevolg van een blacklist!"
LANGUAGE["BLACKLIST_WEAPONS"] = "U mag de wapens niet gebruiken als gevolg van een blacklist"
LANGUAGE["BLACKLIST_VEHICLES"] = "U mag met geen voertuigen rijden als gevolg van een blacklist!"
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
LANGUAGE["BLACKLIST_NLR"] = "U moet %T minuten wachten voordat u doorgaat als gevolg van een blacklist!"

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