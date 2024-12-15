extends Area2D

signal truck_arrived(truck, building)

func _on_building_body_entered(area):
	if area is Truck:
		truck_arrived.emit(area, self)
