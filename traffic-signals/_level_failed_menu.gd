extends PanelContainer


func _ready() -> void:
	hide()
	Event.level_failed.connect(show_menu)

func show_menu():
	show()
