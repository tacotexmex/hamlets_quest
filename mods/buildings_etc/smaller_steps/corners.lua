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
-- Nodes to be overriden
--

local nodes_stairs_outer = {
	"stairs:stair_outer_cobble", "stairs:stair_outer_mossycobble",
	"stairs:stair_outer_acacia_wood", "stairs:stair_outer_aspen_wood",
	"stairs:stair_outer_brick", "stairs:stair_outer_bronzeblock",
	"stairs:stair_outer_copperblock", "stairs:stair_outer_desert_cobble",
	"stairs:stair_outer_desert_cobble", "stairs:stair_outer_desert_sandstone",
	"stairs:stair_outer_desert_sandstone_block",
	"stairs:stair_outer_desert_sandstone_brick",
	"stairs:stair_outer_desert_stone", "stairs:stair_outer_desert_stone_block",
	"stairs:stair_outer_desert_stonebrick", "stairs:stair_outer_goldblock",
	"stairs:stair_outer_ice", "stairs:stair_outer_obsidian",
	"stairs:stair_outer_obsidian_block", "stairs:stair_outer_obsidianbrick",
	"stairs:stair_outer_pine_wood", "stairs:stair_outer_sandstone",
	"stairs:stair_outer_sandstone_block", "stairs:stair_outer_sandstonebrick",
	"stairs:stair_outer_silver_sandstone",
	"stairs:stair_outer_silver_sandstone_block",
	"stairs:stair_outer_silver_sandstone_brick",
	"stairs:stair_outer_snowblock", "stairs:stair_outer_steelblock",
	"stairs:stair_outer_stone", "stairs:stair_outer_stone_block",
	"stairs:stair_outer_stonebrick", "stairs:stair_outer_straw",
	"stairs:stair_outer_tinblock", "stairs:stair_outer_wood"
}

local nodes_stairs_inner = {
	"stairs:stair_inner_cobble", "stairs:stair_inner_mossycobble",
	"stairs:stair_inner_acacia_wood", "stairs:stair_inner_aspen_wood",
	"stairs:stair_inner_brick", "stairs:stair_inner_bronzeblock",
	"stairs:stair_inner_copperblock", "stairs:stair_inner_desert_cobble",
	"stairs:stair_inner_desert_cobble", "stairs:stair_inner_desert_sandstone",
	"stairs:stair_inner_desert_sandstone_block",
	"stairs:stair_inner_desert_sandstone_brick",
	"stairs:stair_inner_desert_stone", "stairs:stair_inner_desert_stone_block",
	"stairs:stair_inner_desert_stonebrick", "stairs:stair_inner_goldblock",
	"stairs:stair_inner_ice", "stairs:stair_inner_obsidian",
	"stairs:stair_inner_obsidian_block", "stairs:stair_inner_obsidianbrick",
	"stairs:stair_inner_pine_wood", "stairs:stair_inner_sandstone",
	"stairs:stair_inner_sandstone_block", "stairs:stair_inner_sandstonebrick",
	"stairs:stair_inner_silver_sandstone",
	"stairs:stair_inner_silver_sandstone_block",
	"stairs:stair_inner_silver_sandstone_brick",
	"stairs:stair_inner_snowblock", "stairs:stair_inner_steelblock",
	"stairs:stair_inner_stone", "stairs:stair_inner_stone_block",
	"stairs:stair_inner_stonebrick", "stairs:stair_inner_straw",
	"stairs:stair_inner_tinblock", "stairs:stair_inner_wood"
}


--
-- Nodes overriders
--

minetest.override_item("stairs:stair_tinblock", normal_shape)

minetest.override_item("stairs:slab_tinblock", slab_shape)

for n = 1, 35 do
	minetest.override_item(nodes_stairs_outer[n], shape_outer)
end

for n = 1, 35 do
	minetest.override_item(nodes_stairs_inner[n], shape_inner)
end


--
-- Support for other modules
--

if minetest.get_modpath("castle_masonry") then
	dofile(mod_path .. "/corners_castle_masonry.lua")
end

if minetest.get_modpath("darkage") then
	dofile(mod_path .. "/corners_darkage.lua")
end

