extends Building
class_name Pomp

func _next_day():
	if not area_2d.input_pickable and is_built:
		area_2d.input_pickable = true
	if is_built:
		CityResources.water += water_in_day
		water_label.text = "Water per day: +" + str(water_in_day)
