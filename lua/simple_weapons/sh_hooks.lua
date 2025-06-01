AddCSLuaFile()

local entMeta = FindMetaTable("Entity")
local plyMeta = FindMetaTable("Player")

local isValid = entMeta.IsValid
local isDormant = entMeta.IsDormant
local inVehicle = plyMeta.InVehicle
local getWeapon = plyMeta.GetActiveWeapon

hook.Add("PostDrawTranslucentRenderables", "simple_base", function(depth, skybox, skybox3d)
	if skybox or skybox3d then
		return
	end

	for _, ply in player.Iterator() do
		if isDormant(ply) or inVehicle(ply) then
			continue
		end

		local weapon = getWeapon(ply)

		if not isValid(weapon) or isDormant(weapon) or not weapon.SimpleWeapon then
			continue
		end

		if not weapon.PostDrawTranslucentRenderables then
			continue
		end

		weapon:PostDrawTranslucentRenderables()
	end
end)