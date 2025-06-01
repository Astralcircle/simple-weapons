hook.Add("PopulateToolMenu", "simple_weapons", function()
	spawnmenu.AddToolMenuOption("Utilities", "User", "simple_weapons_cl", "Simple Weapons", "", "", function(pnl)
		pnl:ClearControls()
		pnl:Help("Configure you're weapons here")

		local default = {}

		for _, v in pairs(simple_weapons.Convars) do
			if TypeID(convar) == TYPE_CONVAR and convar:IsFlagSet(FCVAR_LUA_CLIENT) then
				default[v:GetName()] = v:GetDefault()
			end
		end

		pnl:AddControl("ComboBox", {MenuButton = 1, Folder = "simple_weapons_cl", Options = {["Default"] = default}, CVars = table.GetKeys(default)})
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