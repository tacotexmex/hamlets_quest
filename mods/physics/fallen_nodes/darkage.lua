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
-- Darkage (Addi's version) nodes overriders
--

minetest.override_item("darkage:chalk", {
	groups = {crumbly=2, cracky=2, falling_node = 1}
})

minetest.override_item("darkage:basalt_rubble", {
	groups = {cracky = 3, stone = 2, falling_node = 1}
})

minetest.override_item("darkage:cobble_with_plaster", {
	groups = {cracky=3, not_cuttable=1, falling_node = 1}
})

minetest.override_item("darkage:darkdirt", {
	groups = {crumbly=2, not_cuttable=1, falling_node = 1}
})

minetest.override_item("darkage:gneiss_rubble", {
	groups = {cracky = 3, stone = 2, falling_node = 1}
})

minetest.override_item("darkage:mud", {
	groups = {crumbly=3, falling_node = 1}
})

minetest.override_item("darkage:ors_rubble", {
	groups = {cracky = 3, crumbly=2, falling_node = 1}
})

minetest.override_item("darkage:silt", {
	groups = {crumbly=3, falling_node = 1}
})

minetest.override_item("darkage:slate_rubble", {
	groups = {cracky=2, falling_node = 1}
})
