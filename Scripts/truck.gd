extends CharacterBody2D

class_name Truck  # This makes the Building type globally available


@export var speed: float = 100.0
@export var acceleration: float = 200.0
@export var deceleration: float = 400.0
@export var rotation_speed: float = 1.5

var assigned_load: Node = null  # The load this truck is carrying

func _physics_process(delta):
	
	var is_moving = false
	
	var forward_direction = Vector2(cos(rotation), sin(rotation))
	
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
