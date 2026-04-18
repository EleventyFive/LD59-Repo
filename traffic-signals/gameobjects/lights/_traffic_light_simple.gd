extends Node2D
class_name Light


@onready var sprite: Sprite2D = $Sprite2D
@onready var timer: Timer = $Timer

var on_time : int = 0

func _ready() -> void:
	if on_time != 0:
		timer.start(on_time)

func change_light(state : String):
	
	match state:
		"green":
			sprite.frame = 1
		"yellow":
			sprite.frame = 2
		"red":
			sprite.frame = 3
		_:
			sprite.frame = 0
