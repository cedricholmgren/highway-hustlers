extends CharacterBody2D

@export var speed: float = 100.0
@export var acceleration: float = 200.0
@export var deceleration: float = 400.0
@export var rotation_speed: float = 1.5
var current_load: Load = null  # The truck's current load
var score: int = 0            # Player’s current total reward

func _physics_process(delta: float) -> void:
	var is_moving = false
	var forward_direction = Vector2(cos(rotation + PI / 2), sin(rotation + PI / 2))
	if Input.is_action_pressed("ui_up"):
		velocity = velocity.move_toward(-forward_direction * speed, acceleration * delta)
		is_moving = true
	elif Input.is_action_pressed("ui_down"):
		velocity = velocity.move_toward(forward_direction * speed, acceleration * delta)
		is_moving = true
	else: velocity = velocity.move_toward(Vector2.ZERO, deceleration * delta)
	
	if is_moving:
		if Input.is_action_pressed("ui_left"):
			rotation -= rotation_speed * delta
		elif Input.is_action_pressed("ui_right"):
			rotation += rotation_speed * delta
		
	move_and_slide()
	if Input.is_action_just_pressed("ui_down"): # or "ui_accept", or a custom action for "pickup"
		_pickup_or_dropoff()

func _pickup_or_dropoff() -> void:
   # 1) If the truck *has* a load, check if we can drop it off
	if current_load != null:
		_try_dropoff()
		return
   # 2) Otherwise, check if we can pick up from a building
	for building in _get_close_buildings():
		if building.load != null:
			# Pick up the building's load
			current_load = building.load
			building.load = null
			print("Picked up load that needs to go to:", current_load.dropoff)
			break
func _try_dropoff() -> void:
   # We have a load; see if we’re on the building that’s the correct dropoff
	for building in _get_close_buildings():
		if building.building_name == current_load.dropoff:
			# Drop off and update score
			score += current_load.reward
			print("Dropped off load. Earned:", current_load.reward, " Score is:", score)
			current_load = null
			break
func _get_close_buildings() -> Array:
   # Return a list of buildings near the truck.
	var buildings_node = get_tree().get_current_scene().get_node("Map/Buildings")
	if buildings_node == null:
		return []
	var close_buildings: Array = []
	for child in buildings_node.get_children():
		if child is Building:
			if global_position.distance_to(child.global_position) < 32:
				close_buildings.append(child)
	return close_buildings
