extends Control
class_name IntersectionControls
const light_group = preload("uid://blenttcf84m6l")
const light_label = preload("uid://c8ti3tgv5m4em")

@export var lights : Dictionary[Light, Area2D]
@onready var light_group_container: VBoxContainer = $FoldableContainer/VBoxContainer/LightGroupContainer
@onready var available_lights: GridContainer = $FoldableContainer/VBoxContainer/PanelContainer/AvailableLights


var light_groups : Array
var light_index = 0

func _ready() -> void:
	_set_available_lights()
	_on_add_light_group_pressed()
	start_light_cycle()


func start_light_cycle():
	var next_light_group = light_group_container.get_child(0)
	if next_light_group != null:
		next_light_group.start_timer()
	else:
		light_index = 0
		await get_tree().create_timer(1).timeout
		start_light_cycle()

func next_light(light_group : LightGroup):
	light_index = light_group.get_index()
	var next_index = light_index + 1
	
	var next_light_group = light_group_container.get_child(next_index)
	if next_light_group != null:
		next_light_group.start_timer()
	else:
		light_index = 0
		await get_tree().create_timer(1).timeout
		start_light_cycle()
	
	
	
	
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
	light_group_container.add_child(new_group)
