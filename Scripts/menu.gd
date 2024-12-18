extends Control

var seed_value: int = 0
var set_map_x: int = 100
var set_map_y: int = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Main_menu/Play.pressed.connect(self._on_play_pressed)
	$Main_menu/Options.pressed.connect(self._on_options_pressed)
	$Main_menu/Quit.pressed.connect(self._on_quit_pressed)
	$Options/Back.pressed.connect(self._on_opback_pressed)
	$Options/HBoxContainer/Seed.connect("text_submitted", self._on_seed_submitted)
	$Options/HBoxContainer2/map_x.connect("text_submitted", self._on_x_submitted)
	$Options/HBoxContainer2/map_y.connect("text_submitted", self._on_y_submitted)

func _on_seed_submitted(new_seed: String) -> void:
	seed_value = int(new_seed)  # Convert the string to an integer

func _on_x_submitted(new_x: String) -> void:
	set_map_x = int(new_x)

func _on_y_submitted(new_y: String) -> void:
	set_map_y = int(new_y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_play_pressed():
	print("play pressed")
	var map_scene = load("res://Scenes/map.tscn")
	var map_instance = map_scene.instantiate()
	map_instance._process_seed(seed_value)  # Send the seed to the map
	map_instance._redefine_map_x(set_map_x)
	map_instance._redefine_map_y(set_map_y)
	call_deferred("change_scene", "res://Scenes/game.tscn")  

func _on_options_pressed():
	print("options pressed")
	$Main_menu.visible = false
	$Options.visible = true
	
func _on_opback_pressed() -> void:
	$Main_menu.visible = true
	$Options.visible = false
	print("Back to main menu")
	
func _on_quit_pressed():
	get_tree().quit()

func change_scene(scene_path: String) -> void:
	get_tree().change_scene_to_file(scene_path)
