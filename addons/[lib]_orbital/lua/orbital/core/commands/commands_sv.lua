util.AddNetworkString('os.RunCommand')

function os.cmd.RunCommand(pl, cmd, args)
	cmd = cmd:lower()

	local is_player = os.IsPlayer(pl) and not pl:IsListenServerHost()
	local cancmd, err = (is_player and os.Call('playerCanRunCommand', pl, cmd) or true)

	if not cancmd and err then
		os.notify_err(pl, err)
	elseif not os.cmd.Exists(cmd) then
		os.notify_err(pl, os.Term('InvalidCommand'), cmd)
	else
		cmd = os.cmd.Get(cmd)
		local name = cmd:GetName()
		local flag = cmd:GetFlag()

		if is_player and not pl:HasFlag(flag) then
			os.notify_err(pl, os.Term('NeedFlagToUseCommand'), flag:upper(), name)
		else
			if not os.cmd.Parse(pl, name, args) then return end
			os.Call('playerRunCommand', pl, name, args)
			cmd:Init(pl, args)
		end
	end
end

function os.cmd.PlayerSay(pl, text)
	if not text[1] then return end
	text = string.Trim(text)
	if (text[1] == '!') or (text[1] == '/') then
		text = string.sub(text, 2)
		local args = os.str.ExplodeQuotes(text)
		local cmd = table.remove(args, 1)
		if (cmd == nil) then return end
		os.cmd.RunCommand(pl, cmd, args)
		return ''
	end
end
hook.Add('PlayerSay', 'os.cmd.PlayerSay', os.cmd.PlayerSay)

function os.cmd.ConCommand(pl, cmd, args)
	if not args[1] then return end
	local cmd = args[1]
	table.remove(args, 1)

	for k, v in ipairs(args) do
		if (string.upper(tostring(v)) == 'STEAM_0') and (args[k + 4]) then
			args[k] = table.concat(args, '', k, k + 4)
			for i = 1, 4 do
				table.remove(args, k + 1)
			end
			break
		end
	end

	os.cmd.RunCommand(pl, cmd, args)
end
concommand.Add('_os', os.cmd.ConCommand)



