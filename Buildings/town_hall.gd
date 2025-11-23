extends Building

signal destroyed


func _next_day():
	super._next_day()
	if is_built and is_working:
		CityResources.money += 5 #TODO: *workers

func _destroy_building():
	destroyed.emit()
	super._destroy_building()
