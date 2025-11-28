extends Control

signal _on_walls_reinforced
signal _reinforce_townhall
signal _reinforce_houses
signal _on_choise


func _on_button_4_pressed() -> void:
	hide()

func _on_button_3_pressed() -> void:
	print("Date with Engeneer started!")
	_on_walls_reinforced.emit()
	_on_choise.emit()
	hide()

func _on_button_2_pressed() -> void:
	print("Date with The Main Worker started!")
	_reinforce_houses.emit()
	_on_choise.emit()
	hide()

func _on_button_pressed() -> void:
	print("Date with Conselour started!")
	_reinforce_townhall.emit()
	_on_choise.emit()
	hide()
