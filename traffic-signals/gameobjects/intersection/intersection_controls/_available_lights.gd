extends GridContainer
const light_label = preload("uid://c8ti3tgv5m4em")

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return data is LightLabel

#data is the original label
#no indexing
func _drop_data(at_position: Vector2, data: Variant) -> void:
	
	var new_label : LightLabel = light_label.instantiate()
	new_label.text = data.text
	new_label.light_data = data.light_data
	add_child(new_label)
	data.queue_free()

func reset_lights(lights : Array):
	if not lights.is_empty():
		for light in lights:
			var new_label = light_label.instantiate()
			new_label.text = light.light_name
			new_label.light_data = light
			add_child(new_label)

			
