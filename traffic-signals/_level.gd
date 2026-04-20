extends Node2D
class_name	Level

@export var pass_time : float = 4
@export var level_id : int = 0
@onready var pass_time_label: Label = $CanvasLayer/Control/PanelContainer2/Timers/VBoxContainer/Panel2/HBoxContainer/PassTime
@onready var wintab: PanelContainer = $CanvasLayer/Control/PanelContainer3

func _ready() -> void:
	pass_time_label.text = "%0.2f" % pass_time
	Event.level_failed.connect(_level_failed)

func pause() -> void:
	get_tree().paused = true
	
func reset_level() -> void:
	get_tree().paused = false
	Event.load_level.emit(level_id)
	queue_free()


func _on_pause_toggled(toggled_on: bool) -> void:
	Event.play_ui_sound.emit()
	if toggled_on:
		get_tree().paused = true
	else:
		get_tree().paused = false


func _on_game_won() -> void:
	wintab.show()
	

func _level_failed():
	get_tree().paused = false
	Event.load_level.emit(level_id)
	queue_free()
	
func next_level():
	get_tree().paused = false
	Event.next_level.emit(level_id)
	queue_free()

func _on_mute_music_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(1, toggled_on)
