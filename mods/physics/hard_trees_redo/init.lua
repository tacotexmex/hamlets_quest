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
-- General variables
--

local minetest_log_level = minetest.settings:get("debug_log_level")
local mod_load_message = "[Mod] Hard Trees Redo [v0.1.1] loaded."
local mod_path = minetest.get_modpath("hard_trees_redo")


--
-- Load support for intllib.
--

local S, NS = dofile(mod_path .. "/intllib.lua")


--
-- New nodes support toggle
--

hard_trees_redo_new = minetest.settings:get_bool("hard_trees_redo_new")

if not hard_trees_redo_new then
	hard_trees_redo_new = false
	minetest.settings:set_bool("hard_trees_redo_new", false)
end


--
-- Rarity constants
--

local COMMON = 5      -- drop chance: 20%
local AVERAGE = 6.665 -- drop chance: 15%
local SCARCE = 10     -- drop chance: 10%


--
-- Goups to be assigned
--

local bushes_groups = {
	groups = {choppy = 2, flammable = 2}
}

-- Applies to acacia, jungle tree, tree

local tree_groups_a = {
	groups = {
		tree = 1, choppy = 2, flammable = 2
	}
}

-- Applies to aspen and pine

local tree_groups_b = {
	groups = {
		tree = 1, choppy = 3, flammable = 3,
	}
}

if minetest.get_modpath("fallen_trees") then

	bushes_groups = {
		groups = {choppy = 2, flammable = 2, falling_node = 1}
	}

	tree_groups_a = {
		groups = {
			tree = 1, choppy = 2, flammable = 2, falling_node = 1
		}
	}

	tree_groups_b = {
		groups = {
			tree = 1, choppy = 3, flammable = 3, falling_node = 1
		}
	}

end


--
-- Overriden bush nodes
--

local bushes_nodes = {"default:acacia_bush_stem", "default:bush_stem"}


--
-- Overriden tree nodes
--

local tree_nodes_a = {
	"default:acacia_tree", "default:jungletree", "default:tree"
}

local tree_nodes_b = {"default:aspen_tree", "default:pine_tree"}


--
-- Overriden leaf nodes
--

local ID_01 = "default:acacia_bush_leaves"
local ID_02 = "default:acacia_leaves"
local ID_03 = "default:aspen_leaves"
local ID_04 = "default:bush_leaves"
local ID_05 = "default:jungleleaves"
local ID_06 = "default:pine_needles"
local ID_07 = "default:leaves"


--
-- Overriden dirt nodes
--

local ID_08 = "default:dirt"
local ID_09 = "default:dirt_with_grass"
local ID_10 = "default:dirt_with_grass_footsteps"
local ID_11 = "default:dirt_with_dry_grass"
local ID_12 = "default:dirt_with_snow"
local ID_13 = "default:dirt_with_rainforest_litter"

if (hard_trees_redo_new == true) then

	ID_14 = "default:dirt_with_coniferous_litter"

end


--
-- Overriden stone nodes
--

local ID_15 = "default:stone"
local ID_16 = "default:cobble"
local ID_17 = "default:mossycobble"
local ID_18 = "default:desert_stone"
local ID_19 = "default:desert_cobble"
local ID_20 = "default:flint"


--
-- Wooden nodes groups' overriders
--

for n = 1, 2 do
	minetest.override_item(bushes_nodes[n], bushes_groups)
end

for n = 1, 3 do
	minetest.override_item(tree_nodes_a[n], tree_groups_a)
end

for n = 1, 2 do
	minetest.override_item(tree_nodes_b[n], tree_groups_b)
end


--
-- Leaves nodes drops' overriders
--

minetest.override_item(ID_01, {
	drop = {
		max_items = 2,
		items = {
			{items = {"default:acacia_bush_sapling"}, rarity = 5},
			{items = {"default:acacia_bush_leaves"}},
			{items = {"default:stick"}, rarity = SCARCE}
		}
	}
})

minetest.override_item(ID_02, {
	drop = {
		max_items = 2,
		items = {
			{items = {"default:acacia_sapling"}, rarity = 20},
			{items = {"default:acacia_leaves"}},
			{items = {"default:stick"}, rarity = SCARCE}
		}
	}
})

