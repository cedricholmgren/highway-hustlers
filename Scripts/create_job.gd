extends Node
class_name create_job

func create_job() -> void:
	var buildings_parent = get_node("/root/Game/Buildings")
	var buildings_list: Array[Building] = []

	for child in buildings_parent.get_children():
		if child is Building:
			buildings_list.append(child as Building)
			
	if buildings_list.size() < 2:
		return 
	# 3) Random building selection
	
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	# 4) Find a building that doesn't currently have a load
	var valid_origins = []
	for b in buildings_list:
		if b.load == null:  # only buildings with no load
			valid_origins.append(b)
	if valid_origins.size() == 0:
		# no empty building to place a load
		return
	var origin_building = valid_origins[rng.randi_range(0, valid_origins.size() - 1)]
	# 5) Pick a different building for dropoff
	var dropoff_building = origin_building
	while dropoff_building == origin_building:
		dropoff_building = buildings_list[rng.randi_range(0, buildings_list.size() - 1)]
	# 6) Create the load
	var new_load = Load.new()
	new_load.dropoff = dropoff_building.building_name
	new_load.reward = rng.randi_range(50, 500)
	# 7) Assign to origin building’s single load slot
	origin_building.load = new_load
	print("Pickup load at ", origin_building, ". Dropoff load at ", new_load.dropoff)
