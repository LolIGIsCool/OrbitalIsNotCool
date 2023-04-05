local string = _G.string
local draw = _G.draw

function string.LUpper( str )
	str = tostring( str )
	return str:gsub("^%l", string.upper )
end

if SERVER then return end

function draw.DrawGhostText( symbol, length, text, font, x, y, col, align_x, align_y )

	local text = tostring( text )

	local color2 = table.Copy( col )
	local alpha_mult = CurTime() % 1
	if alpha_mult > 0.5 then
		alpha_mult = 1 - alpha_mult
	end
	color2.a = 25 * alpha_mult

	local str = ""
	for i = 1, length do
		str = str .. symbol
	end

	local text_len = string.len( text )

	if text_len < length then
		str = string.sub( str, 1, length - text_len )
	end
	if text_len >= length then
		str = ""
	end

	surface.SetFont( font )
	local size_w, size_y = surface.GetTextSize( str .. text )
	if align_x == TEXT_ALIGN_RIGHT then
		local w, h = draw.SimpleTextOutlined( text, font, x, y, col, align_x, align_y, 1.8, color2 )
		draw.SimpleText( str, font, x - w, y, Color( 200, 200, 200, 50 ), align_x, align_y )
		return size_w, size_y
	end
	if align_x == TEXT_ALIGN_CENTER then
		local x1 = x - surface.GetTextSize( str ) * 0.5
		local x2 = x + surface.GetTextSize( text ) * 0.5

		draw.SimpleText( str, font, x1, y, Color( 200, 200, 200, 50 ), align_x, align_y )
		draw.SimpleTextOutlined( text, font, x2, y, col, align_x, align_y, 1.8, color2 )
		return size_w, size_y
	end

	local w, h = draw.SimpleText( str, font, x, y, Color( 200, 200, 200, 50 ), align_x, align_y )
	local w2, h2 = draw.SimpleTextOutlined( text, font, x + w, y, col, align_x, align_y, 1.8, color2 )

	return size_w, size_y
end