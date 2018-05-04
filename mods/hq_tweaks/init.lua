--[[

	GPLv3 Copyright (C) 2018 Hamlet

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
-- Cavern spawner
--

local cave_spawn = minetest.settings:get_bool("cave_spawn")

if not cave_spawn then
   cave_spawn = false
   minetest.settings:set_bool("cave_spawn", cave_spawn)
end

if (cave_spawn == true) then
   subterrane:register_cave_spawn(
      {minimum_depth = -1500,
      maximum_depth = -2100,
      cave_treshold = 0.5}, -1800
   )
end


-- Load support for intllib.
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")


--
-- Minetest Game's tweaks
--

-- Disable lava buckets

minetest.unregister_item("bucket:bucket_lava")


-- Disable powered rails

minetest.clear_craft({output = "carts:powerrail"})
minetest.unregister_item("carts:powerrail")


-- Disable gun powder

minetest.clear_craft({output = "tnt:gunpowder"})
minetest.unregister_item("tnt:gunpowder")


-- Disable TNT

minetest.clear_craft({output = "tnt:tnt"})
minetest.unregister_item("tnt:tnt")


-- Allow walking through leaves/needles and climbing on them.

local PHANTOM_CLIMB = {walkable = false, climbable = true,}

minetest.override_item("default:leaves", PHANTOM_CLIMB)
minetest.override_item("default:jungleleaves", PHANTOM_CLIMB)
minetest.override_item("default:acacia_leaves", PHANTOM_CLIMB)
minetest.override_item("default:aspen_leaves", PHANTOM_CLIMB)
minetest.override_item("default:bush_leaves", PHANTOM_CLIMB)
minetest.override_item("default:acacia_bush_leaves", PHANTOM_CLIMB)
minetest.override_item("default:pine_needles", PHANTOM_CLIMB)


-- Increase the weapons' damage

local WOOD_DAMAGE = { tool_capabilities = {
   damage_groups = { fleshy = 4 },
   },
   range = 3,
}

local STONE_DAMAGE = { tool_capabilities = {
   damage_groups = { fleshy = 6 },
   },
   range = 3,
}

local STEEL_DAMAGE = { tool_capabilities = {
   damage_groups = { fleshy = 8 },
   },
   range = 3,
}

local BRONZE_DAMAGE = { tool_capabilities = {
   damage_groups = { fleshy = 8 },
   },
   range = 3,
}

local MESE_DAMAGE = { tool_capabilities = {
   damage_groups = { fleshy = 9 },
   },
   range = 3,
}

local DIAMOND_DAMAGE = { tool_capabilities = {
   damage_groups = { fleshy = 10 },
   },
   range = 3,
}

-- Swords

minetest.override_item("default:sword_wood", WOOD_DAMAGE)
minetest.override_item("default:sword_stone", STONE_DAMAGE)
minetest.override_item("default:sword_steel", STEEL_DAMAGE)
minetest.override_item("default:sword_bronze", BRONZE_DAMAGE)
minetest.override_item("default:sword_mese", MESE_DAMAGE)
minetest.override_item("default:sword_diamond", DIAMOND_DAMAGE)

--
-- 3D Armor's and Shields' settings
--

-- Disable wood armor and shields

local armor_material_wood = minetest.settings:get_bool("armor_material_wood")

if (armor_material_wood == nil) then

	minetest.clear_craft({output = "3d_armor:helmet_wood"})

	minetest.clear_craft({output = "3d_armor:chestplate_wood"})

	minetest.clear_craft({output = "3d_armor:leggings_wood"})

	minetest.clear_craft({output = "3d_armor:boots_wood"})

	minetest.clear_craft({output = "shields:shield_wood"})

	minetest.clear_craft({output = "shields:shield_enhanced_wood"})

	armor_material_wood = false

	minetest.settings:set_bool("armor_material_wood",armor_material_wood)

end

-- Disable cactus armor and shield

local armor_material_cactus = minetest.settings:get_bool("armor_material_cactus")

if (armor_material_cactus == nil) then

	minetest.clear_craft({output = "3d_armor:helmet_cactus"})

	minetest.clear_craft({output = "3d_armor:chestplate_cactus"})

	minetest.clear_craft({output = "3d_armor:leggings_cactus"})

	minetest.clear_craft({output = "3d_armor:boots_cactus"})

	minetest.clear_craft({output = "shields:shield_cactus"})

	minetest.clear_craft({output = "shields:shield_enhanced_cactus"})

	armor_material_cactus = false

	minetest.settings:set_bool("armor_material_cactus",
      armor_material_cactus)

end


--
-- Archer's module tweak
--

-- Enable just one recipe to avoid conflict with castle_weapons

minetest.clear_craft({output = "archer:arrow_steel"})

minetest.register_craft({
	output = "archer:arrow_steel 16",
	recipe = {
		{"default:steel_ingot", "group:stick", "group:stick"},
	}
})

-- Use Hard Trees Redo's rocks group to craft stone arrows

minetest.clear_craft({output = "archer:arrow"})

minetest.register_craft({
	output = "archer:arrow 3",
	recipe = {
		{"group:rocks", "group:stick", "group:stick"},
	}
})

minetest.register_craft({
	output = "archer:arrow 3",
	recipe = {
		{"group:stick", "group:stick", "group:rocks"},
	}
})


--
-- Castle Lighting's tweaks
--

-- Make the light block's recipe more expensive

minetest.clear_craft({output = "castle_lighting:light"})

minetest.register_craft({
	output = "castle_lighting:light",
	recipe = {
		{"default:stick", "default:glass", "default:stick"},
		{"default:glass", "default:mese_crystal", "default:glass"},
		{"default:stick", "default:glass", "default:stick"},
	}
})


-- Make the chandelier's recipe more expensive

minetest.clear_craft({output = "castle_lighting:chandelier"})

minetest.register_craft({
	output = "castle_lighting:chandelier",
	recipe = {
		{"", "", ""},
		{"", "default:steel_ingot", ""},
		{"default:mese_crystal_fragment",
		 "default:mese_crystal_fragment",
		 "default:mese_crystal_fragment"},
	}
})

-- change chain and chandelier's models and textures
-- these are by VanessaE from Homedecor - Chains (CC0)

minetest.override_item("castle_lighting:chandelier_chain", {
	drawtype = "mesh",
	mesh = "chains.obj",
	tiles = {"chains_wrought_iron.png"},
	walkable = false,
	climbable = true,
	sunlight_propagates = true,
	paramtype = "light",
	inventory_image = "chain_wrought_iron_inv.png",
	groups = {cracky=2},
	selection_box =  {
		type = "fixed",
			fixed = {
				{ -0.1, -0.625, -0.1, 0.1, 0.5, 0.1 }
			},
		},
	sounds = default.node_sound_glass_defaults(),
})

minetest.override_item("castle_lighting:chandelier", {
	drawtype = "mesh",
	mesh = "chains_chandelier.obj",
	wield_image = "",
	inventory_image = "",
	paramtype = "light",
	sunlight_propagates = true,
	groups = {cracky=2},
	light_source = 14,
	tiles = {
		"chains_wrought_iron.png",
		"chains_candle.png",
		{
			name="chains_candle_flame.png",
			animation={
				type="vertical_frames",
				aspect_w=16,
				aspect_h=16,
				length=3.0
			}
		}
	},

	sounds = default.node_sound_glass_defaults(),
})


--
-- Charcoal's tweak
--

-- Allow to craft a charcoal block.
-- Source code taken from Minetest Game

minetest.register_node("hq_tweaks:charcoal_block", {
	description = S("Charcoal Block"),
	tiles = {"hq_tweaks_charcoal_block.png"},
	is_ground_content = false,
	groups = {cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = "hq_tweaks:charcoal_block",
	recipe = {
		{"charcoal:charcoal_lump", "charcoal:charcoal_lump",
			"charcoal:charcoal_lump"},
		{"charcoal:charcoal_lump", "charcoal:charcoal_lump",
			"charcoal:charcoal_lump"},
		{"charcoal:charcoal_lump", "charcoal:charcoal_lump",
			"charcoal:charcoal_lump"},
	}
})

minetest.register_craft({
	type = "fuel",
	recipe = "hq_tweaks:charcoal_block",
	burntime = 370,
})

minetest.register_craft({
	output = "charcoal:charcoal_lump 9",
	recipe = {
		{"hq_tweaks:charcoal_block"},
	}
})


--
-- Darkage's tweaks
--

-- Make the glow glass' recipe more expensive

minetest.clear_craft({output = "darkage:glow_glass"})

minetest.register_craft({
	output = "darkage:glow_glass 1",
	recipe = {
		{"darkage:glass"},
		{"default:mese_crystal"},
	}
})


-- Make the lamp's recipe more expensive

minetest.clear_craft({output = "darkage:lamp"})

minetest.register_craft({
	output = "darkage:lamp",
	recipe = {
		{"group:stick", ""                    , "group:stick"},
		{""           , "default:mese_crystal", ""},
		{"group:stick", ""                    , "group:stick"},
	}
})


--
-- DFCaverns' tweaks
--

-- Add bioluminescence to some nodes to improve gameplay

minetest.override_item("dfcaverns:blood_thorn", {
	light_source = 5,
	}
)

minetest.override_item("dfcaverns:dirt_with_cave_moss", {
	light_source = 5,
	}
)

minetest.override_item("dfcaverns:cobble_with_floor_fungus", {
	light_source = 5,
	}
)

minetest.override_item("dfcaverns:nether_cap", {
	light_source = 5,
	}
)

minetest.override_item("dfcaverns:black_cap_stem", {
	light_source = 5,
	}
)

minetest.override_item("dfcaverns:tower_cap", {
	light_source = 5,
	}
)

minetest.override_item("dfcaverns:spore_tree_hyphae", {
	light_source = 5,
	}
)

minetest.override_item("dfcaverns:tunnel_tube", {
	light_source = 5,
	}
)

minetest.override_item("dfcaverns:goblin_cap", {
	light_source = 5,
	}
)


--
-- Real Minerals' tweaks
--

-- Allow converting certain ingots to default ingots and vice-versa

-- Real Minerals to default

minetest.register_craft({
	output = "default:bronze_ingot",
	recipe = {
		{"real_minerals:bronze_ingot"},
	}
})

minetest.register_craft({
	output = "default:copper_ingot",
	recipe = {
		{"real_minerals:copper_ingot"},
	}
})

minetest.register_craft({
	output = "default:gold_ingot",
	recipe = {
		{"real_minerals:gold_ingot"},
	}
})

minetest.register_craft({
	output = "default:steel_ingot",
	recipe = {
		{"real_minerals:black_steel_ingot"},
	}
})

minetest.register_craft({
	output = "default:steel_ingot",
	recipe = {
		{"real_minerals:steel_ingot"},
	}
})

minetest.register_craft({
	output = "default:tin_ingot",
	recipe = {
		{"real_minerals:tin_ingot"},
	}
})

-- Default to Real Minerals

minetest.register_craft({
	output = "real_minerals:bronze_ingot",
	recipe = {
		{"default:bronze_ingot"},
	}
})

minetest.register_craft({
	output = "real_minerals:copper_ingot",
	recipe = {
		{"default:copper_ingot"},
	}
})

minetest.register_craft({
	output = "real_minerals:gold_ingot",
	recipe = {
		{"default:gold_ingot"},
	}
})

minetest.register_craft({
	output = "real_minerals:steel_ingot",
	recipe = {
		{"default:steel_ingot"},
	}
})

minetest.register_craft({
	output = "real_minerals:tin_ingot",
	recipe = {
		{"default:tin_ingot"},
	}
})

-- Allow to revert metal blocks to ingots

minetest.register_craft({
	output = "real_minerals:aluminium_ingot 9",
	recipe = {
		{"real_minerals:aluminium_block"},
	}
})

minetest.register_craft({
	output = "real_minerals:bismuth_ingot 9",
	recipe = {
		{"real_minerals:bismuth_block"},
	}
})

minetest.register_craft({
	output = "real_minerals:bronze_ingot 9",
	recipe = {
		{"real_minerals:bronze_block"},
	}
})

minetest.register_craft({
	output = "real_minerals:copper_ingot 9",
	recipe = {
		{"real_minerals:copper_block"},
	}
})

minetest.register_craft({
	output = "real_minerals:gold_ingot 9",
	recipe = {
		{"real_minerals:gold_block"},
	}
})

minetest.register_craft({
	output = "real_minerals:lead_ingot 9",
	recipe = {
		{"real_minerals:lead_block"},
	}
})

minetest.register_craft({
	output = "real_minerals:nickel_ingot 9",
	recipe = {
		{"real_minerals:nickel_block"},
	}
})

minetest.register_craft({
	output = "real_minerals:pig_iron_ingot 9",
	recipe = {
		{"real_minerals:pig_iron_block"},
	}
})

minetest.register_craft({
	output = "real_minerals:platinum_ingot 9",
	recipe = {
		{"real_minerals:platinum_block"},
	}
})

minetest.register_craft({
	output = "real_minerals:silver_ingot 9",
	recipe = {
		{"real_minerals:silver_block"},
	}
})

minetest.register_craft({
	output = "real_minerals:steel_ingot 9",
	recipe = {
		{"real_minerals:steel_block"},
	}
})

minetest.register_craft({
	output = "real_minerals:tin_ingot 9",
	recipe = {
		{"real_minerals:tin_block"},
	}
})

minetest.register_craft({
	output = "real_minerals:zinc_ingot 9",
	recipe = {
		{"real_minerals:zinc_block"},
	}
})


--
-- Real Torch's tweaks
--

-- Allow using charcoal to craft coal powder

-- 2x coal lumps = 12x coal powder
minetest.register_craft({
	type = "shapeless",
	output = "real_torch:coal_powder 12",
	recipe = {"charcoal:charcoal_lump", "charcoal:charcoal_lump"},
})

-- Disable the light source for unlit torches

minetest.override_item("real_torch:torch", {
	light_source = 0,
	}
)

minetest.override_item("real_torch:torch_wall", {
	light_source = 0,
	}
)

minetest.override_item("real_torch:torch_ceiling", {
	light_source = 0,
	}
)


--
-- Real Trees' tweaks
--

-- Allow walking through leaves/needles and climbing on them.

minetest.override_item("real_trees:small_acacia_leaves", PHANTOM_CLIMB)
minetest.override_item("real_trees:corner_acacia_leaves", PHANTOM_CLIMB)
minetest.override_item("real_trees:wide_acacia_leaves", PHANTOM_CLIMB)
minetest.override_item("real_trees:acacia_leaf_slab",	PHANTOM_CLIMB)

minetest.override_item("real_trees:small_jungle_leaves", PHANTOM_CLIMB)
minetest.override_item("real_trees:corner_jungle_leaves", PHANTOM_CLIMB)
minetest.override_item("real_trees:wide_jungle_leaves", PHANTOM_CLIMB)
minetest.override_item("real_trees:jungle_leaf_slab", PHANTOM_CLIMB)

minetest.override_item("real_trees:small_leaves", PHANTOM_CLIMB)
minetest.override_item("real_trees:corner_leaves", PHANTOM_CLIMB)
minetest.override_item("real_trees:wide_leaves", PHANTOM_CLIMB)
minetest.override_item("real_trees:leaf_slab", PHANTOM_CLIMB)

minetest.override_item("real_trees:small_aspen_leaves", PHANTOM_CLIMB)
--minetest.override_item("real_trees:u_small_aspen_leaves", PHANTOM_CLIMB)
minetest.override_item("real_trees:corner_aspen_leaves", PHANTOM_CLIMB)
minetest.override_item("real_trees:wide_aspen_leaves", PHANTOM_CLIMB)
minetest.override_item("real_trees:aspen_leaf_slab", PHANTOM_CLIMB)

minetest.override_item("real_trees:small_pine_needles", PHANTOM_CLIMB)
minetest.override_item("real_trees:corner_pine_needles", PHANTOM_CLIMB)
minetest.override_item("real_trees:m_corner_pine_needles",PHANTOM_CLIMB)
minetest.override_item("real_trees:wide_pine_needles", PHANTOM_CLIMB)
minetest.override_item("real_trees:m_wide_pine_needles",	PHANTOM_CLIMB)
minetest.override_item("real_trees:pine_needle_slab", PHANTOM_CLIMB)
minetest.override_item("real_trees:b_pine_needle_slab", PHANTOM_CLIMB)
minetest.override_item("real_trees:m_pine_needle_slab", PHANTOM_CLIMB)
