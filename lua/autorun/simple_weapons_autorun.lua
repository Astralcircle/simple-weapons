module("simple_weapons", package.seeall)

local blacklist = {
	["BaseClass"] = true,
	["_M"] = true,
	["_NAME"] = true,
	["_PACKAGE"] = true
}

function Include(name, tab)
	local lib = getfenv(1)
	local tree = string.Explode(".", name)
	local target = lib[tree[1]]

	if not target then
		return
	end

	for i = 2, #tree do
		local key = tree[i]

		if not target[key] then
			return
		end

		target = target[key]
	end

	local fenv = getfenv(2)

	if fenv == _G then
		fenv = setmetatable({}, {__index = _G})

		setfenv(2, fenv)
	end

	if tab then
		fenv[tab] = target
	else
		for k, v in pairs(target) do
			if blacklist[k] or tonumber(k) then
				continue
			end

			fenv[k] = v
		end
	end
end

include("simple_weapons/sh_convars.lua")
include("simple_weapons/sh_hooks.lua")

if SERVER then
	resource.AddWorkshop("3491214981")
	AddCSLuaFile("simple_weapons/cl_ui.lua")
else
	include("simple_weapons/cl_ui.lua")
end