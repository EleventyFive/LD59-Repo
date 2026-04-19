extends AudioStreamPlayer2D
const BLIP = preload("uid://dt0nijwxh1418")
const HIT = preload("uid://c8y5o28frj5nx")
const PICKUP = preload("uid://bcvqepft8pmrt")


func _ready() -> void:
	Event.play_ui_sound.connect(play_ui_sounds)
	
func play_ui_sounds():
	play()
