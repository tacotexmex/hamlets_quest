-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

--stem
minetest.register_node("dfcaverns:black_cap_stem", {
	description = S("Black Cap Stem"),
	_doc_items_longdesc = dfcaverns.doc.black_cap_desc,
	_doc_items_usagehelp = dfcaverns.doc.black_cap_usage,
	tiles = {"dfcaverns_black_cap_top.png","dfcaverns_black_cap_top.png","dfcaverns_black_cap_side.png",},
	is_ground_content = true,
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
})

--cap
minetest.register_node("dfcaverns:black_cap", {
	description = S("Black Cap"),
	_doc_items_longdesc = dfcaverns.doc.black_cap_desc,
	_doc_items_usagehelp = dfcaverns.doc.black_cap_usage,
	tiles = {"dfcaverns_black_cap_top.png","dfcaverns_black_cap_top.png","dfcaverns_black_cap_side.png^[transformR90",},
	is_ground_content = true,
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
})

--gills
minetest.register_node("dfcaverns:black_cap_gills", {
	description = S("Black Cap Gills"),
	_doc_items_longdesc = dfcaverns.doc.black_cap_desc,
	_doc_items_usagehelp = dfcaverns.doc.black_cap_usage,
	tiles = {"dfcaverns_black_cap_gills.png"},
	is_ground_content = true,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	sounds = default.node_sound_leaves_defaults(),
	drawtype = "plantlike",
	paramtype = "light",
	drop = {
		max_items = 1,
		items = {
			{
				items = {'dfcaverns:black_cap_sapling'},
				rarity = 5,
			},
			{
				items = {'dfcaverns:black_cap_gills'},
			}
		}
	},
	after_place_node = default.after_place_leaves,
})

if default.register_leafdecay then -- default.register_leafdecay is very new, remove this check some time after 0.4.16 is released
	default.register_leafdecay({
		trunks = {"dfcaverns:black_cap"}, -- don't need stem nodes here
		leaves = {"dfcaverns:black_cap_gills"},
		radius = 1,	
	})
end

-- Wood
minetest.register_craft({
	output = 'dfcaverns:black_cap_wood 4',
	recipe = {
		{'dfcaverns:black_cap'},
	}
})

minetest.register_craft({
	output = 'dfcaverns:black_cap_wood 4',
	recipe = {
		{'dfcaverns:black_cap_stem'},
	}
})

minetest.register_node("dfcaverns:black_cap_wood", {
	description = S("Black Cap Planks"),
	_doc_items_longdesc = dfcaverns.doc.black_cap_desc,
	_doc_items_usagehelp = dfcaverns.doc.black_cap_usage,
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"dfcaverns_black_cap_wood.png"},
	is_ground_content = false,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, wood = 1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_craft({
	type = "fuel",
	recipe = "dfcaverns:black_cap_wood",
	burntime = 30,
})
minetest.register_craft({
	type = "fuel",
	recipe = "dfcaverns:black_cap",
	burntime = 120,
})
minetest.register_craft({
	type = "fuel",
	recipe = "dfcaverns:black_cap_stem",
	burntime = 120,
})
minetest.register_craft({
	type = "fuel",
	recipe = "dfcaverns:black_cap_gills",
	burntime = 6,
})
minetest.register_craft({
	type = "fuel",
	recipe = "dfcaverns:black_cap_sapling",
	burntime = 6,
})

-- sapling
minetest.register_node("dfcaverns:black_cap_sapling", {
	description = S("Black Cap Spawn"),
	_doc_items_longdesc = dfcaverns.doc.black_cap_desc,
	_doc_items_usagehelp = dfcaverns.doc.black_cap_usage,
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"dfcaverns_black_cap_sapling.png"},
	inventory_image = "dfcaverns_black_cap_sapling.png",
	wield_image = "dfcaverns_black_cap_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
	},
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1, light_sensitive_fungus = 11},
	sounds = default.node_sound_leaves_defaults(),

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(
			dfcaverns.config.black_cap_delay_multiplier*dfcaverns.config.tree_min_growth_delay,
			dfcaverns.config.black_cap_delay_multiplier*dfcaverns.config.tree_max_growth_delay))
	end,
	
	on_timer = function(pos)
		minetest.set_node(pos, {name="air"})
		dfcaverns.spawn_black_cap(pos)
	end,
})

local c_stem = minetest.get_content_id("dfcaverns:black_cap_stem")
local c_cap  = minetest.get_content_id("dfcaverns:black_cap")
local c_gills = minetest.get_content_id("dfcaverns:black_cap_gills")

dfcaverns.spawn_black_cap = function(pos)
	local x, y, z = pos.x, pos.y, pos.z
	local stem_height = math.random(1,5)
	local cap_radius = math.random(2,3)
	local maxy = y + stem_height + 3

	local vm = minetest.get_voxel_manip()
	local minp, maxp = vm:read_from_map(
		{x = x - cap_radius, y = y, z = z - cap_radius},
		{x = x + cap_radius, y = maxy + 3, z = z + cap_radius}
	)
	local area = VoxelArea:new({MinEdge = minp, MaxEdge = maxp})
	local data = vm:get_data()

	subterrane:giant_shroom(area:indexp(pos), area, data, c_stem, c_cap, c_gills, stem_height, cap_radius)
	
	vm:set_data(data)
	vm:write_to_map()
	vm:update_map()
end

dfcaverns.spawn_black_cap_vm = function(vi, area, data)
	local stem_height = math.random(1,5)
	local cap_radius = math.random(2,3)
	
	subterrane:giant_shroom(vi, area, data, c_stem, c_cap, c_gills, stem_height, cap_radius)
end

