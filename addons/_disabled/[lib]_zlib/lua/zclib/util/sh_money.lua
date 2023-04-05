zclib = zclib or {}
zclib.Money = zclib.Money or {}

if SERVER then
	function zclib.Money.Give(ply, money)
		if money <= 0 then return end
			ply:AddMoney(money, "zclib add money")
	end
end

	function zclib.Money.Take(ply, money)
		if money <= 0 then return end
			ply:AddMoney(-money, "zclib take money")
	end


// Return how much money the player has
function zclib.Money.Get(ply)
		return ply:GetMoney() or 0
end


function zclib.Money.Has(ply, money)

	return ply:CanAfford(money)

end

// Returns the formated money as string
function zclib.Money.Format(money)
	if not money then return "0" end
	money = tostring(math.abs(money))
	local sep = ","
	local dp = string.find(money, "%.") or #money + 1

	for i = dp - 4, 1, -3 do
		money = money:sub(1, i) .. sep .. money:sub(i + 1)
	end

	return money
end

function zclib.Money.Display(money)
	if not zclib.config.CurrencyInvert then
		return zclib.config.Currency .. zclib.Money.Format(money)
	else
		return zclib.Money.Format(money) .. zclib.config.Currency
	end
end
