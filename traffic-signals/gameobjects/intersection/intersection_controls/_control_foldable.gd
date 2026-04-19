extends FoldableContainer

#var mouse_dragging = false
#
#func _gui_input(event: InputEvent) -> void:
	#
	#if event is InputEventMouseMotion:
		#if mouse_dragging == true:
			#global_position = get_global_mouse_position()
	#
	#if event is InputEventMouseButton:
		#if event.button_index == MOUSE_BUTTON_LEFT:
			#if event.pressed:
				#mouse_dragging = true
			#else:
				#mouse_dragging = false
		
