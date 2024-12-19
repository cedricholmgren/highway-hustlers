extends Node2D

@onready var autogen = $autogen
@export var noise_height_text: NoiseTexture2D
var noise: Noise
var map_initialized: bool = false
var loaded_chunks: Dictionary = {}
var new_seed = 0
var MAP_SIZE_X = 100
var MAP_SIZE_Y = 100
const TILE_SIZE: int = 16
var water_tile = 1
var grass_tile = 0
var map_gen = false


func _process_seed(seed_value: int) ->void:
	new_seed = seed_value
	print(new_seed, seed_value)
	
func _redefine_map_x(set_map_x: int) -> void:
	MAP_SIZE_X = set_map_x
	print("x:", set_map_x, MAP_SIZE_X)
	
func _redefine_map_y(set_map_y: int) -> void:
	MAP_SIZE_Y = set_map_y
	print("y:", set_map_y, MAP_SIZE_Y)

func initialize_map(seed_value: int, set_map_x: int, set_map_y: int) -> void:
	print("Initializing map with seed:", seed_value, "X:", set_map_x, "Y:", set_map_y)

func _ready():
	print("mappers:", new_seed, MAP_SIZE_X, MAP_SIZE_Y)
	initialize_map(new_seed, MAP_SIZE_X, MAP_SIZE_Y)
	noise = noise_height_text.noise
	noise.set_seed(new_seed)
	gen_map()
	place_buildings()

func gen_map() -> void:
	if map_gen == true:
		return
	
	map_gen = true
	var water_tiles: Array[Vector2i] = []
	var grass_tiles: Array[Vector2i] = []
	print("Generating map with - Seed:", new_seed, "X:", MAP_SIZE_X, "Y:", MAP_SIZE_Y)
	for x in range(MAP_SIZE_X):
		for y in range(MAP_SIZE_Y):
			var noise_val: float = noise.get_noise_2d(x, y)
			var tile_pos = Vector2i(x, y)

			if noise_val < 0.0:
				water_tiles.append(tile_pos)
			else:
				grass_tiles.append(tile_pos)

	if grass_tiles.size() > 0:
		autogen.set_cells_terrain_connect(grass_tiles, 0, grass_tile, false)
	if water_tiles.size() > 0:
		autogen.set_cells_terrain_connect(water_tiles, 0, water_tile, false)

	loaded_chunks["map"] = {
		"water_tiles": water_tiles,
		"grass_tiles": grass_tiles
	}

# Place buildings using the grass_tiles
func place_buildings() -> void:
	var buildings_scene = load("res://Scenes/buildings.tscn")
	var buildings_instance = buildings_scene.instantiate()

	# Convert Vector2i to Vector2 for consistency
	var grass_tile_list = []
	for tile in loaded_chunks["map"]["grass_tiles"]:
		grass_tile_list.append(Vector2(tile.x, tile.y))

	# Add buildings to the scene and process the tiles
	add_child(buildings_instance)
	buildings_instance.process_tiles(grass_tile_list)
