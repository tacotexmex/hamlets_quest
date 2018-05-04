--[[
    Smaller Steps - Makes stairs and slabs use smaller shapes.
    Copyright (C) 2018  Hamlet

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

local smaller_steps_corners = minetest.settings:get_bool("smaller_steps_corners")

if not smaller_steps_corners then
	smaller_steps_corners = false
	minetest.settings:set_bool("smaller_steps_corners", false)
end


--
-- General variables
--

local minetest_log_level = minetest.settings:get("debug_log_level")
local mod_load_message = "[Mod] Smaller Steps [v1.2.3] loaded."
local mod_path = minetest.get_modpath("smaller_steps")


--
-- Shapes to be assigned
--

shape_normal = {
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.166667, 0.5},
			{-0.5, -0.166667, -0.166667, 0.5, 0.166667, 0.5},
			{-0.5, 0.166667, 0.166667, 0.5, 0.5, 0.5},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.166667, 0.5},
			{-0.5, -0.166667, -0.166667, 0.5, 0.166667, 0.5},
			{-0.5, 0.166667, 0.166667, 0.5, 0.5, 0.5},
		},
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.166667, 0.5},
			{-0.5, -0.166667, -0.166667, 0.5, 0.166667, 0.5},
			{-0.5, 0.166667, 0.166667, 0.5, 0.5, 0.5},
		},
	},
}

shape_outer = {
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.166667, 0.5},
			{-0.5, -0.166667, -0.166667, 0.166667, 0.166667, 0.5},
			{-0.5, 0.166667, 0.166667, -0.166667, 0.5, 0.5},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.166667, 0.5},
			{-0.5, -0.166667, -0.166667, 0.166667, 0.166667, 0.5},
			{-0.5, 0.166667, 0.166667, -0.166667, 0.5, 0.5},
		},
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.166667, 0.5},
			{-0.5, -0.166667, -0.166667, 0.166667, 0.166667, 0.5},
			{-0.5, 0.166667, 0.166667, -0.166667, 0.5, 0.5},
		},
	},
}

shape_inner = {
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.166667, 0.5},
			{-0.5, -0.166667, -0.5, 0.166667, 0.166667, 0.5},
			{-0.5, 0.166667, -0.5, -0.166667, 0.5, 0.5},
			{0.166667, -0.166667, -0.166667, 0.5, 0.166667, 0.5},
			{-0.166667, 0.166667, 0.166667, 0.5, 0.5, 0.5},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.166667, 0.5},
			{-0.5, -0.166667, -0.5, 0.166667, 0.166667, 0.5},
			{-0.5, 0.166667, -0.5, -0.166667, 0.5, 0.5},
			{0.166667, -0.166667, -0.166667, 0.5, 0.166667, 0.5},
			{-0.166667, 0.166667, 0.166667, 0.5, 0.5, 0.5},
		},
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.166667, 0.5},
			{-0.5, -0.166667, -0.5, 0.166667, 0.166667, 0.5},
			{-0.5, 0.166667, -0.5, -0.166667, 0.5, 0.5},
			{0.166667, -0.166667, -0.166667, 0.5, 0.166667, 0.5},
			{-0.166667, 0.166667, 0.166667, 0.5, 0.5, 0.5},
		},
	},
}

shape_slab = {
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.166667, 0.5},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.166667, 0.5},
		},
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.166667, 0.5},
		},
	},
}


--
-- Nodes to be overriden
--

local nodes_stairs = {
	"stairs:stair_cobble", "stairs:stair_mossycobble",
	"stairs:stair_acacia_wood", "stairs:stair_aspen_wood",
	"stairs:stair_brick", "stairs:stair_bronzeblock",
	"stairs:stair_copperblock", "stairs:stair_desert_cobble",
	"stairs:stair_desert_stone", "stairs:stair_desert_stone_block",
	"stairs:stair_desert_stonebrick", "stairs:stair_desert_sandstone",
	"stairs:stair_desert_sandstone_block", "stairs:stair_desert_sandstone_brick",
	"stairs:stair_goldblock", "stairs:stair_ice", "stairs:stair_obsidian",
	"stairs:stair_obsidian_block", "stairs:stair_obsidianbrick",
	"stairs:stair_pine_wood", "stairs:stair_sandstone",
	"stairs:stair_sandstone_block", "stairs:stair_sandstonebrick",
	"stairs:stair_silver_sandstone", "stairs:stair_silver_sandstone_block",
	"stairs:stair_silver_sandstone_brick", "stairs:stair_snowblock",
	"stairs:stair_steelblock", "stairs:stair_stone", "stairs:stair_stone_block",
	"stairs:stair_stonebrick", "stairs:stair_straw", "stairs:stair_wood"
}

local nodes_slabs = {
	"stairs:slab_cobble", "stairs:slab_desert_sandstone",
	"stairs:slab_desert_sandstone_block", "stairs:slab_desert_sandstone_brick",
	"stairs:slab_mossycobble", "stairs:slab_acacia_wood",
	"stairs:slab_aspen_wood", "stairs:slab_brick", "stairs:slab_bronzeblock",
	"stairs:slab_copperblock", "stairs:slab_desert_cobble",
	"stairs:slab_desert_stone", "stairs:slab_desert_stone_block",
	"stairs:slab_desert_stonebrick", "stairs:slab_goldblock", "stairs:slab_ice",
	"stairs:slab_obsidian", "stairs:slab_obsidian_block",
	"stairs:slab_obsidianbrick", "stairs:slab_pine_wood",
	"stairs:slab_sandstone", "stairs:slab_sandstone_block",
	"stairs:slab_sandstonebrick", "stairs:slab_silver_sandstone",
	"stairs:slab_silver_sandstone_block", "stairs:slab_silver_sandstone_brick",
	"stairs:slab_snowblock", "stairs:slab_steelblock", "stairs:slab_stone",
	"stairs:slab_stone_block", "stairs:slab_stonebrick", "stairs:slab_straw",
	"stairs:slab_wood"
}


--
-- Nodes overriders
--

for n = 1, 33 do
	minetest.override_item(nodes_stairs[n], shape_normal)
end

for n = 1, 33 do
	minetest.override_item(nodes_slabs[n], shape_slab)
end


--
-- Support for stairs corners
--

if (smaller_steps_corners == true) then
   dofile(mod_path .. "/corners.lua")
end


--
-- Support for other modules
--

if minetest.get_modpath("castle_masonry") then
	dofile(mod_path .. "/castle_masonry.lua")
end

if minetest.get_modpath("darkage") then
	dofile(mod_path .. "/darkage.lua")
end


--
-- Minetest engine debug logging
--

if (minetest_log_level == nil) or (minetest_log_level == "action") or
	(minetest_log_level == "info") or (minetest_log_level == "verbose") then

	minetest.log("action", mod_load_message)
end
