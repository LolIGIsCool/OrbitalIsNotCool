local LANGUAGE = {}
LANGUAGE.Name = "French"
LANGUAGE.Author = "Տบ乃ɑ尺ป"
LANGUAGE.Version = "1.1.5"

--[[-------------------------------------------------------------------------
GENERAL
---------------------------------------------------------------------------]]
LANGUAGE["OUTDATED_LANG"] = "Cette langue peut-être incompatible avec cette version de JBlacklist !"

LANGUAGE["INFO_LOADINGDATA"] = "Chargement des données du joueur."

LANGUAGE["INFO_NOTAUTHORIZED"] = "Vous n'avez pas le rang requis pour faire cela."

--TAGS: %C = Command
LANGUAGE["BLACKLISTED_COMMAND_INFO"] = "Tapez %C pour afficher plus d'informations."

--TAGS: %A = AdminName, %P = Cibles separated by comma, %R = Raison, %T = Formated Time, %B = Blacklist types seperated by a comma.
LANGUAGE["BLACKLISTED_ADVERT"] = "%A a blacklisté (%P) pour la raison suivante %R. (%B) (%T)"

--TAGS: %A = AdminName, %R = Raison, %T = Formated Time, %B = Blacklist types seperated by a comma.
LANGUAGE["BLACKLISTED_PERSONAL"] = "Vous avez été blacklisté par %A pour la raison suivante %R. (%B) (%T)"

--TAGS: %A = AdminName, %P = Cible, %I = BlacklistID 
LANGUAGE["REMOVED_ADVERT"] = "%A à enlever le blacklist de %P. (%I)"

--TAGS: %A = AdminName, %P = Cible
LANGUAGE["ERASED_ADVERT"] = nil --ENGLISH: %A erased all playerdata from %P.

--TAGS: %B = Name of blacklist
LANGUAGE["BLACKLIST_EXPIRED"] = nil --ENGLISH: Your %B blacklist has expired.

LANGUAGE["LOG_WARNING"] = nil --ENGLISH: This will be logged to prevent abusive actions.

--TAGS: %L = Longueur in minutes.
LANGUAGE["LENGTH_CHANGED"] = nil --ENGLISH: The length of the blacklist was changed to %L minutes due to limited access.

--[[-------------------------------------------------------------------------
VGUI - GENERAL
---------------------------------------------------------------------------]]

LANGUAGE["TITLE_ADMIN"] = "Panel Admin"
LANGUAGE["TITLE_OVERVIEW"] = "Aperçu des Blacklists"
LANGUAGE["TITLE_NOTIFICATION"] = nil --ENGLISH: Notification
LANGUAGE["TITLE_QUERY"] = nil --ENGLISH: Verify
LANGUAGE["TITLE_STRINGREQUEST"] = nil --ENGLISH: Input
LANGUAGE["TITLE_UPDATE"] = nil --ENGLISH: Update

LANGUAGE["CONFIRM"] = nil --ENGLISH: Confirm
LANGUAGE["CANCEL"] = nil --ENGLISH: Cancel

LANGUAGE["OK"] = nil --ENGLISH: OK

LANGUAGE["ISSUEBUTTON"] = "Problème"
LANGUAGE["MANAGEBUTTON"] = "Gérer"
LANGUAGE["STATSBUTTON"] = "Statistiques"

LANGUAGE["INPUTSTEAMID"] = "Mettre le SteamID"
LANGUAGE["INPUTSTEAMID_TITLE"] = "Ajouter le SteamID"
LANGUAGE["INPUTSTEAMID_QUARY"] = "Mettre le SteamID que vous voulez ajouter."
LANGUAGE["INPUTSTEAMID_INCORRECTFORMAT"] = "Format du SteamID incorrect!"
LANGUAGE["INPUTSTEAMID_ALREADYADDED"] = "Ce SteamID a déjà été ajouté."

LANGUAGE["ENTER_SEARCHWORD"] = nil --ENGLISH: Enter search word...

LANGUAGE["MULTISELECTOR_DONE"] = nil --ENGLISH: Done

LANGUAGE["NOACCESS"] = nil --ENGLISH: NO ACCESS

LANGUAGE["LOADING_DATA"] = nil --ENGLISH: Loading Data

LANGUAGE["LOADING_WAIT"] = nil --ENGLISH: Please wait while the required data is being loaded...

--[[-------------------------------------------------------------------------
VGUI - ISSUE TAB
---------------------------------------------------------------------------]]

LANGUAGE["ISSUE_TYPE"] = "Type"
LANGUAGE["ISSUE_TARGET"] = "Cible"
LANGUAGE["ISSUE_LENGTH"] = "Longueur"
LANGUAGE["ISSUE_REASON"] = "Raison"

LANGUAGE["ISSUE_CHOOSE_TYPE"] = "Choisissez le type de blacklist"
LANGUAGE["ISSUE_CHOOSE_TARGET"] = "Sélectionner la Cible"

LANGUAGE["ISSUE_SILENT"] = nil --ENGLISH: Silent
LANGUAGE["ISSUE_ISSUE"] = "Problème"

