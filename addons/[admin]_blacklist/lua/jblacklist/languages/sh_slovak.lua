local LANGUAGE = {}
LANGUAGE.Name = "Slovak"
LANGUAGE.Author = "EpicWolf~"
LANGUAGE.Version = "1.1.4"

--[[-------------------------------------------------------------------------
GENERAL
---------------------------------------------------------------------------]]
LANGUAGE["OUTDATED_LANG"] = "Tento jazyk nemusí byť kompatibilný s touto verziou JBlacklist!"

LANGUAGE["INFO_LOADINGDATA"] = "Načítavam dáta z osoby."

LANGUAGE["INFO_NOTAUTHORIZED"] = "K tomu nemáte požadovanú hodnosť."

--TAGS: %C = Command
LANGUAGE["BLACKLISTED_COMMAND_INFO"] = "typ %C to show more information."

--TAGS: %A = AdminName, %P = terčs separated by comma, %R = Dôvod, %T = Formated Time, %B = Blacklist types seperated by a comma.
LANGUAGE["BLACKLISTED_ADVERT"] = "%A blacklisted (%P) pre %R. (%B) (%T)"

--TAGS: %A = AdminName, %R = Dôvod, %T = Formated Time, %B = Blacklist types seperated by a comma.
LANGUAGE["BLACKLISTED_PERSONAL"] = "Ty si bol blacklisted od %A za %R. (%B) (%T)"

--TAGS: %A = AdminName, %P = terč, %I = BlacklistID 
LANGUAGE["REMOVED_ADVERT"] = "%A odstránil blacklist od %P. (%I)"

--TAGS: %A = AdminName, %P = terč
LANGUAGE["ERASED_ADVERT"] = nil --ENGLISH: %A erased all playerdata from %P.

--TAGS: %B = Name of blacklist
LANGUAGE["BLACKLIST_EXPIRED"] = nil --ENGLISH: Your %B blacklist has expired.

LANGUAGE["LOG_WARNING"] = nil --ENGLISH: This will be logged to prevent abusive actions.

--TAGS: %L = Dĺžka in minutes.
LANGUAGE["LENGTH_CHANGED"] = nil --ENGLISH: The length of the blacklist was changed to %L minutes due to limited access.

--[[-------------------------------------------------------------------------
VGUI - GENERAL
---------------------------------------------------------------------------]]

LANGUAGE["TITLE_ADMIN"] = "administratívny panel"
LANGUAGE["TITLE_OVERVIEW"] = "Prehľad blacklistov"
LANGUAGE["TITLE_NOTIFICATION"] = nil --ENGLISH: Notification
LANGUAGE["TITLE_QUERY"] = nil --ENGLISH: Verify
LANGUAGE["TITLE_STRINGREQUEST"] = nil --ENGLISH: Input
LANGUAGE["TITLE_UPDATE"] = nil --ENGLISH: Update

LANGUAGE["CONFIRM"] = nil --ENGLISH: Confirm
LANGUAGE["CANCEL"] = nil --ENGLISH: Cancel

LANGUAGE["OK"] = nil --ENGLISH: OK

LANGUAGE["ISSUEBUTTON"] = "Problém"
LANGUAGE["MANAGEBUTTON"] = "Spravovať"
LANGUAGE["STATSBUTTON"] = "Štatistika"

LANGUAGE["INPUTSTEAMID"] = "Vložte SteamID"
LANGUAGE["INPUTSTEAMID_TITLE"] = "Pridať SteamID"
LANGUAGE["INPUTSTEAMID_QUARY"] = "Vložte SteamID ktoré chcete pridať."
LANGUAGE["INPUTSTEAMID_INCORRECTFORMAT"] = "Nesprávny formát SteamID!"
LANGUAGE["INPUTSTEAMID_ALREADYADDED"] = "Toto SteamID bolo už pridane"

LANGUAGE["ENTER_SEARCHWORD"] = nil --ENGLISH: Enter search word...

LANGUAGE["MULTISELECTOR_DONE"] = nil --ENGLISH: Done

LANGUAGE["NOACCESS"] = nil --ENGLISH: NO ACCESS

LANGUAGE["LOADING_DATA"] = nil --ENGLISH: Loading Data

LANGUAGE["LOADING_WAIT"] = nil --ENGLISH: Please wait while the required data is being loaded...

--[[-------------------------------------------------------------------------
VGUI - ISSUE TAB
---------------------------------------------------------------------------]]

LANGUAGE["ISSUE_TYPE"] = "typ"
LANGUAGE["ISSUE_TARGET"] = "terč"
LANGUAGE["ISSUE_LENGTH"] = "Dĺžka"
LANGUAGE["ISSUE_REASON"] = "Dôvod"

LANGUAGE["ISSUE_CHOOSE_TYPE"] = "Choose Blacklist typ"
LANGUAGE["ISSUE_CHOOSE_TARGET"] = "Zvoľte cieľ"

