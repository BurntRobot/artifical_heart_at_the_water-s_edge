extends Timer

var MAX_DAY: int = 30
var MAX_MONTH: int = 12

func _on_timeout() -> void:
	_next_day()

func _next_day():
	if CityResources.day < MAX_DAY:
		CityResources.day += 1
	elif CityResources.month < MAX_MONTH:
		CityResources.day = 1
		CityResources.month += 1
	else:
		CityResources.day = 1
		CityResources.month = 1
		CityResources.year += 1
