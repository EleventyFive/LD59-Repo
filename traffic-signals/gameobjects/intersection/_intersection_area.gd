extends Area2D
class_name IntersectionArea

@onready var timer: Timer = $Timer

var light_time : int = 5
@export var go := false
func _ready() -> void:
	timer.start(light_time)

func _on_timer_timeout() -> void:
	go = !go
