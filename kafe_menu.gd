extends Control

signal _on_walls_reinforced


func _on_button_4_pressed() -> void:
	hide()

func _on_button_3_pressed() -> void:
	print("Начато свидание с Инженером")
	_on_walls_reinforced.emit()
