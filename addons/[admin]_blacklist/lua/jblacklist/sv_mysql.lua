--[[-------------------------------------------------------------------------
MySQL Config (Configurated here for security purposes)
---------------------------------------------------------------------------]]

--Should we use MySQL for storage. (false/true)
jBlacklist.UseSQL = false

--The host of the MySQL server.
local SQLHost = ""

--The port of the MySQL server.
local SQLPort = 3306

--The database we want to store our information in.
local SQLDatabase = ""

--The username we want to use to login to the database.
local SQLUsername = ""

--The password we want to use to login to then database.
local SQLPassword = ""

--[[-------------------------------------------------------------------------
Start Loading MySQL stuff.
---------------------------------------------------------------------------]]

--Stop loading of MySQL if disabled.
if jBlacklist.UseSQL == false then return end

--Print to console.
jBlacklist.ConNotify("INFO", "Loading MySQLoo module...")

--Check if the MySQLoo module is installed.
if !file.Exists("bin/gmsv_mysqloo_*","LUA") then
	jBlacklist.ConNotify("ALERT", "Failed to load MySQLoo module! Make sure you have installed the MySQLoo DLL correctly!")
	jBlacklist.ConNotify("INFO", "The MySQLoo module can be downloaded from https://facepunch.com/showthread.php?t=1515853 or be installed directly from some server control panels.")
	return
end

--Load the mysqloo module.
require ("mysqloo")

--Check if we loaded the module successfully.
if !mysqloo then
	jBlacklist.ConNotify("ALERT", "Failed to load MySQLoo module! Make sure you have installed the MySQLoo DLL correctly!")
	jBlacklist.ConNotify("INFO", "The MySQLoo module can be downloaded from https://facepunch.com/showthread.php?t=1515853 or be installed directly from some server control panels.")
	return
else
	jBlacklist.ConNotify("INFO", "Successfully loaded the MySQLoo module.")
end

--[[-------------------------------------------------------------------------
Create functions.
---------------------------------------------------------------------------]]

--Create function to escape a string.
function jBlacklist.Escape( str )

	--Check if we are conneected with the MySQL server.
	if !jBlacklist.MySQLDatabase then
		jBlacklist.ConNotify("ALERT", "Tried escaping string while not connected to MySQL server.")
		return ""
	elseif jBlacklist.MySQLDatabase:status() == mysqloo.DATABASE_NOT_CONNECTED then
		return ""
	end

	--Return the escaped string.
	return jBlacklist.MySQLDatabase:escape(str)

end

function jBlacklist.SQLQuery( Query, onSuccess, onError )

	--Make sure we got onSuccess and onError.
	onSuccess = onSuccess or function(  ) end
	onError = onError or function(  ) end

	--Check if we are connected with the server.
	if !jBlacklist.MySQLDatabase then

		--Try to reconnect to the MySQL server.
		jBlacklist.ConnectToMySQL( )

		onError(_, "Server is not connected to the MySQL server.. Trying to establishing new connection..")

		--Return.
		return

	end

	--GEt the status of the MySQL database connection.
	local databaseStatus = jBlacklist.MySQLDatabase:status()

	--Check if we are not connected or if a INTERNAL_ERROR have occurred. (mysqloo.DATABASE_INTERNAL_ERROR enum is bugged....)
	if databaseStatus == mysqloo.DATABASE_NOT_CONNECTED or databaseStatus == 3 then

		--Call the onerror function.
		onError(_, "Server is not connected to the MySQL server.. Trying to establishing new connection..")

		--Try to reconnect to the MySQL server.
		jBlacklist.ConnectToMySQL( )

		--Return.
		return

	end

	if databaseStatus == mysqloo.DATABASE_CONNECTING then

		--Call the onerror function.	
		onError(_, "Server is currently connecting to the MySQL server.")

		--Return.
		return

	end

	--Create SQLquery.
	local SQLquery = jBlacklist.MySQLDatabase:query(Query)

	--Create onSuccess function.
	SQLquery.onSuccess = onSuccess or function( ) end

	--Create onError function.
	SQLquery.onError = onError or function( ) end

	--Start the SQLquery.
	SQLquery:start()

	--Return the SQLquery.
	return SQLquery

end

--Create a function to perform a connection to the MySQL server.
function jBlacklist.ConnectToMySQL( )

	--Close current connection if one is already established.
	if jBlacklist.MySQLDatabase and jBlacklist.MySQLDatabase:status() == mysqloo.DATABASE_CONNECTED then
		jBlacklist.ConNotify("INFO", "Closing current MySQL server connection.")
		jBlacklist.MySQLDatabase:disconnect()
	end

	--Print to console that we are trying to establish a connection.
	jBlacklist.ConNotify("INFO", "Trying to establish a connection to the MySQL server.")

	--Create a connection.
	jBlacklist.MySQLDatabase = mysqloo.connect( SQLHost, SQLUsername, SQLPassword, SQLDatabase, SQLPort)

	--Make the MySQL database reconnect if connection is lost.
	jBlacklist.MySQLDatabase:setAutoReconnect(true)

	--Create a onConnected function.
	jBlacklist.MySQLDatabase.onConnected = function()

		--Notify the server owner that we successfully connected to the MYSQL Server.
		jBlacklist.ConNotify("INFO", "Successfully established a connection to the MySQL server.")

		--Create the table that will store all blacklists.
		jBlacklist.SQLQuery( [[CREATE TABLE IF NOT EXISTS jblacklist_blacklists
			(
			ID MEDIUMINT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
			STEAMID64 TEXT NOT NULL,
			TYPE TEXT NOT NULL,
			REASON TEXT NOT NULL,
			TIME INT NOT NULL,
			DATE INT NOT NULL,
			LASTUPDATE INT NOT NULL,
			ADMINID TEXT NOT NULL
			) DEFAULT CHARSET=utf8]])

	end

	--Create a onConnectionFailed function.
	jBlacklist.MySQLDatabase.onConnectionFailed = function(_, error)

		jBlacklist.ConNotify("ALERT", "Failed to establish a connection to the MySQL server. (Check your connection details in the sv_mysql.lua file)")

		jBlacklist.ConNotify("ERROR", error)

	end

	--Try to establish the connection
	jBlacklist.MySQLDatabase:connect()

end

--Connect to the MySQL server.
jBlacklist.ConnectToMySQL( )