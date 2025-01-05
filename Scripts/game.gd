extends Node


# Reference to the TileMapLayer node
@onready var map = $map  
#noise setup
@export var noise_height_text: NoiseTexture2D
var noise: Noise
#tileset pixel size
const TILE_SIZE: int = 16
#map gen check
var map_gen = false
#arrays for tilemap tile locations 
var water_tiles: Array = []
var grass_tiles: Array = []
var loaded_chunks: Dictionary = {}
#tile ids
var water_id = 1
var grass_id = 0
# Variables to store chunk data
var new_seed
var map_size_x
var map_size_y
var tilemap_id

#get map data from gen_options and set seed
func set_map_data(chunk_data: Dictionary) -> void:
	new_seed = chunk_data["new_seed"]
	map_size_x = chunk_data["map_size_x"]
	map_size_y = chunk_data["map_size_y"]
	tilemap_id = chunk_data["tilemap_id"]
	noise = noise_height_text.noise
	noise.set_seed(new_seed)
	
func _ready() -> void:
	gen_map()
	
# Generate map tiles and store in loaded_chunks for build_map
func gen_map() -> void:
	if map_gen == true or map_size_x == -1 or map_size_y == -1:
		gen_map()
		return


	map_gen = true
	print("Generating map with - Seed:", new_seed, "X:", map_size_x, "Y:", map_size_y)
	for x in range(map_size_x):
		for y in range(map_size_y):
			var noise_val: float = noise.get_noise_2d(x, y)
			var tile_pos = Vector2i(x, y)

			if noise_val < 0.0:
				water_tiles.append(tile_pos)
			else:
				grass_tiles.append(tile_pos)

	loaded_chunks["map"] = {
		"water_tiles": water_tiles,
		"grass_tiles": grass_tiles
	}
	build_map()
	place_buildings()


# build the map based on loaded_chunks stored data 
func build_map() -> void:
	if water_tiles.is_empty() or grass_tiles.is_empty():
		print("No map data available to build.")
		return
	# Set grass tiles
	map.set_cells_terrain_connect(grass_tiles, tilemap_id, grass_id, false)

	# Set water tiles
	map.set_cells_terrain_connect(water_tiles, tilemap_id, water_id, false)

	print("Map built successfully with grass and water tiles.")

# Place buildings using the grass_tiles
func place_buildings() -> void:
	var buildings_scene = load("res://Scenes/buildings.tscn")
	var buildings_instance = buildings_scene.instantiate()

	# Convert Vector2i to Vector2 for consistency
	var grass_tile_list = []
	for tile in grass_tiles:
		grass_tile_list.append(Vector2(tile.x, tile.y))

	# Add buildings to the scene and process the tiles
	add_child(buildings_instance)
	buildings_instance.process_tiles(grass_tile_list)
	CreateJob.create_job()
	CreateJob.create_job()
	CreateJob.create_job()
	CreateJob.create_job()
	CreateJob.create_job()
	CreateJob.create_job()