LANGUAGE["ISSUE_MISSING_TYPES"] = nil --ENGLISH: Please select at least one Blacklist Type before issuing blacklist.
LANGUAGE["ISSUE_MISSING_TARGETS"] = nil --ENGLISH: Please select at least one Target before issuing blacklist.

--[[-------------------------------------------------------------------------
VGUI - MANAGE TAB
---------------------------------------------------------------------------]]

LANGUAGE["MANAGE_DETAILSTITLE"] = "Détails sur le Blacklist"
LANGUAGE["MANAGE_MODIFYTITLE"] = "Modifier le Blacklist"

LANGUAGE["MANAGE_CHOOSE_PLAYER"] = "Sélectionner un joueur..."

LANGUAGE["MANAGE_ID"] = "ID"
LANGUAGE["MANAGE_USERNAME"] = "Nom"
LANGUAGE["MANAGE_STEAMID"] = "SteamID"
LANGUAGE["MANAGE_TYPE"] = "Type"
LANGUAGE["MANAGE_REASON"] = "Raison"
LANGUAGE["MANAGE_DESCRIPTION"] = nil --ENGLISH: Description
LANGUAGE["MANAGE_GIVENON"] = "Donné le"
LANGUAGE["MANAGE_TIMELEFT"] = "Temps restant"
LANGUAGE["MANAGE_GIVENBY"] = "Attribué par"
LANGUAGE["MANAGE_UPDATED"] = "Dernière mise à jour"

LANGUAGE["MANAGE_DETAILS"] = "Détails"
LANGUAGE["MANAGE_MODIFY"] = "Modifier"
LANGUAGE["MANAGE_REMOVE"] = "Supprimer"
LANGUAGE["MANAGE_INFO"] = nil --ENGLISH: Information
LANGUAGE["MANAGE_COPYUSERNAME"] = nil --ENGLISH: Copy Username
LANGUAGE["MANAGE_COPYSTEAMID"] = nil --ENGLISH: Copy SteamID
LANGUAGE["MANAGE_COPYSTEAMID64"] = nil --ENGLISH: Copy SteamID64
LANGUAGE["MANAGE_COPYREASON"] = nil --ENGLISH: Copy Reason
LANGUAGE["MANAGE_OPENSTEAMPROFILE"] = nil --ENGLISH: Steam Profile

LANGUAGE["MANAGE_ALL"] = nil --ENGLISH: All
LANGUAGE["MANAGE_GOTOPAGE"] = nil --ENGLISH: What page would you like to go to?
LANGUAGE["MANAGE_ACTIONALL"] = nil --ENGLISH: You cannot perform this action on all players.

LANGUAGE["MANAGE_UPDATEBUTTON"] = "Mettre à jour le Blacklist"

LANGUAGE["MANAGE_DETAILS_QUARY"] = "Êtes-vous sûr d'enlever ce blacklist ?"

LANGUAGE["MANAGE_LOADMORE_BUTTON"] = "Charger plus"

LANGUAGE["MANAGE_EXTMGT_ERASEPLYDATA"] = nil --ENGLISH: Erase PlayerData
LANGUAGE["MANAGE_EXTMGT_SELECTPLY"] = nil --ENGLISH: Please select a player first.
LANGUAGE["MANAGE_EXTMGT_CONFIRM_1"] = nil --ENGLISH: Are you sure you want to delete all blacklists from this user?
LANGUAGE["MANAGE_EXTMGT_CONFIRM_2"] = nil --ENGLISH: Confirm that you want to delete all of this player's data.
LANGUAGE["MANAGE_EXTMGT_WRONGANSWER"] = nil --ENGLISH: Please enter the correct answer to erase data.

--TAGS: %Q = Math Question (Ex. 2 + 2)
LANGUAGE["MANAGE_EXTMGT_QUESTION"] = nil --ENGLISH: Please enter what %Q is below to erase data.

LANGUAGE["MANAGE_STATISTICS_TOTAL"] = nil --ENGLISH: Total Blacklists
LANGUAGE["MANAGE_STATISTICS_COMMON"] = nil --ENGLISH: Common Blacklist

LANGUAGE["MANAGE_UPDATEOCCURRED"] = nil --ENGLISH: A change occurred in this player's blacklists.
LANGUAGE["MANAGE_UPDATELIST"] = nil --ENGLISH: Do you wish to update the list?

--[[-------------------------------------------------------------------------
VGUI - Statistiques
---------------------------------------------------------------------------]]

LANGUAGE["STATISTICS_ISSUED"] = "Total Problèmed"
LANGUAGE["STATISTICS_REMOVED"] = "Total enlevés"
LANGUAGE["STATISTICS_COMMON"] = nil --ENGLISH: Common Blacklist
LANGUAGE["STATISTICS_TOP"] = "Top Blacklister"

LANGUAGE["MANAGE_STATISTICS_NONE"] = nil --ENGLISH: None

