extends Node2D

const LEVEL_1 = preload("uid://dp1q0dxpkto4i")
const LEVEL_2 = preload("uid://ycxaje4f2erp")
const LEVEL_3 = preload("uid://dvdk20hiusc6m")

@export var start_level : int  = 1

func _ready() -> void:
	Event.next_level.connect(go_to_next_level)
	Event.load_level.connect(load_level)
	load_level(start_level)

func go_to_next_level(level_id):
	var next_level = level_id + 1
	load_level(next_level)
	

		


func load_level(level_id):
	var level : PackedScene
	match level_id:
		1 :
			level = LEVEL_1
		2:
			level = LEVEL_2
		3:
			level = LEVEL_3

	var new_level = level.instantiate()
	add_child(new_level)
	
	
