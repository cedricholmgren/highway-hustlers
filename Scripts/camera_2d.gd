extends Camera2D

@export var zoom_step: float = 0.1
@export var min_zoom: float = 0.3  # Minimum zoom level
@export var max_zoom: float = 4.0  # Maximum zoom level

func _input(event: InputEvent):
	if event is InputEventKey and event.pressed and event.keycode == KEY_P:
		print("Current Position: ", global_position)
		
	if event is InputEventMouseButton:
		if event.button_index == 4 and event.pressed:  # Wheel up
			zoom -= Vector2(zoom_step, zoom_step)
			zoom = Vector2(clamp(zoom.x, min_zoom, max_zoom), clamp(zoom.y, min_zoom, max_zoom))
			#debug_zoom()
		elif event.button_index == 5 and event.pressed:  # Wheel down
			zoom += Vector2(zoom_step, zoom_step)
			zoom = Vector2(clamp(zoom.x, min_zoom, max_zoom), clamp(zoom.y, min_zoom, max_zoom))