LANGUAGE["ISSUE_SILENT"] = nil --ENGLISH: Silent
LANGUAGE["ISSUE_ISSUE"] = "Problém"

LANGUAGE["ISSUE_MISSING_TYPES"] = nil --ENGLISH: Please select at least one Blacklist Type before issuing blacklist.
LANGUAGE["ISSUE_MISSING_TARGETS"] = nil --ENGLISH: Please select at least one Target before issuing blacklist.

--[[-------------------------------------------------------------------------
VGUI - MANAGE TAB
---------------------------------------------------------------------------]]

LANGUAGE["MANAGE_DETAILSTITLE"] = "Detaily Blacklistu"
LANGUAGE["MANAGE_MODIFYTITLE"] = "Upraviť Blacklist"

LANGUAGE["MANAGE_CHOOSE_PLAYER"] = "Vyberte hráča..."

LANGUAGE["MANAGE_ID"] = "ID"
LANGUAGE["MANAGE_USERNAME"] = "Meno"
LANGUAGE["MANAGE_STEAMID"] = "SteamID"
LANGUAGE["MANAGE_TYPE"] = "typ"
LANGUAGE["MANAGE_REASON"] = "Dôvod"
LANGUAGE["MANAGE_DESCRIPTION"] = nil --ENGLISH: Description
LANGUAGE["MANAGE_GIVENON"] = "Dané v"
LANGUAGE["MANAGE_TIMELEFT"] = "Zostávajúci čas"
LANGUAGE["MANAGE_GIVENBY"] = "Dané"
LANGUAGE["MANAGE_UPDATED"] = "Posledná aktualizácia"

LANGUAGE["MANAGE_DETAILS"] = "Detaily"
LANGUAGE["MANAGE_MODIFY"] = "Pozmeniť"
LANGUAGE["MANAGE_REMOVE"] = "Odstrániť"
LANGUAGE["MANAGE_INFO"] = nil --ENGLISH: Information
LANGUAGE["MANAGE_COPYUSERNAME"] = nil --ENGLISH: Copy Username
LANGUAGE["MANAGE_COPYSTEAMID"] = nil --ENGLISH: Copy SteamID
LANGUAGE["MANAGE_COPYSTEAMID64"] = nil --ENGLISH: Copy SteamID64
LANGUAGE["MANAGE_COPYREASON"] = nil --ENGLISH: Copy Reason
LANGUAGE["MANAGE_OPENSTEAMPROFILE"] = nil --ENGLISH: Steam Profile

LANGUAGE["MANAGE_ALL"] = nil --ENGLISH: All
LANGUAGE["MANAGE_GOTOPAGE"] = nil --ENGLISH: What page would you like to go to?
LANGUAGE["MANAGE_ACTIONALL"] = nil --ENGLISH: You cannot perform this action on all players.

LANGUAGE["MANAGE_UPDATEBUTTON"] = "Aktualizovať Blacklist"

LANGUAGE["MANAGE_DETAILS_QUARY"] = "Naozaj chcete odstrániť tento blacklist?"

LANGUAGE["MANAGE_LOADMORE_BUTTON"] = "Načitať viac"

LANGUAGE["MANAGE_EXTMGT_ERASEPLYDATA"] = nil --ENGLISH: Erase PlayerData
LANGUAGE["MANAGE_EXTMGT_SELECTPLY"] = nil --ENGLISH: Please select a player first.
LANGUAGE["MANAGE_EXTMGT_CONFIRM_1"] = nil --ENGLISH: Are you sure you want to delete all blacklists from this user?
LANGUAGE["MANAGE_EXTMGT_CONFIRM_2"] = nil --ENGLISH: Confirm that you want to delete all of this player's data.
LANGUAGE["MANAGE_EXTMGT_WRONGANSWER"] = nil --ENGLISH: Please enter the correct answer to erase data.

--TAGS: %Q = Math Question (Ex. 2 + 2)
LANGUAGE["MANAGE_EXTMGT_QUESTION"] = nil --ENGLISH: Please enter what %Q is below to erase data.

LANGUAGE["MANAGE_STATISTICS_TOTAL"] = nil --ENGLISH: Total Blacklists
LANGUAGE["MANAGE_STATISTICS_COMMON"] = nil --ENGLISH: Časté Blacklisty

LANGUAGE["MANAGE_UPDATEOCCURRED"] = nil --ENGLISH: A change occurred in this player's blacklists.
LANGUAGE["MANAGE_UPDATELIST"] = nil --ENGLISH: Do you wish to update the list?

--[[-------------------------------------------------------------------------
VGUI - Štatistika
---------------------------------------------------------------------------]]

LANGUAGE["STATISTICS_ISSUED"] = "Total Problémd"
LANGUAGE["STATISTICS_REMOVED"] = "Celkom odstránené"
LANGUAGE["STATISTICS_COMMON"] = nil --ENGLISH: Časté Blacklisty
LANGUAGE["STATISTICS_TOP"] = "Najviac Blacklisted"

