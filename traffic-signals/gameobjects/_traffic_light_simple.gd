extends Node2D
class_name Light


@onready var sprite: Sprite2D = $Sprite2D

func change_light(state : String):
	
	match state:
		"green":
			sprite.frame = 1
		"yellow":
			sprite.frame = 2
		"red":
			sprite.frame = 3
	
