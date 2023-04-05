
if (CLIENT) then
	ui = ui or {}
end

dash.IncludeCL 'ui/colors.lua'
dash.IncludeCL 'ui/util.lua'
dash.IncludeCL 'ui/theme.lua'

local files, _ = file.Find('ui/controls/*.lua', 'LUA')
for k, v in ipairs(files) do
	dash.IncludeCL('ui/controls/' .. v)
end

os 				= os or {}
PLAYER 			= FindMetaTable('Player')


os.include_sv 	= (SERVER) and include or function() end
os.include_cl 	= (SERVER) and AddCSLuaFile or include
os.include_sh 	= function(path) os.include_sv(path) os.include_cl(path) end
os.include 		= function(f)
	if string.find(f, '_sv.lua') then
		os.include_sv(f)
	elseif string.find(f, '_cl.lua') then
		os.include_cl(f)
	else
		os.include_sh(f)
	end
end
os.include_dir 	= function(dir)
	local fol = 'orbital/' .. dir .. '/'
	local files, folders = file.Find(fol .. '*', 'LUA')
	for _, f in ipairs(files) do
		os.include(fol .. f)
	end
	for _, f in ipairs(folders) do
		os.include_dir(dir .. '/' .. f)
	end
end

function os.print(...)
	return MsgC(Color(155,0,255), '[ORBITAL] ', Color(255,255,255), ... .. '\n')
end

os.include_sh('orbital/core/core_init.lua')

local msg = {
	'\n',
[[   __   ___       _     _ _        _  __]],
[[  / /  / _ \ _ __| |__ (_) |_ __ _| | \ \ ]],
[[ / /  | | | | '__| '_ \| | __/ _` | |  \ \]],
[[ \ \  | |_| | |  | |_) | | || (_| | |  / /]],
[[  \_\  \___/|_|  |_.__/|_|\__\__,_|_| /_/ ]],                                        
	'\n',
}

for _, l in ipairs(msg) do
	MsgC(color_white, l .. '\n')
end

hook.Call('osAdmin_Loaded', os)