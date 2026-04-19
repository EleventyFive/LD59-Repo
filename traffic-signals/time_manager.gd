extends PanelContainer

signal game_won

@onready var pass_time: Label = $VBoxContainer/Panel2/HBoxContainer/PassTime
@onready var avg_time: Label = $VBoxContainer/Panel/HBoxContainer/AvgTime
@onready var timer: Timer = $Timer

var timer_running := false

func _on_check_time(time) -> void:
	var pass_time = float(pass_time.text)
	if timer_running:
		return
	
	if time < pass_time:
		print("timer_started")
		timer_running = true
		timer.start(2)
		
		
	


func _on_timer_timeout() -> void:
	if avg_time.current_player_time < float(pass_time.text):
		game_won.emit()
