local MODULE = MODULE or RK.Modules:Get( "zones" )

-- hook.Add("PostDrawTranslucentRenderables", "DrawZones:Testing", function()
-- 	if !LocalPlayer():IsAdmin() then return end

-- 	for k, v in pairs( RK.Zones:Get( game.GetMap(), {} ) ) do

-- 		if !v.position then continue end

-- 		local pos = v["position"][1] -- position to render box at
-- 		local pos2 = v["position"][2] -- position to render box at
-- 		local x = ( pos - pos2 )

-- 		render.SetColorMaterial() -- white material for easy coloring

-- 		cam.IgnoreZ( true ) -- makes next draw calls ignore depth and draw on top
-- 		render.DrawBox( pos, angle_zero, Vector( 0, 0, 0 ), -x, Color( util.SharedRandom( k, 0, 255 ), util.SharedRandom( k, 0, 255, 1 ), util.SharedRandom( k, 0, 255, 2 ), 75 ) ) -- draws the box 
-- 		cam.IgnoreZ( false ) -- disables previous call
-- 	end
-- end )