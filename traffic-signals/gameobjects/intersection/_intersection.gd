extends Node2D
class_name IntersectionNode


@export var lights : Dictionary[Light, Area2D]
@onready var control : IntersectionControls = $Control

func _ready() -> void:
	if not lights.keys().is_empty():
		control.set_available_lights(lights.keys())
