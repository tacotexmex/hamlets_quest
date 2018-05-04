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
-- Groups to be assigned
--

local corners_groups = {groups = {cracky = 3, falling_node = 1}}
local corners_groups_flammable = {
	groups = {snappy = 3, flammable = 4, falling_node = 1}
}


--
-- Nodes to be overriden
--

local corners = {
	"stairs:stair_outer_cobble", "stairs:stair_inner_cobble",
	"stairs:stair_outer_mossycobble", "stairs:stair_inner_mossycobble",
	"stairs:stair_inner_desert_cobble", "stairs:stair_outer_desert_cobble"
}

local corners_flammable = {
	"stairs:stair_outer_straw", "stairs:stair_inner_straw"
}


--
-- Stairs' corners overriders
--

for n = 1, 6 do
	minetest.override_item(corners[n], corners_groups)
end

for n = 1, 2 do
	minetest.override_item(corners_flammable[n], corners_groups_flammable)
end
