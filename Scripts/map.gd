extends Node2D

@onready var tilemap = $autogen  # Reference to the TileMap node

# Initialize the map using the chunk data
func initialize_map(chunk_data: Dictionary) -> void:
	if tilemap == null:
		print("TileMapLayer node is null. Ensure the path to the node is correct.")
		return
	
	var water_tiles = chunk_data["water_tiles"]
	var grass_tiles = chunk_data["grass_tiles"]

	# Assuming grass_tile and water_tile are the terrain types in your tileset
	var grass_tile = 0  # Replace with the correct terrain index for grass
	var water_tile = 1  # Replace with the correct terrain index for water

	# Set terrain-connected cells for grass and water
	tilemap.set_cells_terrain_connect(grass_tiles, 0, grass_tile, false)
	tilemap.set_cells_terrain_connect(water_tiles, 0, water_tile, false)

	print("Map initialized with grass and water tiles.")
	print("Grass tiles:", grass_tiles)
	print("Water tiles:", water_tiles)
	print("Grass terrain ID:", grass_tile)
	print("Water terrain ID:", water_tile)
