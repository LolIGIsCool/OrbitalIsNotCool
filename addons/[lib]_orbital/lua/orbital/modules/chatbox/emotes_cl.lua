os.chatEmotes = os.chatEmotes or {}
local function addExtraEmoji(name,url)
	local em = ':' .. name .. ':'
	os.chatEmotes[em] = {
		name = em,
		loadUrl = url,
		mat = false
	}
end

local function loadEmotesList(data)

	addExtraEmoji("nerd","https://twemoji.maxcdn.com/v/latest/72x72/1f913.png") -- nerd emoji
	addExtraEmoji("pleading","https://twemoji.maxcdn.com/v/latest/72x72/1f97a.png") -- pleading emojid
	addExtraEmoji("trollge","https://cdn3.emoji.gg/emojis/6785_trollge.png") -- trollege
	addExtraEmoji("why","https://cdn3.emoji.gg/emojis/3708_why_god_why.png") -- why god
	addExtraEmoji("sinister","https://twemoji.maxcdn.com/v/latest/72x72/1f9d1-1f3ff-200d-1f9b1.png") -- sinister black guy
	addExtraEmoji("duck","https://twemoji.maxcdn.com/v/latest/72x72/1f986.png") -- duck
	addExtraEmoji("kekw","https://cdn3.emoji.gg/emojis/8151-kekw.png") -- kekw
	addExtraEmoji("mythic","https://twemoji.maxcdn.com/v/latest/72x72/1f468-1f3fd-200d-2764-fe0f-200d-1f468-1f3fe.png") -- mythic
	addExtraEmoji("terra","https://twemoji.maxcdn.com/v/latest/72x72/1f468-1f3fe-200d-1f9b1.png") -- terra
	addExtraEmoji("lipbite","https://twemoji.maxcdn.com/v/latest/72x72/1fae6.png") -- lipbite
	addExtraEmoji("julian","https://i.imgur.com/3GjrjS3.png") -- some retarded shit gladys wanted added
	addExtraEmoji("gladys","https://twemoji.maxcdn.com/v/latest/72x72/1f1f9-1f1f7.png") -- mythic
	
	for _, emojiSet in pairs(data) do
		for k, v in pairs(emojiSet.Emotes) do
			local em = ':' .. k .. ':'
			os.chatEmotes[em] = {
				name = em,
				loadUrl = string.Replace(emojiSet.ImageUrl, '{item_id}', tostring(v)),
				mat = false
			}
		end
	end
end

local function fetchEmotes()
	local cacheFile = 'orbital/emotes.dat'

	os.http.FetchJson('emotes.json', function(data)
		loadEmotesList(data)

		file.Write(cacheFile, pon.encode(data))
	end, function()
		if file.Exists(cacheFile, 'DATA') then
			loadEmotesList(pon.decode(file.Read(cacheFile, 'DATA')))
		end
	end)
end
hook('InitPostEntity', 'os.emotes.InitPostEntity', fetchEmotes)
fetchEmotes()

