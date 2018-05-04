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
-- Rarity constants
--

local AVERAGE = 6.665  -- drop chance: 15%
local SCARCE = 10      -- drop chance: 10%
local RARE = 20        -- drop chance: 5%


--
-- Trees groups' constants
--

-- Applies to acacia, jungle tree, tree

local group_nodes_a = {
   groups = {
      tree = 1, choppy = 2, flammable = 2
   }
}

if minetest.get_modpath("fallen_trees") then
   group_nodes_a = {
      groups = {
	 tree = 1, choppy = 2, flammable = 2, falling_node = 1
      }
   }
end

-- Applies to aspen and pine

local group_nodes_b = {
   groups = {
      tree = 1, choppy = 3, flammable = 3
   }
}

if minetest.get_modpath("fallen_trees") then
   group_nodes_b = {
      groups = {
	 tree = 1, choppy = 3, flammable = 3, falling_node = 1
      }
   }
end


--
-- Nodes to be overriden
--

local tree_nodes_a = {
   "real_trees:large_acacia_tree", "real_trees:large_jungle_tree",
   "real_trees:large_tree", "real_trees:medium_acacia_tree",
   "real_trees:medium_jungle_tree", "real_trees:medium_tree",
   "real_trees:small_acacia_tree", "real_trees:small_jungle_tree",
   "real_trees:small_tree", "real_trees:corner_acacia_tree",
   "real_trees:t_corner_acacia_tree", "real_trees:h_large_acacia_tree",
   "real_trees:a_small_acacia_tree", "real_trees:a_medium_acacia_tree",
   "real_trees:a_large_acacia_tree", "real_trees:a_small_jungle_tree",
   "real_trees:a_medium_jungle_tree", "real_trees:a_large_jungle_tree",
   "real_trees:a_small_tree", "real_trees:a_medium_tree",
   "real_trees:a_large_tree"
}

local tree_nodes_b = {
   "real_trees:large_aspen_tree", "real_trees:large_pine_tree",
   "real_trees:medium_aspen_tree", "real_trees:medium_pine_tree",
   "real_trees:small_aspen_tree", "real_trees:small_pine_tree",
   "real_trees:a_small_pine_tree", "real_trees:a_medium_pine_tree",
   "real_trees:a_large_pine_tree", "real_trees:a_small_aspen_tree",
   "real_trees:a_medium_aspen_tree", "real_trees:a_large_aspen_tree"
}

--
-- Overriden leaves and needles' nodes
--

local ID_0 = "real_trees:acacia_leaf_slab"
local ID_1 = "real_trees:aspen_leaf_slab"
local ID_2 = "real_trees:jungle_leaf_slab"
local ID_3 = "real_trees:pine_needle_slab"
local ID_4 = "real_trees:leaf_slab"


--
-- Wooden nodes groups' overriders
--

for n = 1, 21 do
   minetest.override_item(tree_nodes_a[n], group_nodes_a)
end

for n = 1, 12 do
   minetest.override_item(tree_nodes_a[n], group_nodes_b)
end


--
-- Leaves nodes drops' overriders
--

minetest.override_item(ID_0, {
   drop = {
      max_items = 2,
	 items = {
	    {items = {"default:acacia_sapling"}, rarity = 40},
	    {items = {"real_trees:acacia_leaf_slab"}},
	    {items = {"default:stick"}, rarity = RARE}
	 }
   }
})

minetest.override_item(ID_1, {
   drop = {
      max_items = 2,
	 items = {
	    {items = {"default:aspen_sapling"}, rarity = 40},
	    {items = {"real_trees:aspen_leaf_slab"}},
	    {items = {"default:stick"}, rarity = SCARCE}
	 }
   }
})

minetest.override_item(ID_2, {
   drop = {
      max_items = 2,
	 items = {
	    {items = {"default:junglesapling"}, rarity = 40},
	    {items = {"real_trees:jungle_leaf_slab"}},
	    {items = {"default:stick"}, rarity = AVERAGE}
	 }
   }
})

minetest.override_item(ID_3, {
   drop = {
      max_items = 2,
	 items = {
	    {items = {"default:pine_sapling"}, rarity = 40},
	    {items = {"real_trees:pine_needle_slab"}},
	    {items = {"default:stick"}, rarity = RARE}
	 }
   }
})


minetest.override_item(ID_4, {
   drop = {
      max_items = 2,
	 items = {
	    {items = {"default:sapling"}, rarity = 40},
	    {items = {"real_trees:leaf_slab"}},
	    {items = {"default:stick"}, rarity = SCARCE}
	 }
   }
})