LANGUAGE["MANAGE_STATISTICS_NONE"] = nil --ENGLISH: None

--[[-------------------------------------------------------------------------
TIME TYPES
---------------------------------------------------------------------------]]

LANGUAGE["EXPIRED"] = nil --ENGLISH: Expired
LANGUAGE["TIME_SECONDS"] = "Sekundy"
LANGUAGE["TIME_MINUTES"] = "Minuty"
LANGUAGE["TIME_HOURS"] = "Hodiny"
LANGUAGE["TIME_DAYS"] = "Dni"
LANGUAGE["TIME_WEEKS"] = "Týždne"
LANGUAGE["TIME_MONTHS"] = "Mesiace"
LANGUAGE["TIME_YEARS"] = "Roky"
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
LANGUAGE["WARNING_ADDBL_FAIL"] = "Nepodarilo sa pridať blacklist."
LANGUAGE["WARNING_REMOVEBL_FAIL"] = "Nepodarilo sa odstrániť blacklist."
LANGUAGE["WARNING_UPDATEBL_FAIL"] = "Nepodarilo sa aktualizovať blacklist."
LANGUAGE["WARNING_READBLTABLE_FAIL"] = "Tabulka blacklistu sa nepodarilo prečítať"
LANGUAGE["WARNING_ERASEBLACKLISTS_FAIL"] = nil --ENGLISH: Failed to erase blacklists.
LANGUAGE["WARNING_GETBLPAGE_FAIL"] = nil --ENGLISH: Failed to load page of blacklists.

LANGUAGE["WARNING_ADDBL_SUCCESS"] = "Úspešne pridaný do blacklist."
LANGUAGE["WARNING_REMOVEBL_SUCCESS"] = "Úspešne odobraté z Blacklistu."
LANGUAGE["WARNING_UPDATEBL_SUCCESS"] = "Úspešne aktualizované blacklist."
LANGUAGE["WARNING_READBLTABLE_SUCCESS"] = "Úspešne prečítaná tabulka blacklistu."
LANGUAGE["WARNING_ERASEBLACKLISTS_SUCCESS"] = nil --ENGLISH: Successfully erased blacklists.
LANGUAGE["WARNING_GETBLPAGE_SUCCESS"] = nil --ENGLISH: Successfully read page of blacklists.

LANGUAGE["WARNING_LOADPLAYER_FAIL"] = "Nepodarilo sa načítať hráča."
LANGUAGE["WARNING_GETALLBL_NOTHINGTOREAD"] = nil --ENGLISH: There are no blacklists to load on this page.

LANGUAGE["WARNING_ERROR_MISSINGARGS"] = "Chýbajú argumenty"
LANGUAGE["WARNING_ERROR_WRONGDATATYPE"] = "Chybný typ údajov"
LANGUAGE["WARNING_ERROR_INCORRECTSTEAMIDFORMAT"] = "Nesprávny formát SteamID"
LANGUAGE["WARNING_ERROR_BLNOTEXIST"] = "Blacklist neexistuje"
LANGUAGE["WARNING_ERROR_INCORRECTBLFORMAT"] = "Nesprávny blacklistový formát"
LANGUAGE["WARNING_ERROR_CONFIGNOTEXIST"] = nil --ENGLISH: Config-ID does not exist.
LANGUAGE["WARNING_ERROR_TYPENOTEXIST"] = nil --ENGLISH: Blacklist type does not exist
LANGUAGE["WARNING_ERROR_SQLERROR"] = nil --ENGLISH: MySQL/SQLite Error

--[[-------------------------------------------------------------------------
Blacklist specific translations.
---------------------------------------------------------------------------]]
LANGUAGE["BLACKLIST_GRAVGUN"] = "Nie je povolené používať Gravity Gun kvôli blacklistu!"
LANGUAGE["BLACKLIST_TEAM"] = "Nemáte povolené stať sa touto prácou kvôli tomu, že ste na blackliste!"
LANGUAGE["BLACKLIST_OOC"] = "Nemáte povolené používať OOC chat kvôli tomu, že ste na blackliste!"
LANGUAGE["BLACKLIST_PHYSGUN"] = "Nesmiete používať Physics Gun vôli tomu, že ste na blackliste!"
LANGUAGE["BLACKLIST_PROPS"] = "Nemáte povolenie na spawnutie objektov(prop) alebo subjektov(entity) kvôli blacklistu!"
LANGUAGE["BLACKLIST_TOOLGUN"] = "Nie ste oprávnení použiť Tool Gun kvôli blacklistu!"
LANGUAGE["BLACKLIST_WEAPONS"] = "Nie je dovolené používať zbrane v dôsledku toho, že sú na blackliste!"
LANGUAGE["BLACKLIST_VEHICLES"] = "Nie je dovolené riadiť vozidlá v dôsledku toho, že sú na blackliste!"
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
LANGUAGE["BLACKLIST_NLR"] = "Musíš počkať %T minúty pred narodenim kvôli blacklistu!"

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