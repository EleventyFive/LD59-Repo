extends Label


signal check_time

var wait_times : Array[float]
var total_wait_times : Array[float]
var can_start_averaging = false

var current_wait_time : float
var current_total_wait_time : float

var current_player_time : float = 0


func _ready() -> void:
	Event.time_waited.connect(recieve_wait_time)
	Event.total_time_waited.connect(recieve_total_wait_time)

func recieve_wait_time(time : float): #cars that are still waiting
	wait_times.append(time)

	if wait_times.size() > 50:
		wait_times.pop_front()
		
	if wait_times.size() > 5:
		current_wait_time = average_wait_time(wait_times)
		average_and_display()
		

func recieve_total_wait_time(time : float):
	total_wait_times.append(time)
	
	if total_wait_times.size() > 20: #cars that have left
		total_wait_times.pop_front()
	
	if total_wait_times.size() > 5:
		current_total_wait_time = average_wait_time(total_wait_times)
		average_and_display()
		
		
		
func average_wait_time(times : Array) -> float:
	var sum : float = 0
	for time in times:
		sum += time
	var average_time = sum/times.size()
	#var time = "%0.2f" % average_time
	return average_time

func average_and_display():
	if current_wait_time > 0 and current_total_wait_time > 0:
		current_player_time = (current_wait_time + current_total_wait_time) / 2
		text = "%0.2f" % current_player_time
		check_time.emit(current_player_time)
		
	
