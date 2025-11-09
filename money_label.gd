extends Label


func _physics_process(delta: float) -> void:
	text = "Money: " + str(CityResources.money)
