extends AudioStreamPlayer2D


func _on_mute_music_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(1, toggled_on)
