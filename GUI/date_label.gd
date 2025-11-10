extends Label


func _physics_process(_delta: float) -> void:
	text = str(CityResources.day) + "d." + str(CityResources.month) + "m." + str(CityResources.year) + "y"
