extends Control
class_name IntersectionControls
const light_group = preload("uid://blenttcf84m6l")
const light_label = preload("uid://c8ti3tgv5m4em")

@export var lights : Dictionary[Light, Area2D]
@onready var light_group_list: VBoxContainer = $FoldableContainer/VBoxContainer/LightGroupContainer
@onready var available_lights: GridContainer = $FoldableContainer/VBoxContainer/PanelContainer/AvailableLights
@onready var timer: Timer = $Timer


var light_groups : Array
var light_index = 0

func _ready() -> void:
	_set_available_lights()
	_on_add_light_group_pressed()
	_start_light_cycle()

func _start_light_cycle():
	var start_group = light_group_list.get_child(0)
	if start_group and start_group.has_lights():
		timer.stop()
		start_group.start_cycle()
	else:
		timer.start(2)
		
func next_light():
	light_index += 1
	var max_index = light_group_list.get_child_count()
	if light_index < max_index:
		var next_group = light_group_list.get_child(light_index)
		next_group.start_cycle()
		
	else:
		light_index = 0
		_start_light_cycle()


		
	
	
	
	
	
func _set_available_lights() -> void:
	for light in lights:
		var new_label : LightLabel = light_label.instantiate()
		new_label.text = light.name
		new_label.light_data = light
		available_lights.add_child(new_label)
		
func _on_add_light_group_pressed() -> void:
	var new_group : LightGroup = light_group.instantiate()
	new_group.available_lights = available_lights
	new_group.lights_red.connect(next_light)
	light_group_list.add_child(new_group)


func _on_timer_timeout() -> void:
	_start_light_cycle()
