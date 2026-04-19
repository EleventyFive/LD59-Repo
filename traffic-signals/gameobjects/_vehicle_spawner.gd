extends Node2D

const vehicle_scene = preload("uid://bet3n02dpqqbq")

@export var spawn_interval : int = 5
@export var spawn_paths : Array[Path2D]
@export var spawn_immediately := true

@onready var timer: Timer = $Timer



var path_index : int = 0
var path_count : int

func _ready() -> void:
	path_count = spawn_paths.size()
	timer.start(spawn_interval)
	
	if spawn_immediately:
		spawn_vehicle()
	
	
	
func spawn_vehicle() -> void:
	var new_car : Vehicle = vehicle_scene.instantiate()
	var car_path : Path2D = spawn_paths[path_index]
	
	add_child(new_car)
	new_car.path.curve = car_path.curve
	new_car.rotation = new_car.path_follow.rotation
	new_car.offset = car_path.global_position
	new_car.sprite.frame = randi_range(0, 4)
	
	#new_car.path.curve = car_path.curve
	
	path_index += 1
	if path_index >= path_count:
		path_index = 0
	


func _on_timer_timeout() -> void:
	spawn_vehicle()
