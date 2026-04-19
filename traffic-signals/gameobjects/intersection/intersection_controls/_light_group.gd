extends VBoxContainer
class_name  LightGroup

signal lights_red
signal light_group_deleted

@onready var spin_box: SpinBox = $HBoxContainer/SpinBox
@onready var group_lights : VBoxContainer = $HBoxContainer/PanelContainer/GroupLights
@onready var timer: Timer = $Timer

var on_time : int = 0
var yellow_time : int = 2
var red_time : int = 1
var available_lights : GridContainer #injected currently

enum state {green, yellow, red}
var current_state = state.red

func has_lights() -> bool:
	return group_lights.has_lights() and on_time > 0

func start_cycle():
	if has_lights():
		turn_green()
	else:
		timer.stop()
		current_state = state.red
		lights_red.emit()

func turn_green():
	if has_lights():
		timer.start(on_time)
		var lights = group_lights.get_lights()
		for light in lights:
			light.change_light("green")
		current_state = state.green
	else:
		timer.stop()
func turn_yellow():
	if has_lights():
		timer.start(yellow_time)
		var lights = group_lights.get_lights()
		for light in lights:
			light.change_light("yellow")
		current_state = state.yellow
	else:
		timer.stop()

func turn_red():
	
	if has_lights():
		timer.start(red_time)
		var lights = group_lights.get_lights()
		for light in lights:
			light.change_light("red")
		current_state = state.red
	else:
		timer.stop()

func _on_delete_button_pressed() -> void:
	Event.play_ui_sound.emit()
	var lights = group_lights.get_lights()
	
	if lights:
		for light in lights:
			light.change_light("red")
		available_lights.reset_lights(lights)
	timer.stop()	
	light_group_deleted.emit(self)
	queue_free()


func _on_spin_box_value_changed(value: float) -> void:
	Event.play_ui_sound.emit()
	on_time = int(value)
	
func _on_timer_timeout() -> void:

	if current_state == state.green:
		turn_yellow()
		
	elif current_state == state.yellow:
		turn_red()
		
	elif current_state == state.red:
		lights_red.emit()
	
