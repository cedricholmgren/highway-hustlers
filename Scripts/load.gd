extends Node2D

var pickup: Node = null
var dropoff: Node = null
var carrying_truck: Node = null
var picked_up: bool = false

signal load_picked_up(load, truck)
signal load_delivered(load, truck)

func _ready():
	# Only connect dropoff signal
	dropoff.connect("truck_arrived", Callable(self, "_on_dropoff"))

func _on_dropoff(truck, building):
	if not picked_up:
		return
	if building == dropoff and carrying_truck == truck:
		emit_signal("load_delivered", self, truck)
		carrying_truck = null
		picked_up = false
