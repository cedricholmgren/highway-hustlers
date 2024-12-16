extends Area2D

signal truck_arrived(truck, building)
signal truck_departed(truck, building)

var available_loads: Array = []
var truck_in_range: Truck = null

func add_load(load):
	available_loads.append(load)

func remove_load(load):
	available_loads.erase(load)

func _on_building_body_entered(area):
	print(area)
	if area is Truck:
		truck_in_range = area
		emit_signal("truck_arrived", area, self)

func _on_building_body_exited(area):
	if area is Truck and truck_in_range == area:
		truck_in_range = null
		emit_signal("truck_departed", area, self)

# This method will be called by the truck when the player presses a number key.
func attempt_pickup_load_at_index(index: int, truck: Truck) -> Node:
	if index < 0 or index >= available_loads.size():
		return null
	var load = available_loads[index]
	if load and not load.picked_up:
		load.carrying_truck = truck
		load.picked_up = true
		load.emit_signal("load_picked_up", load, truck)
		remove_load(load)
		return load  # Return the load node
	return null
