--Check if we want to use MySQL or SQLite.
if jBlacklist.UseSQL == true then return end

--Create a function to escape strings.
function jBlacklist.Escape(str)
	return sql.SQLStr(str,true)
end

--Create function to perform a SQLite query.
function jBlacklist.SQLQuery( Query, onSuccess, onError )

	--Make sure we got onSuccess and onError.
	onSuccess = onSuccess or function( ) end
	onError = onError or function( ) end

	--Perform the query.
	local result = sql.Query( Query )

	--Check if the result is empty.
	if result == nil then

		--Call onSuccess with a empty table as argument.
		onSuccess(_, {})

	--Check if the query failed.
	elseif result == false then

		--Call onError func with the error as argument.
		onError(_, sql.LastError())

	--If the query succeeded.
	else

		--Call onSuccess func with result as argument.
		onSuccess(_, result)

	end

end

--Check if SQLite table exist.
if !sql.TableExists("jblacklist_blacklists") then

	--Create table.
	jBlacklist.SQLQuery( [[CREATE TABLE jblacklist_blacklists
			(
			ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
			STEAMID64 TEXT NOT NULL,
			TYPE TEXT NOT NULL,
			REASON TEXT NOT NULL,
			TIME INTEGER NOT NULL,
			DATE INTEGER NOT NULL,
			LASTUPDATE INTEGER NOT NULL,
			ADMINID TEXT NOT NULL
			)]] )

end