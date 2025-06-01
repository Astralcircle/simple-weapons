AddCSLuaFile()

module("simple_weapons.Convars", package.seeall)

DamageMult = CreateConVar("simple_weapons_damage_mult", 1, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "The damage modifier to use for weapons.", 0)
NPCDamageMult = CreateConVar("simple_weapons_npc_damage_mult", 0.5, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "The damage modifier to use for weapons when held by NPC's.", 0)
RangeMult = CreateConVar("simple_weapons_range_mult", 1, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "The range modifier to use for weapons.", 0)
RecoilMult = CreateConVar("simple_weapons_recoil_mult", 1, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "The recoil modifier to use for weapons.", 0)

if CLIENT then
	AutoReload = CreateClientConVar("simple_weapons_auto_reload", 1, true, true, "Whether weapons should automatically reload when you fire them.")
	UseScopes = CreateClientConVar("simple_weapons_scopes", 1, true, false, "Whether to use scopes when zooming.")

	SwayScale = CreateClientConVar("simple_weapons_swayscale", 1, true, false, "The amount of viewmodel sway to apply to weapons")
	BobScale = CreateClientConVar("simple_weapons_bobscale", 1, true, false, "The amount of viewmodel bob to apply to weapons")

	VMOffsetX = CreateClientConVar("simple_weapons_vm_offset_x", 0, true, false, "The forward/back offset to use for viewmodels.")
	VMOffsetY = CreateClientConVar("simple_weapons_vm_offset_y", 0, true, false, "The left/right offset to use for viewmodels.")
	VMOffsetZ = CreateClientConVar("simple_weapons_vm_offset_z", 0, true, false, "The up/down offset to use for viewmodelss.")
end
