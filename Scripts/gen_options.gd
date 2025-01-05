extends Control

@onready var seed_input = $gen_options/HBoxContainer/Seed
@onready var map_x_input = $gen_options/HBoxContainer2/map_x
@onready var map_y_input = $gen_options/HBoxContainer2/map_y
@onready var back_button = $gen_options/Back
@onready var play_button = $gen_options/Play
@onready var tilemap_option = $gen_options/HBoxContainer4/TileMapOption

func _ready():
	$gen_options/Back.pressed.connect(self._on_back_pressed)
	$gen_options/Play.pressed.connect(self._on_play_pressed)

func _on_back_pressed():
		call_deferred("change_scene", "res://Scenes/menu.tscn")
	
func _on_play_pressed():
	$".".visible = false
	var new_seed = seed_input.text.to_int()
	var map_size_x = map_x_input.text.to_int()
	var map_size_y = map_y_input.text.to_int()
	var tilemap_id = tilemap_option.selected
	var chunk_data = {"new_seed": new_seed, "map_size_x": map_size_x, "map_size_y": map_size_y, "tilemap_id": tilemap_id}

	# Load the game scene and pass chunk data
	var game_scene = load("res://Scenes/game.tscn").instantiate()
	game_scene.set_map_data(chunk_data)
 # Add the game scene instance to the scene tree
	get_tree().root.add_child(game_scene)

	# Change scene to the newly added instance
	get_tree().set_current_scene(game_scene)

func change_scene(scene_path: String) -> void:
	get_tree().change_scene_to_file(scene_path)
