extends CharacterBody2D
class_name Truck

@export var speed: float = 100.0
@export var acceleration: float = 200.0
@export var deceleration: float = 400.0
@export var rotation_speed: float = 1.5

var assigned_load: Node = null
var current_building_in_range: Node = null  # Will be set when building signals truck_arrived.

func _input(event):
	if event.is_pressed():
		var index = -1
		if Input.is_action_just_pressed("one_key"):
			index = 0
		elif Input.is_action_just_pressed("two_key"):
			index = 1
		elif Input.is_action_just_pressed("three_key"):
			index = 2
		# Add more if needed for more loads

		if index >= 0:
			attempt_pickup_load(index)

func attempt_pickup_load(index):
	if assigned_load != null:
		print("Truck is already carrying a load!")
		return

	var building = current_building_in_range
	if building:
		var picked_load = building.attempt_pickup_load_at_index(index, self)
		if picked_load:
			assigned_load = picked_load
			print("Successfully picked up load:", assigned_load.name)
		else:
			print("No valid load at that index or no load available.")
	else:
		print("No building in range to pick up a load from.")

func _on_building_truck_arrived(truck, building):
	if truck == self:
		current_building_in_range = building

func _on_building_truck_departed(truck, building):
	if truck == self and current_building_in_range == building:
		current_building_in_range = null

func _physics_process(delta):
	var is_moving = false
	var forward_direction = Vector2(cos(rotation + PI / 2), sin(rotation + PI / 2))

	if Input.is_action_pressed("ui_up"):
		velocity = velocity.move_toward(-forward_direction * speed, acceleration * delta)
		is_moving = true
	elif Input.is_action_pressed("ui_down"):
		velocity = velocity.move_toward(forward_direction * speed, acceleration * delta)
		is_moving = true
	else:
		velocity = velocity.move_toward(Vector2.ZERO, deceleration * delta)

	if is_moving:
		if Input.is_action_pressed("ui_left"):
			rotation -= rotation_speed * delta
		elif Input.is_action_pressed("ui_right"):
			rotation += rotation_speed * delta

	move_and_slide()
