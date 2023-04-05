util.AddNetworkString 'os.NotifyString'
util.AddNetworkString 'os.NotifyTerm'

function os.notify(recipients, msg, ...)
	if isstring(msg) then
		net.Start('os.NotifyString')
			net.WriteBit(0)
			os.WriteMsg(msg, ...)
		net.Send(recipients)
	else
		net.Start('os.NotifyTerm')
			net.WriteBit(0)
			os.WriteTerm(msg, ...)
		net.Send(recipients)
	end
end

function os.notify_err(recipients, msg, ...)
	if isstring(msg) then
		net.Start('os.NotifyString')
			net.WriteBit(1)
			os.WriteMsg(msg, ...)
		net.Send(recipients)
	else
		net.Start('os.NotifyTerm')
			net.WriteBit(1)
			os.WriteTerm(msg, ...)
		net.Send(recipients)
	end
end

function os.notify_all(msg, ...)
	if isstring(msg) then
		net.Start('os.NotifyString')
			net.WriteBit(0)
			os.WriteMsg(msg, ...)
		net.Broadcast()
	else
		net.Start('os.NotifyTerm')
			net.WriteBit(0)
			os.WriteTerm(msg, ...)
		net.Broadcast()
	end
end

function os.notify_staff(msg, ...)
	if isstring(msg) then
		net.Start('os.NotifyString')
			net.WriteBit(0)
			os.WriteMsg(msg, ...)
		net.Send(os.GetStaff())
	else
		net.Start('os.NotifyTerm')
			net.WriteBit(0)
			os.WriteTerm(msg, ...)
		net.Send(os.GetStaff())
	end
end