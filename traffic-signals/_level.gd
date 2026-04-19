extends Node2D
class_name	Level

@export var pass_time : float = 4
@export var level_id : int = 0
@onready var pass_time_label: Label = $CanvasLayer/Control/PanelContainer2/Timers/VBoxContainer/Panel2/HBoxContainer/PassTime

func _ready() -> void:
	pass_time_label.text = "%0.2f" % pass_time

func pause() -> void:
	get_tree().paused = true
	

func _on_pause_toggled(toggled_on: bool) -> void:
	Event.play_ui_sound.emit()
	if toggled_on:
		get_tree().paused = true
	else:
		get_tree().paused = false


func _on_game_won() -> void:
	pause()
	print("winner winner PB no Jam!")
	#play next level!
