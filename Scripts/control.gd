extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Main_menu/Play.pressed.connect(self._on_play_pressed)
	$Main_menu/Options.pressed.connect(self._on_options_pressed)
	$Main_menu/Quit.pressed.connect(self._on_quit_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
