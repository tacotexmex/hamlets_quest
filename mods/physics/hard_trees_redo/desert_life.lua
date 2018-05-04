--[[
	Hard Trees Redo - Prevents digging trees by punching them.
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
-- Groups to be assigned
--

local groups_cacti = {
	groups = {choppy = 1, dl_bc = 1, not_in_creative_inventory = 1}
}

if minetest.get_modpath("fallen_trees") then
	groups_cacti = {
		groups = {
			choppy = 1, dl_bc = 1, not_in_creative_inventory = 1,
			falling_node = 1
		}
	}
end


--
-- Nodes to be overriden
--

local nodes_cacti = {
	"desert_life:barrel_cacti_1_sp", "desert_life:barrel_cacti_2_sp",
	"desert_life:barrel_cacti_3_sp"
}


--
-- Nodes overriders
--

for n = 1, 3 do
	minetest.override_item(nodes_cacti[n], groups_cacti)
end
