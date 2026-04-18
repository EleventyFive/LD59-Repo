extends Node2D
class_name Light

@export_enum("green", "yellow", "red") var start_state : String = "red"
@export var area : Area2D

@onready var sprite: Sprite2D = $Sprite2D


func _ready() -> void:
	change_light(start_state)
	

func change_light(state : String):
	
	match state:
		"green":
			sprite.frame = 1
			area.go = true
		"yellow":
			sprite.frame = 2
			area.go = false
		"red":
			sprite.frame = 3
			area.go = false
		_:
			sprite.frame = 0
			area.go = false
