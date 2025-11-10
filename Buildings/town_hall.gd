extends Building


func _build():
	super._build()
	CityResources.max_houses = 1

func _next_day():
	if is_built:
		CityResources.money += 5 #TODO: *workers
