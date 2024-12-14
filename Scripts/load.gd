extends Node2D

# References to the pickup and drop-off buildings
var pickup: Node = null
var dropoff: Node = null
var carrying_truck: Node = null
var picked_up: bool = false

signal load_picked_up(load, truck)
signal load_delivered(load, truck)

func _ready():
	# Connect to the buildings' signals
	pickup.connect("truck_arrived", Callable(self, "_on_pickup"))
	dropoff.connect("truck_arrived", Callable(self, "_on_dropoff"))

func _on_pickup(truck, building):
	if picked_up:
		print("This load has already been picked up")
		return
	if building == pickup:
		# Reference JobBoard (either autoload or from the scene tree)
		carrying_truck = truck
		picked_up = true
		emit_signal("load_picked_up", self, truck)  # Notify JobBoard

func _on_dropoff(truck, building):
	if not picked_up:
		print("This load has not been picked up")
		return
	if building == dropoff and carrying_truck == truck:
		# Reference JobBoard (either autoload or from the scene tree)
		emit_signal("load_delivered", self, truck)  # Notify JobBoard
		carrying_truck = null
		picked_up = false
