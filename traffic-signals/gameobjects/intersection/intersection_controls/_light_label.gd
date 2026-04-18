extends Label
class_name  LightLabel

var light_data : Light
var old_data : LightLabel

func _get_drag_data(at_position: Vector2) -> Variant:
	
	var drag_preview : LightLabel = self.duplicate()
	drag_preview.modulate.a = 0.8
	drag_preview.scale.x = 0.6
	drag_preview.scale.y = 0.6
	set_drag_preview(drag_preview)
	
	return self

	
	
