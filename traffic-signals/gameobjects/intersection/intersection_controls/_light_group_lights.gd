extends VBoxContainer
const light_label = preload("uid://c8ti3tgv5m4em")

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return data is LightLabel

#data is the original label
func _drop_data(at_position: Vector2, data: Variant) -> void:
	Event.play_ui_sound.emit()
	
	var new_label : LightLabel = light_label.instantiate()
	new_label.text = data.text
	new_label.light_data = data.light_data
	var index = get_container_index()
	add_child(new_label)
	move_child(new_label, index)
	data.queue_free()
	
#so I can index the items in order
func get_container_index() -> int:
	var items = get_child_count()
	var height = size.y
	var mouse_height = get_local_mouse_position().y
	var index_position = mouse_height/height
	var new_index = roundi(index_position * items)
	return new_index

func get_lights():
	
	var labels = get_children()
	if labels.is_empty():
		return
	
	var lights : Array[Light]
	for label in labels:
		lights.append(label.light_data)
	
	return lights
		
func has_lights():
	return get_child_count()
	
		
	
