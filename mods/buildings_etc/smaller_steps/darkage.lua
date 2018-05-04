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

local nodes_stairs = {
	"stairs:stair_darkage_basalt", "stairs:stair_darkage_basalt_brick",
	"stairs:stair_darkage_basalt_rubble", "stairs:stair_darkage_chalked_bricks",
	"stairs:stair_darkage_gneiss", "stairs:stair_darkage_gneiss_brick",
	"stairs:stair_darkage_gneiss_rubble", "stairs:stair_darkage_marble",
	"stairs:stair_darkage_marble_tile", "stairs:stair_darkage_old_tuff_bricks",
	"stairs:stair_darkage_ors", "stairs:stair_darkage_ors_brick",
	"stairs:stair_darkage_ors_rubble", "stairs:stair_darkage_rhyolitic_tuff",
	"stairs:stair_darkage_rhyolitic_tuff_bricks", "stairs:stair_darkage_schist",
	"stairs:stair_darkage_serpentine", "stairs:stair_darkage_shale",
	"stairs:stair_darkage_slate", "stairs:stair_darkage_slate_brick",
	"stairs:stair_darkage_slate_rubble", "stairs:stair_darkage_slate_tile",
	"stairs:stair_darkage_stone_brick", "stairs:stair_darkage_straw_bale",
	"stairs:stair_darkage_tuff", "stairs:stair_darkage_tuff_bricks"
}

local nodes_slabs = {
	"stairs:slab_darkage_basalt", "stairs:slab_darkage_basalt_brick",
	"stairs:slab_darkage_basalt_rubble", "stairs:slab_darkage_chalked_bricks",
	"stairs:slab_darkage_gneiss", "stairs:slab_darkage_gneiss_brick",
	"stairs:slab_darkage_gneiss_rubble", "stairs:slab_darkage_marble",
	"stairs:slab_darkage_marble_tile", "stairs:slab_darkage_old_tuff_bricks",
	"stairs:slab_darkage_ors", "stairs:slab_darkage_ors_brick",
	"stairs:slab_darkage_ors_rubble", "stairs:slab_darkage_rhyolitic_tuff",
	"stairs:slab_darkage_rhyolitic_tuff_bricks", "stairs:slab_darkage_schist",
	"stairs:slab_darkage_serpentine", "stairs:slab_darkage_shale",
	"stairs:slab_darkage_slate", "stairs:slab_darkage_slate_brick",
	"stairs:slab_darkage_slate_rubble", "stairs:slab_darkage_slate_tile",
	"stairs:slab_darkage_stone_brick", "stairs:slab_darkage_straw_bale",
	"stairs:slab_darkage_tuff", "stairs:slab_darkage_tuff_bricks"
}


--
-- Nodes overriders
--

for n = 1, 26 do
	minetest.override_item(nodes_stairs[n], shape_normal)
end

for n = 1, 26 do
	minetest.override_item(nodes_slabs[n], shape_slab)
end
