extends Control

var map_gen: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Main_menu/Play.pressed.connect(self._on_play_pressed)
	$Main_menu/Options.pressed.connect(self._on_options_pressed)
	$Main_menu/Quit.pressed.connect(self._on_quit_pressed)

func _is_map_gen(map_generated):
	map_gen = map_generated
	print(map_gen)

func _on_play_pressed():
	print("Play pressed")
	call_deferred("change_scene", "res://Scenes/game.tscn")  


func _on_options_pressed():
	print("options pressed")

func _on_quit_pressed():
	get_tree().quit()


func change_scene(scene_path: String) -> void:
	get_tree().change_scene_to_file(scene_path)
