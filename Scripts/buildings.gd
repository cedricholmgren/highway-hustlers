extends Node2D

# Array to store already placed building positions
var placed_positions = []
const MIN_DISTANCE_TILES = 10  # Minimum distance between buildings

# Process grass tile list and place buildings
func process_tiles(grass_tile_list: Array):
	# Loop through all buildings in this scene
	for building in get_children():
		var valid_position_found = false
		var attempts = 0
		
		while not valid_position_found and attempts < 1000:
			var random_index = randi() % grass_tile_list.size()
			var random_position = grass_tile_list[random_index]
			
			# Check if the position is far enough from previously placed buildings
			if is_far_enough(random_position):
				# Set building position (assuming tile size = 64 pixels)
				building.position = random_position * 16
				placed_positions.append(random_position)
				valid_position_found = true
			else:
				attempts += 1
		
		if not valid_position_found:
			print("Could not place building:", building.name)

# Check if a position is far enough from existing buildings
func is_far_enough(position: Vector2) -> bool:
	for placed_position in placed_positions:
		if placed_position.distance_to(position) < MIN_DISTANCE_TILES:
			return false
	return true
