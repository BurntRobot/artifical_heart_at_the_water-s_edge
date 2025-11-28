extends Building
class_name House


func _rotate():
	rotated = not rotated
	sprite.flip_h = rotated

func _build():
	super._build()
	CityResources.citizens += 10
