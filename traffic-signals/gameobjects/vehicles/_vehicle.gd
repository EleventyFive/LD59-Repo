extends Node2D
class_name Vehicle


@onready var sprite: Sprite2D = $Sprite2D
@onready var path: Path2D = $Path2D
@onready var path_follow: PathFollow2D = $Path2D/PathFollow2D
@onready var cast: RayCast2D = $Cast



enum state {go, slowing, stopped}
var current_state : state = state.go

var move_speed : float = 50
var max_speed : float = 50
var acceleration = 0.1
var offset
var never_stopped := true#accounts for vehicles that never stop the whole way though in averages


var timer_running := false
var time_stamp : float = 0
var wait_time : float = 0

var frame_count : int
var max_count : int = 30
func _ready() -> void:
	pass
	
	
func _physics_process(delta: float) -> void:
	frame_count +=1

	path_follow.progress += move_speed * delta
	position = path_follow.position + offset
	#good enough for now, makes the angle wrap properly
	rotation = lerp_angle(rotation, path_follow.rotation, 0.1)
	
	if cast.is_colliding():
		var object = cast.get_collider()
		if object is VehicleArea:
			move_speed = lerpf(move_speed, 0, acceleration * 2)
			
		elif object is IntersectionArea:
			if object.go:
				move_speed = lerpf(move_speed, max_speed, acceleration)
			else:
				move_speed = lerpf(move_speed, 0, acceleration)

	else:
		move_speed = max_speed
	
	
	
	if timer_running and move_speed > 1:
		wait_time = (Time.get_ticks_msec() - time_stamp)/1000
		Event.total_time_waited.emit(wait_time)
		timer_running = false
		time_stamp = 0
		wait_time = 0
	
	elif timer_running and frame_count % 10 == 0:
		wait_time = (Time.get_ticks_msec() - time_stamp)/1000
		if wait_time > 3:
			Event.time_waited.emit(wait_time)
		
	elif move_speed < 1:
		if not timer_running:
			never_stopped = false
			time_stamp = Time.get_ticks_msec()
			timer_running = true
			



	if path_follow.progress_ratio >= 0.99:
		if never_stopped:
			Event.total_time_waited.emit(0)
		queue_free()