minetest.override_item(ID_03, {
	drop = {
		max_items = 2,
		items = {
			{items = {"default:aspen_sapling"}, rarity = 20},
			{items = {"default:aspen_leaves"}},
			{items = {"default:stick"}, rarity = AVERAGE}
		}
	}
})


minetest.override_item(ID_04, {
	drop = {
		max_items = 2,
		items = {
			{items = {"default:bush_sapling"}, rarity = 5},
			{items = {"default:bush_leaves"}},
			{items = {"default:stick"}, rarity = AVERAGE}
		}
	}
})

minetest.override_item(ID_05, {
	drop = {
		max_items = 2,
		items = {
			{items = {"default:junglesapling"}, rarity = 20},
			{items = {"default:jungleleaves"}},
			{items = {"default:stick"}, rarity = COMMON}
		}
	}
})

minetest.override_item(ID_06, {
	drop = {
		max_items = 2,
		items = {
			{items = {"default:pine_sapling"}, rarity = 20},
			{items = {"default:pine_needles"}},
			{items = {"default:stick"}, rarity = SCARCE}
		}
	}
})


minetest.override_item(ID_07, {
	drop = {
		max_items = 2,
		items = {
			{items = {"default:sapling"}, rarity = 20},
			{items = {"default:leaves"}},
			{items = {"default:stick"}, rarity = AVERAGE}
		}
	}
})


--
-- Dirt nodes drops' overriders
--

minetest.override_item(ID_08, {
	drop = {
		max_items = 2,
		items = {
			{items = {"default:dirt"}},
			{items = {"hard_trees_redo:rock"}, rarity = AVERAGE}
		}
	}
})

minetest.override_item(ID_09, {
	drop = {
		max_items = 2,
		items = {
			{items = {"default:dirt"}},
			{items = {"hard_trees_redo:rock"}, rarity = AVERAGE}
		}
	}
})

minetest.override_item(ID_10, {
	drop = {
		max_items = 2,
		items = {
			{items = {"default:dirt"}},
			{items = {"hard_trees_redo:rock"}, rarity = AVERAGE}
		}
	}
})

minetest.override_item(ID_11, {
	drop = {
		max_items = 2,
		items = {
			{items = {"default:dirt"}},
			{items = {"hard_trees_redo:rock"}, rarity = COMMON}
		}
	}
})

minetest.override_item(ID_12, {
	drop = {
		max_items = 2,
		items = {
			{items = {"default:dirt"}},
			{items = {"hard_trees_redo:rock"}, rarity = COMMON}
		}
	}
})

minetest.override_item(ID_13, {
	drop = {
		max_items = 2,
		items = {
			{items = {"default:dirt"}},
			{items = {"hard_trees_redo:rock"}, rarity = SCARCE}
		}
	}
})

if (hard_trees_redo_new == true) then

	minetest.override_item(ID_14, {
		drop = {
			max_items = 2,
			items = {
				{items = {"default:dirt"}},
				{items = {"hard_trees_redo:rock"}, rarity = COMMON}
			}
		}
	})

end


--
-- Stone nodes drops' overriders
--

minetest.override_item(ID_15, {
	drop = {
		max_items = 2,
		items = {
			{items = {"default:cobble"}},
			{items = {"hard_trees_redo:rock"}, rarity = COMMON}
		}
	}
})

minetest.override_item(ID_16, {
	drop = {
		max_items = 2,
		items = {
			{items = {"default:cobble"}},
			{items = {"hard_trees_redo:rock"}, rarity = AVERAGE}
		}
	}
})

minetest.override_item(ID_17, {
	drop = {
		max_items = 2,
		items = {
			{items = {"default:mossycobble"}},
			{items = {"hard_trees_redo:rock"}, rarity = AVERAGE}
		}
	}
})

minetest.override_item(ID_18, {
	drop = {
		max_items = 2,
		items = {
			{items = {"default:desert_cobble"}},
			{items = {"hard_trees_redo:rock_desert"}, rarity = COMMON}
		}
	}
})

