if SERVER then return end
zclib = zclib or {}
zclib.MiniMap = zclib.MiniMap or {}

/*

    Modified version of MG Factions MiniMap

*/

local nextopen = 0
local drag_spd = 2
local scroll_spd = 0.2
local max_map_size = 32768
local map_maxz
local sizemult = {0.6, 0.8}
local windowsize = {ScrW() * sizemult[1], ScrH() * sizemult[2]}
local viewmult = math.Clamp(1, 0.5, 3)
local circle32_mat = Material("zerochain/zerolib/ui/circle_32.png", "smooth ignorez")

local function DrawOutlineCircle(x, y, w, h, color, rot)
    surface.SetMaterial(circle32_mat)

    surface.SetDrawColor(color_black)
    surface.DrawTexturedRectRotated(x, y, w / viewmult, h / viewmult, rot)

    surface.SetDrawColor(color)
    surface.DrawTexturedRectRotated(x, y, (w - 2) / viewmult, (h - 2) / viewmult, rot)
end

function zclib.MiniMap.Setup(data)

	local minimap

    local function MiniMap_Open()
        if IsValid(minimap) then minimap:Remove() end

        local ply = LocalPlayer()
        local ang = Angle(0, 0, 0)

        windowsize = {ScrW() * sizemult[1], ScrH() * sizemult[2]}

        viewmult = math.Clamp(data.config.MiniMapDefaultZoom, data.config.MiniMapMinZoom, data.config.MiniMapMaxZoom)
        minimap = vgui.Create("DPanel")
        minimap:SetSize(windowsize[1], windowsize[2])
        minimap:Center()
        minimap:MakePopup()
        minimap:ParentToHUD()

        // Enable movement via keyboard
        if data.config.MiniMapMovement then
            minimap:SetKeyboardInputEnabled(false)
        end

        minimap.MousePosX = 0
        minimap.MousePosY = 0
        minimap.OffsetVector = Vector(0, 0, 0)
        minimap.LockedOnPlayer = true
        local ready = false

        minimap.Think = function(self)
            // Close mechanic
            if data.config.MiniMapButton and (input.IsKeyDown(data.config.MiniMapButton) or input.IsKeyDown(KEY_ESCAPE)) then
                if not ready then return end
                self:Remove()
                nextopen = SysTime() + 0.1

                return
            else
                ready = true
            end

            // Drag logic
            if not self:IsHovered() then return end
            local mx, my = input.GetCursorPos()
            local tb = self:GetTable()

            if input.IsMouseDown(MOUSE_LEFT) then
                if not tb.LM then
                    tb.LM = true
                else
                    local nx, ny = tb.MousePosX - mx, tb.MousePosY - my
                    self:StopLock()
                    tb.OffsetVector.x = tb.OffsetVector.x - (ny * viewmult * drag_spd)
                    tb.OffsetVector.y = tb.OffsetVector.y - (nx * viewmult * drag_spd)
                end
            else
                tb.LM = false
            end

            tb.MousePosX, tb.MousePosY = mx, my
        end

        // Scrolling in and out
        minimap.OnMouseWheeled = function(self, scroll)
            viewmult = math.Clamp(viewmult - (scroll * scroll_spd), data.config.MiniMapMinZoom, data.config.MiniMapMaxZoom)
        end

        // Caching the view table
        minimap.viewdata = {
            w = minimap:GetWide() - 20,
            h = minimap:GetTall() - 50,
            drawviewmodel = false,
            drawhud = false,
            drawmonitors = false,
            bloomtone = false
        }

        // Get view pos
        minimap.GetViewPos = function(self)
            local tb = self:GetTable()

            return tb.LockedOnPlayer and ply:EyePos() or Vector(tb.LockPos.x, tb.LockPos.y, tb.LockPos.z)
        end

        // Get view angle
        minimap.GetViewAng = function(self) return ang end

        // Stop locking the view to the player
        minimap.StopLock = function(self)
            if self.LockedOnPlayer then
                self.LockedOnPlayer = false
                self.LockPos = ply:EyePos()
            end
        end

        // Cache max map height
        minimap.GenerateMaxHeight = function()
            if not map_minz or not map_maxz then
                local _, maxs = game.GetWorld():GetRenderBounds()
                map_maxz = maxs.z
            end
        end

        // Get max map height
        minimap.GetMaxHeight = function()
            minimap.GenerateMaxHeight()

            return map_maxz
        end

        // Function for converting something from 3D to 2D.
        minimap.To2D = function(self, pos, campos)
            local w, h = self:GetWide() / 2, self:GetTall() / 2

            return w + ((campos.y - pos.y) / viewmult) / 2, h + ((campos.x - pos.x) / viewmult) / 2
        end

        // Draw player(s)
        minimap.DrawPlayer = function(self, aply, campos, aang)
            local x, y = self:To2D(aply:GetPos(), campos + self.OffsetVector, aang)
            y = y + 10
            DrawOutlineCircle(x, y, 32, 32, zclib.colors["orange01"], aang.y)
            draw.SimpleTextOutlined(ply:Name(), zclib.GetFont("zclib_font_small"), x, y, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black)
        end

        // Painting the view
        minimap.Paint = function(self, w, h)
            draw.RoundedBox(5, 0, 0, w, h, zclib.colors["ui02"])
            draw.SimpleText("Mini Map", zclib.GetFont("zclib_font_big"), 10 * zclib.wM, 1 * zclib.hM, zclib.colors["text01"], TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
            local tb = self:GetTable()
            local campos = minimap:GetViewPos()
            local aang = minimap:GetViewAng()

            // Make a trace to check for the current max height
            local trace = util.TraceLine({
                start = campos,
                endpos = campos + Vector(0, 0, max_map_size),
                filter = ply
            })

            local max_z = self.GetMaxHeight() // Get max height of current map
            campos.z = max_z
            local znear = max_z - trace.HitPos.z

            local viewdata = minimap.viewdata
            viewdata.origin = campos + tb.OffsetVector
            viewdata.znear = znear
            viewdata.zfar = max_map_size
            viewdata.angles = Angle(90, 0, 0)

            local x, y = self:GetPos()
            viewdata.x = x + 10
            viewdata.y = y + 40

            // Setup ortho view
            viewdata.ortho = {
                top = -viewdata.h * viewmult,
                bottom = viewdata.h * viewmult,
                left = -viewdata.w * viewmult,
                right = viewdata.w * viewmult
            }

            // Some parameters to optimise the ongoing render view
            render.SuppressEngineLighting(true)
            render.SetShadowsDisabled(true)
            render.PushFlashlightMode(false)
			local old = DisableClipping( true )
            render.RenderView(viewdata)
			DisableClipping( old )
            render.PopFlashlightMode()
            render.SetShadowsDisabled(false)
            render.SuppressEngineLighting(false)
            // Cut off text outside of the rendered view.
            render.SetScissorRect(viewdata.x, viewdata.y, viewdata.x + viewdata.w, viewdata.y + viewdata.h, true)

            pcall(data.OnDraw,minimap,campos,aang,viewmult)

            // Draw local player
            self:DrawPlayer(ply, campos, aang)

            // Show other players
            if not data.config.HidePlayers then
                for _, v in ipairs(player.GetAll()) do
                    if ply ~= v and v:GetNoDraw() then continue end
                    self:DrawPlayer(v, campos, aang)
                end
            end

            render.SetScissorRect(0, 0, 0, 0, false)
            draw.SimpleTextOutlined("Drag mouse: Adjust position", zclib.GetFont("zclib_font_mediumsmall_thin"), 15, h - 50, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, color_black) // Print instructions
            draw.SimpleTextOutlined("Scroll: Zoom", zclib.GetFont("zclib_font_mediumsmall_thin"), 15, h - 30, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, color_black)
        end

        if not data.config.HideLockOnPlayer then
            local x = zclib.util.GetTextSize("Lock on player", zclib.GetFont("zclib_font_medium"))

            local btn = zclib.vgui.TextButton(0, 0, x + 50, 40, minimap, {
                Text01 = "Lock on player",
                txt_font = zclib.GetFont("zclib_font_medium")
            }, function()
                // Reset everything and lock the view to the player again
                minimap.LockedOnPlayer = true
                minimap.OffsetVector = Vector(0, 0, 0)
            end, function() return false end, function() return false end)

            btn:Dock(RIGHT)
            btn:DockMargin(0, 670, 15, 15)
        end
    end

    // Open the mini map with pressing a button
    if data.config.MiniMapButton then
        zclib.Hook.Remove("PlayerButtonDown", "zclib_MiniMap")
        zclib.Hook.Add("PlayerButtonDown", "zclib_MiniMap", function(ply, button)
            if data.config.MiniMapButton ~= button or nextopen > SysTime() then return end
            if not IsFirstTimePredicted() then return end
            if ply ~= LocalPlayer() or ply:IsTyping() then return end
			if IsValid(minimap) then
				minimap:Remove()
			else
				MiniMap_Open()
			end
        end)
    end

    // Open the mini map with a command
    if data.config.MiniMapCommand then
        zclib.Hook.Remove("OnPlayerChat", "zclib_MiniMap")
        zclib.Hook.Add("OnPlayerChat", "zclib_MiniMap", function(ply, text)
            if data.config.MiniMapCommand and data.config.MiniMapCommand ~= "" and string.lower(text) == data.config.MiniMapCommand then
                if ply ~= LocalPlayer() then return true end
                MiniMap_Open()

                return true
            end
        end)
    end
end


/*

zclib.MiniMap.Setup({
	config = {
		MiniMapCommand = "!minimap",
		MiniMapButton = KEY_M,
		MiniMapDefaultZoom = 1,
		MiniMapMinZoom = 0.5,
		MiniMapMaxZoom = 3,
		MiniMapMovement = true,
		HideLockOnPlayer = false,
		HidePlayers = false
	},
	OnDraw = function(minimap, campos, aang, viewmult)

		// Draw some resource entities on the map
		for _, v in ipairs(ents.FindByClass("zmb_resource")) do
			if not IsValid(v) then continue end
			local x, y = minimap:To2D(v:GetPos(), campos + minimap.OffsetVector, aang)
			y = y + 10
			local ResourceID = v:GetResourceID()
			local ResourceAmount = v:GetResourceAmount()
			local ResourceData = zmb.config.Items[ResourceID]

			if viewmult > 1 then
				DrawOutlineCircle(x, y, 32, 32, ResourceData.color or zclib.colors["ui00"], 0, viewmult)
			else
				draw.SimpleTextOutlined(ResourceData.name, zclib.GetFont("zclib_font_mediumsmall"), x, y, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black)
				draw.SimpleTextOutlined("[" .. ResourceAmount .. " / " .. zmb.Resource.GetMaxAmount() .. "] " .. "kg", zclib.GetFont("zclib_font_small"), x, 15 + y, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black)
			end
		end
	end
})

*/
