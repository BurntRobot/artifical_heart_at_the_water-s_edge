extends Label

func _physics_process(_delta: float) -> void:
	text = "People: " + str(CityResources.citizens) + "\nWater: " + str(CityResources.water)
