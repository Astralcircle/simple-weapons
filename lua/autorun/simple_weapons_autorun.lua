if SERVER then
	resource.AddWorkshop("3491214981")
	CreateConVar("simple_weapons_damage_mult", 1, FCVAR_ARCHIVE, "The damage modifier to use for weapons.", 0)
	CreateConVar("simple_weapons_npc_damage_mult", 0.5, FCVAR_ARCHIVE, "The damage modifier to use for weapons when held by NPC's.", 0)
	CreateConVar("simple_weapons_range_mult", 1, FCVAR_ARCHIVE, "The range modifier to use for weapons.", 0)
	CreateConVar("simple_weapons_recoil_mult", 1, FCVAR_ARCHIVE, "The recoil modifier to use for weapons.", 0)
else
	CreateClientConVar("simple_weapons_auto_reload", 1, true, true, "Whether weapons should automatically reload when you fire them.")
	CreateClientConVar("simple_weapons_scopes", 1, true, false, "Whether to use scopes when zooming.")
	CreateClientConVar("simple_weapons_swayscale", 1, true, false, "The amount of viewmodel sway to apply to weapons")
	CreateClientConVar("simple_weapons_bobscale", 1, true, false, "The amount of viewmodel bob to apply to weapons")
	CreateClientConVar("simple_weapons_vm_offset_x", 0, true, false, "The forward/back offset to use for viewmodels.")
	CreateClientConVar("simple_weapons_vm_offset_y", 0, true, false, "The left/right offset to use for viewmodels.")
	CreateClientConVar("simple_weapons_vm_offset_z", 0, true, false, "The up/down offset to use for viewmodelss.")
end

if CLIENT then
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

	hook.Add("PopulateToolMenu", "simple_weapons", function()
		spawnmenu.AddToolMenuOption("Utilities", "User", "simple_weapons_cl", "Simple Weapons", "", "", function(pnl)
			pnl:Help("Configure you're weapons here")

			local convars = {
				simple_weapons_auto_reload = GetConVar("simple_weapons_auto_reload"):GetDefault(),
				simple_weapons_scopes = GetConVar("simple_weapons_scopes"):GetDefault(),
				simple_weapons_swayscale = GetConVar("simple_weapons_swayscale"):GetDefault(),
				simple_weapons_bobscale = GetConVar("simple_weapons_bobscale"):GetDefault(),
				simple_weapons_vm_offset_x = GetConVar("simple_weapons_vm_offset_x"):GetDefault(),
				simple_weapons_vm_offset_y = GetConVar("simple_weapons_vm_offset_y"):GetDefault(),
				simple_weapons_vm_offset_z = GetConVar("simple_weapons_vm_offset_z"):GetDefault()
			}

			pnl:ToolPresets("simple_weapons_cl", convars)
			pnl:CheckBox("Auto reload when empty", "simple_weapons_auto_reload")
			pnl:CheckBox("Draw scopes", "simple_weapons_scopes")
			pnl:Help("")
			pnl:Help("Viewmodel Settings")
			pnl:NumSlider("Viewmodel sway", "simple_weapons_swayscale", 0, 3, 2)
			pnl:NumSlider("Viewmodel bob", "simple_weapons_bobscale", 0, 3, 2)
			pnl:Help("")
			pnl:Help("Viewmodel Offset")
			pnl:NumSlider("X offset (Forward)", "simple_weapons_vm_offset_x", -10, 10, 2)
			pnl:NumSlider("Y offset (Side)", "simple_weapons_vm_offset_y", -10, 10, 2)
			pnl:NumSlider("Z offset (Up)", "simple_weapons_vm_offset_z", -10, 10, 2)
		end)
	end)
end