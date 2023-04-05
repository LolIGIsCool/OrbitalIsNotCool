RK = RK or {}
RK.Data = RK.Data or {}
RK.Data.stored = RK.Data.stored or {}

file.CreateDir("rk_core")

function RK.Data:Set(key, value, bIgnoreMap)
	local path = "rk_core/" .. bIgnoreMap and "" or ( game.GetMap() .. "/" )

	file.CreateDir(path)
	file.Write(path .. key .. ".txt", util.TableToJSON({value}))

	self.stored[key] = value

	return path
end

function RK.Data:Get(key, default, bIgnoreMap, bRefresh)
	if (!bRefresh) then
		local stored = self.stored[key]

		if (stored != nil) then
			return stored
		end
	end

	local path = "rk_core/" .. ( bIgnoreMap and "" or game.GetMap() .. "/" )
	local contents = file.Read(path .. key .. ".txt", "DATA")

	if (contents and contents != "") then
		local status, decoded = pcall(util.JSONToTable, contents)

		if (status and decoded) then
			local value = decoded[1]

			if (value != nil) then
				return value
			end
		end
	end

	return default
end

function RK.Data:Delete(key, bIgnoreMap)
	local path = "rk_core/" .. ( bIgnoreMap and "" or game.GetMap() .. "/" )
	local contents = file.Read(path .. key .. ".txt", "DATA")

	if (contents and contents != "") then
		file.Delete(path .. key .. ".txt")
		self.stored[key] = nil
		return true
	end

	return false
end