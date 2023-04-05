hook.Add( "SpawnMenuOpen", "SpawnMenuWhitelist", function()
	return LocalPlayer():HasWeapon("gmod_tool") or LocalPlayer():HasWeapon("weapon_physgun") or LocalPlayer():IsAdmin()
end )