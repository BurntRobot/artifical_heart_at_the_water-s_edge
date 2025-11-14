extends Node

@onready var kafe_menu: Control = $GUI/KafeMenu
@onready var map: Node2D = $Game/Map


func _on_map__on_kafe_click() -> void:
	kafe_menu.show()

func _on_kafe_menu__on_walls_reinforced() -> void:
	map.reinforce_walls()

func _on_kafe_menu__on_choise() -> void:
	map.deactivate_kafe()


func _on_map_kafe_built() -> void:
	$GUI/VBoxContainer/test_build2.hide()

func _on_map_town_hall_built() -> void:
	$GUI/VBoxContainer/test_build.hide()
