--[[

   GPLv3 Copyright (C) 2017-2018 Hamlet <h4mlet@riseup.net>

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
   MA 02110-1301, USA.

]]--


--
-- Damage per second, character's max health points = 20
--

-- Death in 20 seconds
local slow = {damage_per_second = 1} -- 1/2HP

-- Death in 10 seconds
local medium = {damage_per_second = 2} -- 1HP

-- Death in 5 seconds
local fast = {damage_per_second = 4} -- 4HP

-- Instant death
local immediate = {damage_per_second = 20} -- 20HP


--
-- Default Minetest Game's nodes
--

minetest.override_item("default:sand", slow)

minetest.override_item("default:desert_sand", slow)

minetest.override_item("default:silver_sand", slow)

minetest.override_item("default:gravel", medium)

minetest.override_item("default:lava_source", immediate)

minetest.override_item("default:lava_flowing", immediate)

minetest.override_item("fire:basic_flame", fast)

minetest.override_item("fire:permanent_flame", fast)

--minetest.override_item("default:torch_ceiling", medium)

--minetest.override_item("default:torch_wall", medium)


--
-- Torches and cacti's ABMs
--

-- copy-pasted from Real Test by Badger

minetest.register_abm({
   nodenames = {"default:torch"},
   interval = 1.0,
   chance = 1,
   action = function(pos, node, active_object_count, active_object_count_wider)
      local players = minetest.get_objects_inside_radius(pos, 0.7)
         for i, player in ipairs(players) do
            player:set_hp(player:get_hp() - 1)
         end
   end,
})

--[[
minetest.register_abm({
   nodenames = {"default:torch_ceiling", "default:torch_wall"},
   interval = 1.0,
   chance = 1,
   action = function(pos, node, active_object_count, active_object_count_wider)
      local pos = self.object:getpos()
      local position = {x = pos.x, y = pos.y - 1.0, pos.z}
      players = minetest.get_objects_inside_radius(position, 0.7)
         for i, player in ipairs(players) do
            player:set_hp(player:get_hp() - 1)
         end
   end,
})
--]]

minetest.register_abm({
   nodenames = {"default:cactus"},
   interval = 0.5,
   chance = 1,
   action = function(pos, node, active_object_count, active_object_count_wider)
      local players = minetest.get_objects_inside_radius(pos, 1)
         for i, player in ipairs(players) do
            player:set_hp(player:get_hp() - 1)
         end
   end,
})


--
-- Support for Desert Life's barrel cacti
--

if minetest.get_modpath("desert_life") then

   minetest.register_abm({
      nodenames = {"desert_life:barrel_cacti_1",
                   "desert_life:barrel_cacti_2",
                   "desert_life:barrel_cacti_3",
                   "desert_life:barrel_cacti_1_sp",
                   "desert_life:barrel_cacti_2_sp",
                   "desert_life:barrel_cacti_3_sp"},
      interval = 0.5,
      chance = 1,
      action = function(pos, node, active_object_count, active_object_count_wider)
         local objects = minetest.get_objects_inside_radius(pos, 1)

         for _, obj in pairs(objects) do
         
            if obj:is_player() then
               obj:set_hp(obj:get_hp() - 1)
            else 
               if not obj:get_armor_groups().immortal then
                  obj:set_hp(obj:get_hp() - 1)
               end
            end
         end
      end,
   })
end


--
-- Support for DFCaverns' blood thorn
--

if minetest.get_modpath("dfcaverns") then

   minetest.register_abm({
      nodenames = {"dfcaverns:blood_thorn",
                   "dfcaverns:blood_thorn_spike",},
      interval = 0.5,
      chance = 1,
      action = function(pos, node, active_object_count, active_object_count_wider)
         local objects = minetest.get_objects_inside_radius(pos, 1)

         for _, obj in pairs(objects) do
         
            if obj:is_player() then
               obj:set_hp(obj:get_hp() - 1)
            else 
               if not obj:get_armor_groups().immortal then
                  obj:set_hp(obj:get_hp() - 1)
               end
            end
         end
      end,
   })
end


--
-- Support for [Mod] Fallen Nodes [fallen_nodes]
--

if minetest.get_modpath("fallen_nodes") then

   minetest.override_item("default:cobble", medium)

   minetest.override_item("default:mossycobble", medium)

   minetest.override_item("default:desert_cobble", medium)


--[[
   --
   -- Stairs and slabs | Disabled due to damage on walking over
   --

   minetest.override_item("stairs:stair_cobble", medium)

   minetest.override_item("stairs:stair_outer_cobble", medium)

   minetest.override_item("stairs:stair_inner_cobble", medium)

   minetest.override_item("stairs:slab_cobble", medium)

   minetest.override_item("stairs:stair_mossycobble", medium)

   minetest.override_item("stairs:stair_outer_mossycobble", medium)

   minetest.override_item("stairs:stair_inner_mossycobble", medium)

   minetest.override_item("stairs:slab_mossycobble", medium)

   minetest.override_item("stairs:stair_desert_cobble", medium)

   minetest.override_item("stairs:stair_inner_desert_cobble", medium)

   minetest.override_item("stairs:stair_outer_desert_cobble", medium)

   minetest.override_item("stairs:slab_desert_cobble", medium)
]]--

   --
   -- Soft / Non-Stone
   --

   minetest.override_item("default:dirt", slow)

   minetest.override_item("default:dirt_with_grass", slow)

   minetest.override_item("default:dirt_with_grass_footsteps", slow)

   minetest.override_item("default:dirt_with_dry_grass", slow)

   minetest.override_item("default:dirt_with_snow", slow)

   minetest.override_item("default:dirt_with_rainforest_litter", slow)


   --
   -- Plantlife (non-cubic)
   --

   minetest.override_item("default:cactus", fast)

end


--
-- Support for [Mod] Fallen Trees [fallen_trees]
--

if minetest.get_modpath("fallen_trees") then

   minetest.override_item("default:tree", fast)

   minetest.override_item("default:jungletree", fast)

   minetest.override_item("default:pine_tree", fast)

   minetest.override_item("default:acacia_tree", fast)

   minetest.override_item("default:aspen_tree", fast)

end


--
-- Support for [Mod] Experimental mapgen [mg]
--

if minetest.get_modpath("mg") then

   minetest.override_item("mg:dirt_with_dry_grass", slow)

end


--
-- Support for [Mod] Darkage [darkage]
--

if minetest.get_modpath("darkage") then

   minetest.override_item("darkage:chalk", medium)

   minetest.override_item("darkage:basalt_rubble", medium)

   minetest.override_item("darkage:cobble_with_plaster", medium)

   minetest.override_item("darkage:darkdirt", slow)

   minetest.override_item("darkage:gneiss_rubble", medium)

   minetest.override_item("darkage:mud", fast)

   minetest.override_item("darkage:ors_rubble", medium)

   minetest.override_item("darkage:silt", slow)

   minetest.override_item("darkage:slate_rubble", medium)

end


--
-- Support for [Mod] Castle Masonry [castle_masonry]
--

if minetest.get_modpath("castle_masonry") then

   minetest.override_item("castle_masonry:rubble", medium)

end


minetest.log("action", "[Mod] Killer Nodes loaded")
