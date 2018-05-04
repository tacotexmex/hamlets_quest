--[[

   Mobs Balrog init.lua Copyright 2017-2018 Hamlet <h4mlet@riseup.net>

   Authors of source code:
   -----------------------
   (LOTT-specific-mod)
   Original Author(s):
      PilzAdam (WTFPL)
         https://github.com/PilzAdam/mobs
   Modifications By:
      Copyright (C) 2016 TenPlus1 (MIT)
         https://github.com/tenplus1/mobs_redo
      BrandonReese (LGPL v2.1)
         https://github.com/Bremaweb/adventuretest
   LOTT Modifications By:
      Amaz (LGPL v2.1)
      lumidify (LGPL v2.1)
      fishyWET (LGPL v2.1)
         https://github.com/minetest-LOTR/Lord-of-the-Test/

   This program is free software; you can redistribute it and/or modify
   it under the terms of the Lesser GNU General Public License as published
   by the Free Software Foundation; either version 2.1 of the License, or
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
-- Balrog's whip
--

minetest.register_tool("mobs_balrog:balrog_whip", {
   description = minetest.colorize("orange", "Balrog Whip") ..
      minetest.get_background_escape_sequence("darkred"),
   inventory_image = "mobs_balrog_balrog_whip.png^[transform3",
   on_use = function(itemstack, user, pointed_thing)
      if pointed_thing.type == "nothing" then
         local dir = user:get_look_dir()
         local pos = user:get_pos()
         for i = 1, 50 do
            local new_pos = {
               x = pos.x + (dir.x * i),
               y = pos.y + (dir.y * i),
               z = pos.z + (dir.z * i),
            }
            if minetest.get_node(new_pos).name == "air"  and
            not minetest.is_protected(new_pos, user:get_player_name()) then
               minetest.set_node(new_pos, {name = "fire:basic_flame"})
            end
         end
         if not minetest.setting_getbool("creative_mode") then
            itemstack:add_wear(65535/49)
            return itemstack
         end
      elseif pointed_thing.type == "object" then
         local obj = pointed_thing.ref
         minetest.add_particlespawner({
            amount = 40,
            time = 6,
            minpos = {x = -1, y = -1, z = -1},
            maxpos = {x = 1, y = 1, z = 1},
            minvel = {x = -2, y = -2, z = -2},
            maxvel = {x = 2, y = 2, z = 2},
            minacc = {x = -1, y = -1, z = -1},
            maxacc = {x = 1, y = 1, z = 1},
            minexptime = 1,
            maxexptime = 2,
            minsize = 1,
            maxsize = 3,
            attached = obj,
            vertical = false,
            --  ^ vertical: if true faces player using y axis only
            texture = "fire_basic_flame.png",
         })
         obj:punch(user, 1, itemstack:get_tool_capabilities())
         for i = 1, 5 do
            minetest.after(i, function()
               if obj and user and itemstack then
                  obj:punch(user, 1, itemstack:get_tool_capabilities())
               end
            end)
         end
         if not minetest.setting_getbool("creative_mode") then
            itemstack:add_wear(65535/499)
            return itemstack
         end
      elseif pointed_thing.type == "node" then
         local pos = user:get_pos()
         local radius = 5
         for x = -radius, radius do
         for z = -radius, radius do
         for y = 10, -10, -1 do
            local new_pos = {
               x = pos.x + x,
               y = pos.y + y,
               z = pos.z + z,
            }

            local node =  minetest.get_node(new_pos)
            local nodeu = minetest.get_node({x = new_pos.x, y = new_pos.y - 1, z = new_pos.z})
            local value = x * x + z * z
            if value <= radius * radius + 1
            and node.name == "air" and nodeu.name ~= "air"
            and not minetest.is_protected(new_pos, name) then
               minetest.set_node(new_pos, {name = "fire:basic_flame"})
               break
            end
         end
         end
         end
         if not minetest.setting_getbool("creative_mode") then
            itemstack:add_wear(65535/49)
            return itemstack
         end
      end
   end,
   tool_capabilities = {
      full_punch_interval = 0.25,
      max_drop_level=2,
      groupcaps={
         snappy={times={[1]=1.60, [2]=1.30, [3]=0.90}, uses=50, maxlevel=3},
      },
      damage_groups = {fleshy=5},
   }
})


--
-- Balrog entity
--

mobs:register_mob("mobs_balrog:balrog", {
   type = "monster",
   rotate = 180,
   hp_min = 200, -- 200: player's HPs * 100
   hp_max = 600, -- 600: (player's HPs * 100) * 3
   collisionbox = {-0.8, -2.1, -0.8, 0.8, 2.6, 0.8},
   visual_size = {x=2, y=2},
   visual = "mesh",
   mesh = "mobs_balrog.b3d",
   textures = {
      {"mobs_balrog_balrog.png"},
   },
   makes_footstep_sound = true,
   view_range = 45, -- when you see it, it can see you
   armor = 100, -- default
   walk_velocity = 2,
   run_velocity = 6,
   damage = 80, -- diamond sword * 10
   drops = {
      {name = "mobs_balrog:balrog_whip",
      chance = 10, -- 1 in 10
      min = 1,
      max = 1}
   },
   water_damage = 0.7, -- Ulmo dislikes balrogs
   lava_damage = 0, -- fire lesser-gods
   light_damage = 0, -- lesser-gods
   on_rightclick = nil,
   attack_type = "dogfight",
   animation = {
      stand_start = 0,
      stand_end = 240,
      walk_start = 240,
      walk_end = 300,
      punch_start = 300,
      punch_end = 380,
      speed_normal = 15,
      speed_run = 15,
   },
   jump = true,
   jump_height = 10, -- player's jump * 10
   sounds = {
      war_cry = "mobs_howl",
      death = "mobs_howl",
      attack = "mobs_stone_death",
   },

   on_die = function(self, pos)
   
      self.object:remove()
                  
      -- This has been taken from ../tnt/init.lua @243
      minetest.add_particlespawner({
         amount = 128,
         time = 0.1,
         minpos = vector.subtract(pos, 10 / 2),
         maxpos = vector.add(pos, 10 / 2),
         minvel = {x = -3, y = 0, z = -3},
         maxvel = {x = 3, y = 5,  z = 3},
         minacc = {x = 0, y = -10, z = 0},
         maxacc = {x = 0, y = -10, z = 0},
         minexptime = 0.8,
         maxexptime = 2.0,
         minsize = 10 * 0.66,
         maxsize = 10 * 2,
         texture = "fire_basic_flame.png",
         collisiondetection = true,
      })

   end,
})


mobs:spawn({name = "mobs_balrog:balrog",
	nodes = {"group:cracky"},
	neighbors = {"air"},
	max_light = 15, -- sun
	min_light = 0,
	interval = 30, -- default
	chance = 500000,
   -- half the chance of being struck by a lightning in real life
	active_object_count = 2,
	min_height = -30912,
	max_height = -2700, -- i.e. under dfcaverns_lava_sea_min
	day_toggle = nil,
})


mobs:register_egg("mobs_balrog:balrog",
	"Balrog",
	"default_lava.png", -- the texture displayed for the egg in inventory
	1, -- egg image in front of your texture (1 = yes, 0 = no)
	false -- if set to true this stops spawn egg appearing in creative
)

mobs:alias_mob("mobs:balrog", "mobs_balrog:balrog")
