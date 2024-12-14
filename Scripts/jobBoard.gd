extends Node

signal load_created(load)

@export var load_scene: PackedScene  # Reference to the Load scene
var active_jobs: Array = []  # List of active jobs (loads)
var buildings: Array = []  # List of all building nodes

func _ready():
	var main_node = get_tree().root.get_node("Main")
	if main_node:
		var buildings_node = main_node.get_node("Buildings")
		if buildings_node:
			for child in buildings_node.get_children():
				buildings.append(child)
			print("Buildings found: ", buildings)
		else:
			print("Error: Buildings node not found under Main!")
	else:
		print("Error: Main node not found!")
	create_job()
	create_job()
	create_job()
	create_job()
	create_job()
	create_job()


func create_job():
	# Randomly select pickup and drop-off buildings
	var pickup = buildings[randi() % buildings.size()]
	var dropoff = buildings[randi() % buildings.size()]
	while dropoff == pickup:  # Ensure pickup and drop-off are different
		dropoff = buildings[randi() % buildings.size()]
	
	if load_scene == null:
		print("error load_scene not found")
		return
	# Create a new load
	var new_load = load_scene.instantiate()

	new_load.pickup = pickup
	new_load.dropoff = dropoff
	add_child(new_load)  # Add the load as a child of the JobBoard
	active_jobs.append(new_load)
	
	new_load.connect("load_picked_up", Callable(self, "on_load_picked_up"))
	new_load.connect("load_delivered", Callable(self, "on_load_delivered"))


	# Notify others that a load has been created
	emit_signal("load_created", new_load)
	print("Job created: Pickup at %s, Dropoff at %s" % [pickup.building_name, dropoff.building_name])
	
func on_load_picked_up(load, truck):
	if load.carrying_truck != truck:
		print("Load already picked up by another truck")
		return
	print("Load picked up:", load.name, "by truck:", truck.name, "at building:", load.pickup)

func on_load_delivered(load, truck):
	if load.carrying_truck != truck:
		print("This truck is not carrying this load")
		return
	print("Load delivered:", load.name, "by truck:", truck.name)
	active_jobs.erase(load)  # Remove the job from active jobs
	load.queue_free()  # Remove the load from the scene