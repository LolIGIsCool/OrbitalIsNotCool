--Create a table to store all hooks in.
local Hooks = {}

--Create a function to add new hooks.
function jBlacklist.AddHook( eventName, identifier, func )

	--Create the hook subTable if it doesn't exist.
	Hooks[eventName] = Hooks[eventName] or {}

	--Add the hook.
	Hooks[eventName][identifier] = func

end

--Create a function to remove hooks.
function jBlacklist.RemoveHook( eventName, identifier )

	--Make sure the subtable exist.
	if !Hooks[eventName] then return end

	--Remove the hook.
	Hooks[eventName][identifier] = nil

end

--Create a function to get the HookTable.
function jBlacklist.GetHookTable(  )
	return Hooks
end

--[[-------------------------------------------------------------------------
Inject into hook.Call
---------------------------------------------------------------------------]]

timer.Simple(1,function(  )

	--Save a copy of the hook.Call function.
	local hook_call = hook.Call

	--The Hook.Call in the registry doesn't seem to be used for non GM hooks.
	hook.Call = function( eventName, gamemodeTable, ... )

		--Check if our Hook-System has the current hook.
		if Hooks[eventName] then

			--Create a variable that will hold what we will return.
			local toReturn = {}

			--Loop through our hooks.
			for k,v in pairs(Hooks[eventName]) do
						
				--Set toReturn to the values returned.
				local returned = {v(...)}

				if #returned != 0 then toReturn = returned end

			end

			--Check if we have anything to return.
			if #toReturn != 0 then
				return unpack(toReturn)
			end

		end

		--Call and return the value from the old function.
		return hook_call(eventName, gamemodeTable, ...)

	end

	--Search in the registry for the hook.Call function.
	for k,v in pairs(debug.getregistry()) do

		--Check if we found it.
		if v == hook_call then
	
			--Make a copy of the old function.
			local oldCall = v
	
			--Override the function in the registry.
			debug.getregistry()[k] = function( eventName, gamemodeTable, ... )
	
				--Check if our Hook-System has the current hook.
				if Hooks[eventName] then

					--Create a variable that will hold what we will return.
					local toReturn = {}

					--Loop through our hooks.
					for k,v in pairs(Hooks[eventName]) do
						
						--Set toReturn to the values returned.
						local returned = {v(...)}

						if #returned != 0 then toReturn = returned end

					end

					--Check if we have anything to return.
					if #toReturn != 0 then
						return unpack(toReturn)
					end

				end

				--Call and return the value from the old function.
				return oldCall(eventName, gamemodeTable, ...)

			end

		end

	end
	
end)

