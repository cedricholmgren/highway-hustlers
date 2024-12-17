extends Node2D

@onready var autogen = $autogen
@export var noise_height_text: NoiseTexture2D

var noise: Noise
var map_initialized: bool = false  # Prevent multiple initializations
var loaded_chunks: Dictionary = {}
const TERRAIN_WATER: int = 0
const TERRAIN_GRASS: int = 0
const MAP_SIZE: int = 100  # Size of the map (100x100 tiles)
const TILE_SIZE: int = 16  # Size of each tile in pixels
var water_tile = 1
var grass_tile = 0
var map_gen = false


func _ready() -> void:
	noise = noise_height_text.noise
	gen_map()

func gen_map() -> void:
	if map_gen == true:
		return  # Exit if the map has already been generated
	
	map_gen = true  # Mark the map as generated

	var water_tiles: Array[Vector2i] = []
	var grass_tiles: Array[Vector2i] = []

	for x in range(MAP_SIZE):
		for y in range(MAP_SIZE):
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
