extends Building


func _rotate():
	rotated = not rotated
	sprite.flip_h = rotated
