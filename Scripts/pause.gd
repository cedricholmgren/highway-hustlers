extends Control

@onready var pause = $"."
var paused = false

# Called when the node enters the scene tree for the first time.
func _ready():
	# Assuming the root node is a Control node
	var screen_size = get_viewport().get_visible_rect().size
	var menu_size = size
	position = (screen_size - menu_size) / 2
	$VBoxContainer/main_menu.pressed.connect(self._on_mainmenu_pressed)
	$VBoxContainer/quit_game.pressed.connect(self._on_quitgame_pressed)
	
func _on_mainmenu_pressed() -> void:
	call_deferred("change_scene", "res://Scenes/menu.tscn")  

func _on_quitgame_pressed() -> void:
	print("Quit button pressed")
	get_tree().quit()

# Helper function to actually change the scene
func change_scene(scene_path: String) -> void:
	get_tree().change_scene_to_file(scene_path)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		pause_game()

func pause_game():
	if paused:
		pause.hide()
		Engine.time_scale = 1
	else:
		pause.show()
		Engine.time_scale = 0
	
	paused = !paused
