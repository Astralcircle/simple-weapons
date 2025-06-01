CreateConVar("simple_weapons_damage_mult", 1, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "The damage modifier to use for weapons.", 0)
CreateConVar("simple_weapons_npc_damage_mult", 0.5, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "The damage modifier to use for weapons when held by NPC's.", 0)
CreateConVar("simple_weapons_range_mult", 1, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "The range modifier to use for weapons.", 0)
CreateConVar("simple_weapons_recoil_mult", 1, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "The recoil modifier to use for weapons.", 0)

if SERVER then
	resource.AddWorkshop("3491214981")
else
	local simple_weapons_auto_reload = CreateClientConVar("simple_weapons_auto_reload", 1, true, true, "Whether weapons should automatically reload when you fire them.")
	local simple_weapons_scopes = CreateClientConVar("simple_weapons_scopes", 1, true, false, "Whether to use scopes when zooming.")
	local simple_weapons_swayscale = CreateClientConVar("simple_weapons_swayscale", 1, true, false, "The amount of viewmodel sway to apply to weapons")
	local simple_weapons_bobscale = CreateClientConVar("simple_weapons_bobscale", 1, true, false, "The amount of viewmodel bob to apply to weapons")
	local simple_weapons_vm_offset_x = CreateClientConVar("simple_weapons_vm_offset_x", 0, true, false, "The forward/back offset to use for viewmodels.")
	local simple_weapons_vm_offset_y = CreateClientConVar("simple_weapons_vm_offset_y", 0, true, false, "The left/right offset to use for viewmodels.")
	local simple_weapons_vm_offset_z = CreateClientConVar("simple_weapons_vm_offset_z", 0, true, false, "The up/down offset to use for viewmodelss.")

	hook.Add("PopulateToolMenu", "simple_weapons", function()
		spawnmenu.AddToolMenuOption("Utilities", "User", "simple_weapons_cl", "Simple Weapons", "", "", function(pnl)
			pnl:Help("Configure your weapons here")

			local convars = {
				simple_weapons_auto_reload = simple_weapons_auto_reload:GetDefault(),
				simple_weapons_scopes = simple_weapons_scopes:GetDefault(),
				simple_weapons_swayscale = simple_weapons_swayscale:GetDefault(),
				simple_weapons_bobscale = simple_weapons_bobscale:GetDefault(),
				simple_weapons_vm_offset_x = simple_weapons_vm_offset_x:GetDefault(),
				simple_weapons_vm_offset_y = simple_weapons_vm_offset_y:GetDefault(),
				simple_weapons_vm_offset_z = simple_weapons_vm_offset_z:GetDefault()
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