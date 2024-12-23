extends Node2D

@onready var autogen = $autogen  # Reference to the TileMap node
# Variables to store chunk data
var water_tiles: Array = []
var grass_tiles: Array = []
var seed: int = -1
var map_size_x: int = -1
var map_size_y: int = -1


# Function to initialize map by receiving chunk data
func initialize_map(chunk_data: Dictionary) -> void:
	# Debugging the tilemap reference
	#if tilemap == null:
		#print("TileMap node (autogen) is null. Ensure the path to the node is correct.")
		#return
	#else:
		#print("TileMap node (autogen) successfully referenced:", tilemap)

	# Debugging chunk data
	#if chunk_data == null or chunk_data.is_empty():
		#print("Chunk data is null or empty! Ensure it is being passed correctly.")
		#return
	#print("Chunk data received:", chunk_data)

	# Storing chunk data variables
	water_tiles = chunk_data.get("water_tiles", [])
	grass_tiles = chunk_data.get("grass_tiles", [])
	seed = chunk_data.get("seed", -1)
	map_size_x = chunk_data.get("map_size_x", -1)
	map_size_y = chunk_data.get("map_size_y", -1)

	#print("Initialized map variables:")
	#print("  Seed:", seed)
	#print("  Map Size X:", map_size_x)
	#print("  Map Size Y:", map_size_y)
	#print("  Grass Tiles:", grass_tiles)
	#print("  Water Tiles:", water_tiles)
	build_map()

# Function to build the map using stored data
func build_map() -> void:
	#if autogen == null:
		#print("Error: Cannot build map because 'autogen' is not assigned.")
		#return

	if water_tiles.is_empty() and grass_tiles.is_empty():
		print("No map data available to build.")
		return

	var grass_tile = 0  # Replace with the actual grass tile ID
	var water_tile = 1  # Replace with the actual water tile ID

	# Set grass tiles
	for pos in grass_tiles:
		autogen.set_cells_terrain_connect(grass_tiles, 0, 1, true)

	# Set water tiles
	for pos in water_tiles:
		autogen.set_cells_terrain_connect(water_tiles, 0, 0, true)

	print("Map built successfully with grass and water tiles.")
