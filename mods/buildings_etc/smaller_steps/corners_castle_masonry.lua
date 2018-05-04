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
	"stairs:stair_outer_pavement_brick", "stairs:stair_outer_rubble",
	"stairs:stair_outer_stonewall"
}

local nodes_stairs_inner = {
	"stairs:stair_inner_pavement_brick", "stairs:stair_inner_rubble",
	"stairs:stair_inner_stonewall"
}


--
-- Nodes overriders
--

for n = 1, 3 do
	minetest.override_item(nodes_stairs_outer[n], shape_outer)
end

for n = 1, 3 do
	minetest.override_item(nodes_stairs_inner[n], shape_inner)
end