--[[-------------------------------------------------------------------------
TIME TYPES
---------------------------------------------------------------------------]]

LANGUAGE["EXPIRED"] = nil --ENGLISH: Expired
LANGUAGE["TIME_SECONDS"] = "Secondes"
LANGUAGE["TIME_MINUTES"] = "Minutes"
LANGUAGE["TIME_HOURS"] = "Heures"
LANGUAGE["TIME_DAYS"] = "Jours"
LANGUAGE["TIME_WEEKS"] = "Semaines"
LANGUAGE["TIME_MONTHS"] = "Mois"
LANGUAGE["TIME_YEARS"] = "Années"
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
LANGUAGE["WARNING_ADDBL_FAIL"] = "Échec de l'ajout du blacklist."
LANGUAGE["WARNING_REMOVEBL_FAIL"] = "Échec de la suppression du blacklist."
LANGUAGE["WARNING_UPDATEBL_FAIL"] = "Échec de la mise à jour du blacklist."
LANGUAGE["WARNING_READBLTABLE_FAIL"] = "Impossible de lire la table des blacklists."
LANGUAGE["WARNING_ERASEBLACKLISTS_FAIL"] = nil --ENGLISH: Failed to erase blacklists.
LANGUAGE["WARNING_GETBLPAGE_FAIL"] = nil --ENGLISH: Failed to load page of blacklists.

LANGUAGE["WARNING_ADDBL_SUCCESS"] = "Ajouté à la blacklist avec succès."
LANGUAGE["WARNING_REMOVEBL_SUCCESS"] = "Blacklist supprimé avec succès."
LANGUAGE["WARNING_UPDATEBL_SUCCESS"] = "Blacklist mise à jour avec succès."
LANGUAGE["WARNING_READBLTABLE_SUCCESS"] = "Table des blacklists chargées avec succès."
LANGUAGE["WARNING_ERASEBLACKLISTS_SUCCESS"] = nil --ENGLISH: Successfully erased blacklists.
LANGUAGE["WARNING_GETBLPAGE_SUCCESS"] = nil --ENGLISH: Successfully read page of blacklists.

LANGUAGE["WARNING_LOADPLAYER_FAIL"] = "Échec du chargement des données du joueur."
LANGUAGE["WARNING_GETALLBL_NOTHINGTOREAD"] = nil --ENGLISH: There are no blacklists to load on this page.

LANGUAGE["WARNING_ERROR_MISSINGARGS"] = "Arguments manquants"
LANGUAGE["WARNING_ERROR_WRONGDATATYPE"] = "Mauvais type de données"
LANGUAGE["WARNING_ERROR_INCORRECTSTEAMIDFORMAT"] = "Format du SteamID incorrect"
LANGUAGE["WARNING_ERROR_BLNOTEXIST"] = "Blacklist n'existe pas"
LANGUAGE["WARNING_ERROR_INCORRECTBLFORMAT"] = "Format de blacklist incorrect"
LANGUAGE["WARNING_ERROR_CONFIGNOTEXIST"] = nil --ENGLISH: Config-ID does not exist.
LANGUAGE["WARNING_ERROR_TYPENOTEXIST"] = nil --ENGLISH: Blacklist type does not exist
LANGUAGE["WARNING_ERROR_SQLERROR"] = nil --ENGLISH: MySQL/SQLite Error

--[[-------------------------------------------------------------------------
Blacklist specific translations.
---------------------------------------------------------------------------]]
LANGUAGE["BLACKLIST_GRAVGUN"] = "Vous n'êtes pas autorisé à utiliser le Gravity Gun car vous êtes sur la liste noire !"
LANGUAGE["BLACKLIST_TEAM"] = "Vous n'êtes pas autorisé à faire ce job car vous êtes sur la liste noire !"
LANGUAGE["BLACKLIST_OOC"] = "Vous n'êtes pas autorisé à utiliser le chat OOC car vous êtes sur la liste noire !"
LANGUAGE["BLACKLIST_PHYSGUN"] = "Vous n'êtes pas autorisé à utiliser le Physics Gun car vous êtes sur la liste noire !"
LANGUAGE["BLACKLIST_PROPS"] = "Vous n'êtes pas autorisé à spawn des props ou entités car vous êtes sur la liste noire !"
LANGUAGE["BLACKLIST_TOOLGUN"] = "Vous n'êtes pas autorisé à utiliser le Tool Gun car vous êtes sur la liste noire !"
LANGUAGE["BLACKLIST_WEAPONS"] = "Vous n'êtes pas autorisé à utiliser les armes car vous êtes sur la liste noire !"
LANGUAGE["BLACKLIST_VEHICLES"] = "Vous n'êtes pas autorisé à conduire les véhicules car vous êtes sur la liste noire !"
LANGUAGE["BLACKLIST_WIREMOD"] = "Vous n'êtes pas autorisé à utiliser le Wiremod car vous êtes sur la liste noire !"
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
LANGUAGE["BLACKLIST_NLR"] = "Vous devez attendre %T minutes avant de respawn car vous êtes sur la liste noire !"

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