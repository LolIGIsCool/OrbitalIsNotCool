local notify_types = {
	[0] = Color(150, 0, 250),
	[1] = Color(255, 0, 0),
}

net.Receive('os.NotifyString', function(len)
	chat.AddText(notify_types[net.ReadBit()], '| ', unpack(os.ReadMsg()))
end)


net.Receive('os.NotifyTerm', function(len)
	chat.AddText(notify_types[net.ReadBit()], '| ', unpack(os.ReadTerm()))
end)

