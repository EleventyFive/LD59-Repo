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

func _ready() -> void:
	pass
	
	
func _physics_process(delta: float) -> void:
	path_follow.progress += move_speed * delta
	position = path_follow.position
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
		
	if path_follow.progress_ratio >= 0.99:
		queue_free()
