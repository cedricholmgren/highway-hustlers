extends Control

@onready var seed_input = $gen_options/HBoxContainer/Seed
@onready var map_x_input = $gen_options/HBoxContainer2/map_x
@onready var map_y_input = $gen_options/HBoxContainer2/map_y
@onready var back_button = $gen_options/Back
@onready var play_button = $gen_options/Play

func _ready():
	$gen_options/Back.pressed.connect(self._on_back_pressed)
	$gen_options/Play.pressed.connect(self._on_play_pressed)

func _on_back_pressed():
	get_tree().change_scene("res://Scenes/menu.tscn")

func _on_play_pressed():
	var seed = seed_input.text.to_int()
	var map_size_x = map_x_input.text.to_int()
	var map_size_y = map_y_input.text.to_int()

	var chunk_data = generate_chunks(seed, map_size_x, map_size_y)

	# Load the game scene and pass chunk data
	var game_scene = load("res://Scenes/game.tscn").instantiate()
	game_scene.set_map_data(chunk_data)
	call_deferred("change_scene", "res://Scenes/game.tscn")

func generate_chunks(seed: int, map_size_x: int, map_size_y: int) -> Dictionary:
	var noise = FastNoiseLite.new()
	noise.seed = seed

	var water_tiles: Array[Vector2i] = []
	var grass_tiles: Array[Vector2i] = []

	for x in range(map_size_x):
		for y in range(map_size_y):
			var noise_val = noise.get_noise_2d(x, y)
			if noise_val < 0.0:
				water_tiles.append(Vector2i(x, y))
			else:
				grass_tiles.append(Vector2i(x, y))

	return {
		"water_tiles": water_tiles,
		"grass_tiles": grass_tiles,
		"seed": seed,
		"map_size_x": map_size_x,
		"map_size_y": map_size_y,
	}
	print("water_tiles:", water_tiles, " grass_tiles:", grass_tiles, " seed:", seed, " map_size_x:", map_size_x, " map_size_y:", map_size_y)

func change_scene(scene_path: String) -> void:
	get_tree().change_scene_to_file(scene_path)
