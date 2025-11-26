extends ProgressBar

var activated = false
signal wave_started

func start_progress_countdown(date, current_date):
	if current_date == date:
		show()
		activated = true

func _on_day_timer_timeout() -> void:
	if activated:
		value += 1
		if value == max_value:
			hide()
			wave_started.emit()
			value = 0
			activated = false
