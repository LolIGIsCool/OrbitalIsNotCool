local surface_CreateFont = surface.CreateFont
RK = RK or {}

RK.Font = RK.Fonts or {}

-- "Star Jedi", "Aurebesh", "Bahnschrift SemiLight Condensed"

function RKFont( num, fontOveride )
	local num = tostring( num )
	local font = fontOveride and fontOveride or "Star Jedi"
	local font_nice = string.Replace( font:lower(), " ", "_" )

	if not RK.Font[ font_nice .. num ] then
		surface_CreateFont( "RK.Font." .. font_nice .. num, { size = tonumber( num ), weight = 800, font = font } )
		RK:Print( "Font Created: RK.Font." .. font_nice .. num )
		RK.Font[ font_nice .. num ] = true
	end

	return "RK.Font." .. font_nice .. num
end

function GM:PostDrawViewModel( vm, ply, weapon )

	if ( weapon.UseHands or !weapon:IsScripted() ) then
		local hands = LocalPlayer():GetHands()
		if ( IsValid( hands ) ) then hands:DrawModel() end

	end

end

function GM:SpawnMenuOpen()
    if ( LocalPlayer():IsAdmin() ) then
        return true
    else
        return false
    end
end

function GM:DrawDeathNotice()
	return false
end

include( "shared.lua" )