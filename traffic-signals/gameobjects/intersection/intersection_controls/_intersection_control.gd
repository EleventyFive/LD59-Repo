extends Control
class_name IntersectionControls
const light_group = preload("uid://blenttcf84m6l")
const light_label = preload("uid://c8ti3tgv5m4em")

@export var lights : Array[Light]
@onready var light_group_container: VBoxContainer = $PanelContainer/VBoxContainer/LightGroupContainer
@onready var available_lights: GridContainer = $PanelContainer/VBoxContainer/PanelContainer/AvailableLights
@onready var timer: Timer = $Timer


var light_groups : Array
var light_index = 0
var is_running := false

func _ready() -> void:
	_set_available_lights()
	_on_add_light_group_pressed()
	_start_light_cycle()

func _start_light_cycle():
	is_running = false
	var start_group
	if not light_groups.is_empty():
		start_group = light_groups.front()
	if start_group and start_group.has_lights():
		timer.stop()
		start_group.start_cycle()
		is_running = true
	else:
		timer.start(2)
	
		
func next_light():
	is_running = false
	light_index += 1
	var max_index = light_groups.size()
	if light_index < max_index:
		var next_group = light_groups[light_index]
		next_group.start_cycle()
		is_running = true
		
	else:
		light_index = 0
		_start_light_cycle()

func _set_available_lights() -> void:
	for light in lights:
		var new_label : LightLabel = light_label.instantiate()
		new_label.text = light.light_name
		new_label.light_data = light
		available_lights.add_child(new_label)
		
func _on_add_light_group_pressed() -> void:
	var new_group : LightGroup = light_group.instantiate()
	new_group.available_lights = available_lights
	new_group.lights_red.connect(next_light)
	new_group.light_group_deleted.connect(light_group_removed)
	light_group_container.add_child(new_group)
	light_groups.append(new_group)

func light_group_removed(deleted_group : LightGroup) -> void:
	light_groups.erase(deleted_group)
	if light_groups.is_empty():
		is_running = false
	_start_light_cycle()

func _on_timer_timeout() -> void:
	_start_light_cycle()
