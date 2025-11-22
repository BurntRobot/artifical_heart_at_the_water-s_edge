extends Building
class_name Pomp

@onready var water_area: Area2D = $WaterArea


func _next_day():
	if not area_2d.input_pickable and is_built:
		area_2d.input_pickable = true
	if is_built:
		CityResources.water += water_in_day
		water_label.text = "Water per day: +" + str(water_in_day)

func you_cant_build():
	var main_result = super.you_cant_build()
	if not main_result:
		for _some_area in water_area.get_overlapping_areas():
			if _some_area.name == "Water":
				return false
		return true
	else:
		return true
