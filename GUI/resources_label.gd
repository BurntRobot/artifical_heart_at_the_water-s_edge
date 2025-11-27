extends Label

func _physics_process(_delta: float) -> void:
	text = "Citizens: " + str(CityResources.citizens) + " | Water: " + str(CityResources.water)
