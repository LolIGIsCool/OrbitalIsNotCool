PANEL = {}

local MODULE_INVENTORY = RK.Modules:Get( "inventory" )

function PANEL:Init()

	self.BaseClass.Init( self )

	self.m_pnlModel = vgui.Create( "DModelPanel", self )
	self.m_pnlModel:SetSize( self:GetTall(), self:GetTall() )
	self.m_pnlModel:SetAmbientLight( Color( 255, 255, 255 ) )
	self.m_pnlModel:SetDirectionalLight( BOX_TOP, Color( 255, 255, 255 ) )

	self.m_pnlModel:SetModel( "" )
	self.m_pnlModel:SetAnimated( false )
	self.m_pnlModel.LayoutEntity = function( s, ent ) return end
	self.m_pnlModel.DoClick = function( s )
		self:DoClick()
	end
	self.m_pnlModel.DoRightClick = function( s )
		self:DoRightClick()
	end

	self:Receiver( "InventoryItem", function( pnl, tbl, dropped )
		if not dropped then return end
		if pnl == tbl[1] then return end

		RK.Net:SendNetData( "RK.Inventory:Request", { Command = "Swap", ID = pnl.m_iID, Target = tbl[1].m_iID } )
		local parent = self:GetParent()
		parent.Selected = nil
		parent:OnItemSelect()
	end )
	self:Droppable( "InventoryItem" )
	self.m_pnlModel:SetDragParent( self )
end

function PANEL:DoClick()
	if !self.m_tblItem then return end
	local parent = self:GetParent()

	if parent.Selected == self then return end
	parent.Selected = self
	parent:OnItemSelect( self.m_tblItem )
end

function PANEL:DoRightClick()
	local menu = DermaMenu()
	local debug_menu = false
	if debug_mode then
		menu:AddOption( "Debug", function()
			PrintTable( self.m_tblItem )
		end )
	end
	
	if self.m_tblItem.base != "base" then
		menu:AddOption( "Equip", function()
		-- check if item can be equipped?

			RK.Net:SendNetData( "RK.Inventory:Request", { Command = "Equip", ID = self.m_iID, Amount = nil } )
		--print(self.m_iID)

		--PrintTable( self.m_tblItem )
		end )
		menu:AddOption( "UnEquip", function()
		-- check if item can be equipped?
			RK.Net:SendNetData( "RK.Inventory:Request", { Command = "UnEquip", ID = self.m_iID, Amount = nil } )
		--print(self.m_iID)
		
		--PrintTable( self.m_tblItem )
		end )
	end
	
	menu:AddOption( "Drop", function()
		PrintTable( self.m_tblItem )
	end )
	menu:AddOption( "Remove", function()
		RK.Net:SendNetData( "RK.Inventory:Request", { Command = "Remove", ID = self.m_iID, Amount = nil } )
	end )
	menu:Open()

	// repaint the derma menu
	local children = menu:GetChildren()

	menu.Paint = function( s, w, h ) end
	children[1].Paint = function( s, w, h ) end
	children[2].Paint = function( s, w, h ) end
	for k, v in pairs( children[1]:GetChildren() ) do
		v.Paint = function( s, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, s:IsHovered() and Color( 50, 50, 50 ) or Color( 30, 30, 30 ) )
		end
		v:SetFont( RKFont( 18, "Bahnschrift SemiLight Condensed" ) )
	end

end

function PANEL:SetupInventory( ID )
	self.m_iID = ID

	self.Think = function( s )
		local inv_item = LocalPlayer():GetInventory()[ ID ]
		--print(inv_item)
		if s.m_tblItem and inv_item == s.m_tblItem then return end
		s.m_tblItem = inv_item
		s.m_tblItemBase = inv_item and RK.Inventory:GetItem( inv_item.base ) or nil
		--PrintTable(RK.Inventory:GetItem( inv_item ))
		s:SetItem( inv_item )
	end
end

function PANEL:SetItem( data )
	self.m_tblItem = data

	if !data then
		self.m_pnlModel:SetModel( "" )
	return end

	local data_base = self.m_tblItemBase
	data_base = RK.Inventory:GetItem( data )
	--PrintTable(data_base)
	--print(data_base)
	-- Set the model
	if !data_base then --[[print( data.base, "is not a valid item base", RK.Inventory:GetItem( data.base ) )]] return end
	data_base = data_base.data

	self.m_pnlModel:SetModel( data.data.model or data_base.model )

	if data.data.skin or data_base.skin then
		self.m_pnlModel:SetSkin( data.data.skin or data_base.skin )
	end
	if data_base.bodygroup then
		self.m_pnlModel:SetBodygroup( data_base.bodygroup[1], data_base.bodygroup[2] )
	end
	if data.data.material or data_base.material then
		self.m_pnlModel:GetEntity():SetMaterial( data.data.material or data_base.material )
	end

	// calculate center of the new model
	timer.Simple( 0.1, function()
		if !IsValid( self ) then return end
		local mdl = self.m_pnlModel:GetEntity()
		if !IsValid( mdl ) then return end
		local min, max = mdl:GetRenderBounds()
		local center = (min + max) / 2
		self.m_pnlModel:SetLookAt( center )
		self.m_pnlModel:SetCamPos( center + Vector( max.z, max.z, max.z ) )
	end )
	
end

function PANEL:Paint( w, h )
	draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 100 ) )
end

function PANEL:PaintOver( w, h )
	if self.m_iID then
		-- draw.SimpleTextOutlined( self.m_iID, RKFont( 20, "Bahnschrift SemiLight Condensed" ), w * 0.5, h * 0.5, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color( 0, 0, 0, 255 ) )
	end

	if self.m_tblItem then
		local txt = self.m_tblItem.name
		draw.SimpleTextOutlined( txt, RKFont( 20, "Bahnschrift SemiLight Condensed" ), w * 0.5, 5, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color( 0, 0, 0, 255 ) )
	
		if self.m_tblItem.amount then
			local txt = self.m_tblItem.amount
			draw.SimpleTextOutlined( txt, RKFont( 16, "Bahnschrift SemiLight Condensed" ), 10, h - 5, Color( 50, 200, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, Color( 0, 0, 0, 255 ) )
		end
	end

	if self.m_tblItemBase then
		local base = RK.Inventory:GetItemBase( self.m_tblItemBase.base )
		if base then base = base.data end
		if base and base[ "colour" ] then
			draw.RoundedBox( 0, 10, h * 0.2, 4, h * 0.6, base[ "colour" ] )
		else
			draw.RoundedBox( 0, 10, h * 0.2, 4, h * 0.6, Color( 0, 0, 0, 100 ) )
		end
	end

	if self:GetParent() and self:GetParent()[ "Selected" ] == self then
		-- draw boarder

		for i = 0, 3 do
			surface.SetAlphaMultiplier( 1 - ( ( i * 1.5 ) / 10 ) )
			surface.SetDrawColor( Color( 50, 200, 255) )
			surface.DrawOutlinedRect( i, i, w - ( i * 2 ), h - ( i * 2 ) )
		end
		surface.SetAlphaMultiplier( 1 )
	end
end

function PANEL:PerformLayout( w, h )
	self.m_pnlModel:SetSize( w, h )
end
vgui.Register( "RKCore:InventoryItem", PANEL, "DPanel" )