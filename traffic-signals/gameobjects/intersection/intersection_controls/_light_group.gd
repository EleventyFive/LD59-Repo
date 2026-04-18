extends VBoxContainer
class_name  LightGroup

signal lights_red

@onready var spin_box: SpinBox = $HBoxContainer/SpinBox
@onready var light_container: VBoxContainer = $HBoxContainer/PanelContainer/Lights
@onready var timer: Timer = $Timer
var on_time : int = 0
var available_lights : GridContainer


func start_timer():
	if on_time != 0:
		timer.start(on_time)
		var light_labels = available_lights.get_children()
		if not light_labels.is_empty():
			for label in light_labels: 
				var light = label.light_data
				light.change_light("green")
	else:
		lights_red.emit(self)


func _on_delete_button_pressed() -> void:
	available_lights.reset_lights(light_container.get_children())
	queue_free()


func _on_spin_box_value_changed(value: float) -> void:
	on_time = int(value)
	

func _on_timer_timeout() -> void:
	var light_labels = available_lights.get_children()
	if not light_labels.is_empty():
		for label in light_labels: 
			var light = label.light_data
			light.change_light("yellow")
		
		await get_tree().create_timer(2).timeout
		var yellow_labels = available_lights.get_children()
		if not yellow_labels.is_empty():
			for label in yellow_labels: 
				var light = label.light_data
				light.change_light("yellow")
		
		lights_red.emit(self)
	
