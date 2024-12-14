extends Node2D

func _ready() -> void:
	print("Game starting...")
	# Load the main menu scene when the game starts
	load_menu()

# Function to load the main menu
func load_menu() -> void:
	call_deferred("change_scene", "res://Scenes/Menu.tscn")  

# Helper function to actually change the scene
func change_scene(scene_path: String) -> void:
	get_tree().change_scene_to_file(scene_path)
	