minetest.override_item(ID_19, {
	drop = {
		max_items = 2,
		items = {
			{items = {"default:desert_cobble"}},
			{items = {"hard_trees_redo:rock_desert"}, rarity = AVERAGE}
		}
	}
})


--
-- Nodes reassigned to the "rocks" group
--

minetest.override_item(ID_20, {
	groups = {rocks = 1}
})


--
-- Wooden tools' removers
--

minetest.unregister_item("default:axe_wood")
minetest.clear_craft{output = "default:axe_wood"}

minetest.unregister_item("default:pick_wood")
minetest.clear_craft{output = "default:pick_wood"}


--
-- Additional items and tools recipes" (re)definitions
--

minetest.register_craftitem("hard_trees_redo:rock", {
	description = S("Rock"),
	inventory_image = "hard_trees_redo_rock.png",
	groups = {rocks = 1},
})

minetest.register_craftitem("hard_trees_redo:rock_desert", {
	description = S("Desert Rock"),
	inventory_image = "hard_trees_redo_rock_desert.png",
	groups = {rocks = 1},
})

-- Aliases for backward compatibility

minetest.register_alias("ht_redo:rock", "hard_trees_redo:rock")
minetest.register_alias("ht_redo:rock_desert",
	"hard_trees_redo:rock_desert")


minetest.register_craft({
	output = "default:cobble",
	recipe = {
		{"hard_trees_redo:rock", "hard_trees_redo:rock", "hard_trees_redo:rock"},
		{"hard_trees_redo:rock", "hard_trees_redo:rock", "hard_trees_redo:rock"},
		{"hard_trees_redo:rock", "hard_trees_redo:rock", "hard_trees_redo:rock"},
	}
})

minetest.register_craft({
  output = "default:desert_cobble",
  recipe = {
  {"hard_trees_redo:rock_desert",
	"hard_trees_redo:rock_desert",
	"hard_trees_redo:rock_desert"},
  {"hard_trees_redo:rock_desert",
	"hard_trees_redo:rock_desert",
	"hard_trees_redo:rock_desert"},
  {"hard_trees_redo:rock_desert",
	"hard_trees_redo:rock_desert",
	"hard_trees_redo:rock_desert"},
  }
})


minetest.clear_craft({output = "default:axe_stone"})

minetest.register_craft({
	output = "default:axe_stone",
	recipe = {
		{"group:rocks", "group:rocks"},
		{"group:rocks", "group:stick"},
		{""			  , "group:stick"},
	}
})


minetest.clear_craft({output = "default:pick_stone"})

minetest.register_craft({
	output = "default:pick_stone",
	recipe = {
		{"group:rocks", "group:rocks", "group:rocks"},
		{"",            "group:stick", ""           },
		{"",            "group:stick", ""           },
	}
})


minetest.clear_craft({output = "default:shovel_stone"})

minetest.register_craft({
	output = "default:shovel_stone",
	recipe = {
		{"group:rocks"},
		{"group:stick"},
		{"group:stick"},
	}
})


minetest.clear_craft({output = "default:sword_stone"})

minetest.register_craft({
	output = "default:sword_stone",
	recipe = {
		{"group:rocks"},
		{"group:rocks"},
		{"group:stick"},
	}
})


minetest.clear_craft({output = "farming:hoe_stone"})

minetest.register_craft({
	output = "farming:hoe_stone",
	recipe = {
		{"group:rocks", "group:rocks"},
		{""           , "group:stick"},
		{""           , "group:stick"},
	}
})


--
-- Support for [Mod] Real Trees [real_trees]
--

if minetest.get_modpath("real_trees") then
	dofile(mod_path .. "/real_trees.lua")
end


--
-- Support for [Mod] Desert Life [desert_life]
--

if minetest.get_modpath("desert_life") then
	dofile(mod_path .. "/desert_life.lua")
end


--
-- Minetest engine debug logging
--

if (minetest_log_level == nil) or (minetest_log_level == "action") or
	(minetest_log_level == "info") or (minetest_log_level == "verbose") then

	minetest.log("action", mod_load_message)
end
