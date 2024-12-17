extends Node2D

func _ready() -> void:
	print("Game starting...")
	load_menu()

func load_menu() -> void:
	call_deferred("change_scene", "res://Scenes/menu.tscn")

func change_scene(scene_path: String) -> void:
	get_tree().change_scene_to_file(scene_path)
