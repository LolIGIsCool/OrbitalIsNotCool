function string:StartsWith(str)
	return (self:sub(1, str:len()) == str)
end

os.http = {
	Queue = {
		Get = {},
		Post = {},
	},
	Endpoint = 'https://orbitalservers.gg/server_scripts/'
}

local HTTP = HTTP
function os.http.Fetch(path, onSuccess, onFailure)
	HTTP {
		url			= path:StartsWith('http') and path or (os.http.Endpoint .. path),
		method		= 'get',
		headers		= {
			--SteamID64 = LocalPlayer():SteamID64(),
		},
		success = function(code, body, headers)
			if (code == 401) then
				if onFailure then
					onFailure('Unauthorized')
				end
			elseif onSuccess then
				onSuccess(body, body:len(), headers, code)
			end
		end,
		failed = function(err)
			if onFailure then
				onFailure(err)
			end
		end
	}
end

function os.http.Post(url, params, onSuccess, onFailure)
	HTTP {
		url			= path:StartsWith('http') and path or (os.http.Endpoint .. path),
		method		= 'post',
		parameters	= params,
		headers		= {
		--	SteamID64 = LocalPlayer():SteamID64(),
		},
		success = function(code, body, headers)
			if (code == 401) then
				if onFailure then
					onFailure('Unauthorized')
				end
			elseif onSuccess then
				onSuccess(body, body:len(), headers, code)
			end
		end,
		failed = function(err)
			if onFailure then
				onFailure(err)
			end
		end
	}
end

function os.http.FetchJson(path, onSuccess, onFailure)
	os.http.Fetch(path, function(body, len, headers, code)
		local data = util.JSONToTable(body)
		if data and (data.success != false) then
			onSuccess(data.response or data, len, headers, code)
		else
			if onFailure then
				onFailure((data and data.success) and data.message or 'Invald Json')
			end
		end
	end, onFailure, noQueue)
end

-- this is really hacky, make this not needed one of these days!
http._Fetch = http._Fetch or http.Fetch
function http.Fetch(url, onSuccess, onFailure, headers)
	if url:StartsWith(os.http.Endpoint) then
		os.http.Fetch(url, onSuccess, onFailure)
	end
	http._Fetch(url, onSuccess, onFailure, headers)
end

http._Post = http._Post or http.Post
function http.Post(url, parameters, onSuccess, onFailure, headers)
	if url:StartsWith(os.http.Endpoint) then
		os.http.Post(url, parameters, onSuccess, onFailure)
	end
	http._Post(url, parameters, onSuccess, onFailure, headers)
end

