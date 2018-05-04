--[[
    Stonebrick Dungeons - Turns cobblestone dungeons into stonebrick.
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
-- General variables
--

local minetest_log_level = minetest.settings:get("debug_log_level")
local mod_load_message = "[Mod] Stonebrick Dungeons [v0.2.1] loaded."
local mod_path = minetest.get_modpath("stonebrick_dungeons")


--
-- Nodes to be substituted
--

local COBBLE = minetest.get_content_id"default:cobble"
local COBBLE_MOSSY = minetest.get_content_id"default:mossycobble"
local STAIR_COBBLE = minetest.get_content_id"stairs:stair_cobble"
local STAIR_COBBLE_MOSSY = minetest.get_content_id"stairs:stair_mossycobble"
local STONE_BRICKS = ""
local STONE_BRICKS_STAIR = ""


--
-- Support for other modules
--

if minetest.get_modpath("castle_masonry") then

	STONE_BRICKS = minetest.get_content_id"castle_masonry:pavement_brick"
	STONE_BRICKS_STAIR = minetest.get_content_id"stairs:stair_pavement_brick"

else

	STONE_BRICKS = minetest.get_content_id"default:stonebrick"
	STONE_BRICKS_STAIR = minetest.get_content_id"stairs:stair_stonebrick"

end


--
-- Voxel manipulator
--

minetest.register_on_generated(function()

	local vm, emin, emax = minetest.get_mapgen_object"voxelmanip"
	local data = vm:get_data()
	local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
   
   for i in area:iterp(emin, emax) do

      if (data[i] == COBBLE) or (data[i] == COBBLE_MOSSY) then
          data[i] = STONE_BRICKS
      end
      
      if (data[i] == STAIR_COBBLE) or 
         (data[i] == STAIR_COBBLE_MOSSY) then
          data[i] = STONE_BRICKS_STAIR
      end
      
   end

   vm:set_data(data)
   vm:write_to_map()

end)


--
-- Minetest engine debug logging
--

if (minetest_log_level == nil) or (minetest_log_level == "action") or
	(minetest_log_level == "info") or (minetest_log_level == "verbose") then

	minetest.log("action", mod_load_message)
end
