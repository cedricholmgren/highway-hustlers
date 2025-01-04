extends CharacterBody2D

class_name Truck2  # This makes the Building type globally available


@export var speed: float = 100.0
@export var acceleration: float = 200.0
@export var deceleration: float = 400.0
@export var rotation_speed: float = 1.5

var current_load: Load = null  # The load this truck is carrying
var score: int = 0

func _physics_process(delta):
	
	var is_moving = false
	
	var forward_direction = Vector2(cos(rotation), sin(rotation))
	
	if Input.is_action_pressed("forward_left"):
		velocity = velocity.move_toward(-forward_direction * speed, acceleration * delta)
		is_moving = true
	elif Input.is_action_pressed("backward_left"):
		velocity = velocity.move_toward(forward_direction * speed, acceleration * delta)
		is_moving = true
	else: velocity = velocity.move_toward(Vector2.ZERO, deceleration * delta)
	
	if is_moving:
		if Input.is_action_pressed("left_left"):
			rotation -= rotation_speed * delta
		elif Input.is_action_pressed("left_left"):
			rotation += rotation_speed * delta
		
	move_and_slide()
	
	if Input.is_action_just_pressed("select_1"):
		print("1")
		_check_buildings_for_pickup(0)
	elif Input.is_action_just_pressed("select_2"):
		print("2")
		_check_buildings_for_pickup(1)
	elif Input.is_action_just_pressed("select_3"):
		print("3")
		_check_buildings_for_pickup(2)
	
func _check_buildings_for_pickup(load_index: int) -> void:
	if current_load:
		_check_buildings_for_dropoff()
		return
		
	for building in get_buildings():
		if building is Building:
			if global_position.distance_to(building.global_position) < 32:
				print(building)
				_try_pickup_load(building, load_index)
				break
					
func _check_buildings_for_dropoff() -> void:
	if current_load == null:
		return
		
	for building in get_buildings():
		if building is Building:
			if global_position.distance_to(building.global_position) < 32:
				if building.building_name == current_load.dropoff:
					_dropoff_load()
				break

			
func _try_pickup_load(building: Building, load_index: int) -> void:
	if current_load != null:
		return
	
	if load_index >= 0 and load_index < building.loads.size():
		var chosen_load = building.loads[load_index]
		if chosen_load != null:
			building.loads.remove_at(load_index)
			current_load = chosen_load
			
func _dropoff_load() -> void:
	score += current_load.reward
	print("Dropped off load ", current_load, " for ", current_load.reward, " points")
	current_load = null
	
func get_buildings() -> Array:
	var parent_node = get_parent()
	if parent_node.has_node("Buildings"):
		return parent_node.get_node("Buildings").get_children()
	return []
	
	
