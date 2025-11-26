extends Control


func _on_button_pressed() -> void:
	get_tree().paused = true
	show()


func _on_button_2_pressed() -> void:
	get_tree().paused = false
	hide()
