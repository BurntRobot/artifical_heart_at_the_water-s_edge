extends Building


func _next_day():
	super._next_day()
	if is_built and is_working:
		CityResources.money += 10 #TODO: *workers of mine
