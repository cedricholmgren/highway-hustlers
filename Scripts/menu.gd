extends Control


func _ready() -> void:
	$Main_menu/Play.pressed.connect(self._on_play_pressed)
	$Main_menu/Options.pressed.connect(self._on_options_pressed)
	$Main_menu/Quit.pressed.connect(self._on_quit_pressed)
	$Options/Back.pressed.connect(self._on_opback_pressed)

func _on_play_pressed():
	print("play pressed")
	call_deferred("change_scene", "res://Scenes/gen_options.tscn")  

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
