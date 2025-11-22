extends Building
class_name Wall


func _on_area_2d_mouse_entered() -> void:
	health_bar.show()

func _on_area_2d_mouse_exited() -> void:
	health_bar.hide()
