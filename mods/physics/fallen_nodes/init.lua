--[[
    Fallen Nodes - Adds more nodes to the falling_node group.
    Copyright (C) 2018 Hamlet

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
--]]


--
-- Configuration
--

local fallen_nodes_corners = minetest.settings:get_bool("fallen_nodes_corners")

if (fallen_nodes_corners == nil) then
	fallen_nodes_corners = false
	minetest.settings:set_bool("fallen_nodes_corners", false)
end


--
-- General variables
--

local minetest_log_level = minetest.settings:get("debug_log_level")
local mod_load_message = "[Mod] Fallen Nodes [v1.4.0] loaded."
local mod_path = minetest.get_modpath("fallen_nodes")


--
-- Goups to be assigned
--

local cobble_groups = {groups = {cracky = 3, stone = 2, falling_node = 1}}
local stairs_groups = {groups = {cracky = 3, falling_node = 1}}
local flammable_stairs_groups = {
	groups = {snappy = 3, flammable = 4, falling_node = 1}
}
local dirt_groups = {
	groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1, falling_node = 1}
}


--
-- Nodes to be overriden
--

local cobble = {"default:cobble", "default:desert_cobble"}

local stairs_slabs = {"stairs:stair_cobble", "stairs:slab_cobble",
	"stairs:stair_mossycobble", "stairs:slab_mossycobble",
	"stairs:stair_desert_cobble", "stairs:slab_desert_cobble"
}

local flammable_stairs_slabs = {"stairs:stair_straw", "stairs:slab_straw"}

local dirt = {
	"default:dirt_with_grass", "default:dirt_with_dry_grass",
	"default:dirt_with_rainforest_litter"
}


--
-- Cobble nodes overriders
--

for n = 1, 2 do
	minetest.override_item(cobble[n], cobble_groups)
end

minetest.override_item("default:mossycobble", {
	groups = {cracky = 3, stone = 1, falling_node = 1}
})


--
-- Stairs and slabs nodes overriders
--

for n = 1, 6 do
	minetest.override_item(stairs_slabs[n], stairs_groups)
end

for n = 1, 2 do
	minetest.override_item(flammable_stairs_slabs[n], flammable_stairs_groups)
end


--
-- Dirt nodes overriders
--

for n = 1, 3 do
	minetest.override_item(dirt[n], dirt_groups)
end

minetest.override_item("default:dirt", {
	groups = {crumbly = 3, soil = 1, falling_node = 1}
})

minetest.override_item("default:dirt_with_grass_footsteps", {
	groups = {
		crumbly = 3, soil = 1, not_in_creative_inventory = 1,	falling_node = 1
	}
})

minetest.override_item("default:dirt_with_snow", {
	groups = {
		crumbly = 3, spreading_dirt_type = 1, snowy = 1, falling_node = 1
	}
})


--
-- Plants nodes overriders
--

minetest.override_item("default:cactus", {
	groups = {choppy = 3, falling_node = 1}
})

minetest.override_item("default:papyrus", {
	groups = {snappy = 3, flammable = 2, attached_node = 1}
})


--
-- Support for other modules
--

if minetest.get_modpath("darkage") then
	dofile(mod_path .. "/darkage.lua")
end

if minetest.get_modpath("landscape") then
	dofile(mod_path .. "/landscape.lua")
end

if minetest.get_modpath("mg") then
	dofile(mod_path .. "/mg.lua")
end


--
-- Support for the stairs' corners
--

if (fallen_nodes_corners == true) then
	dofile(mod_path .. "/corners.lua")
end


--
-- Minetest engine debug logging
--

if (minetest_log_level == nil) or (minetest_log_level == "action") or
	(minetest_log_level == "info") or (minetest_log_level == "verbose") then

	minetest.log("action", mod_load_message)
end
