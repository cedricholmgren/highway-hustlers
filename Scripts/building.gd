extends Area2D

class_name Building
@export var building_name: String = "Building"
@export var building_texture: Texture
var load: Load = null

func _ready():
	$Sprite2D.texture = building_texture
