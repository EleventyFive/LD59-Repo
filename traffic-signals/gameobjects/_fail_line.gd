extends Area2D

var cars: Array[Vehicle]
@onready var timer: Timer = $Timer

func _on_area_entered(area: Area2D) -> void:
	if area is VehicleArea:
		var vehicle = area.get_parent()
		cars.append(vehicle)

func _on_area_exited(area: Area2D) -> void:
	if area is VehicleArea:
		var vehicle = area.get_parent()
		if cars.has(vehicle):
			cars.erase(vehicle)


func _on_timer_timeout() -> void:
	if cars.is_empty():
		return
		
	for car in cars:
		if car.move_speed < 3:
			timer.stop()
			Event.level_failed.emit()
			break
