extends Label


func _physics_process(_delta: float) -> void:
	text = "Money: " + str(CityResources.money)
