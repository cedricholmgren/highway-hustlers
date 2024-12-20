extends Node

@onready var map_node = $Map  # Reference to the `Map` node


# Receive the chunk data and initialize the map
func set_map_data(chunk_data: Dictionary) -> void:
	#print("Chunk data received:", chunk_data)
	
	if map_node == null:
		map_node = get_node("Map")  # Try to retrieve the node dynamically
		if map_node == null:
			print("Map node is still null! Ensure the node exists in the scene tree.")
			return
	
	if map_node.has_method("initialize_map"):
		map_node.initialize_map(chunk_data)
	else:
		print("Map node does not have 'initialize_map' method!")
