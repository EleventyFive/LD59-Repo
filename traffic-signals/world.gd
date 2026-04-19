extends Node2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D


func _on_reset_level_pressed() -> void:
	get_tree().reload_current_scene()
