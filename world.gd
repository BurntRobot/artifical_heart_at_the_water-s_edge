extends Node

@onready var kafe_menu: CenterContainer = $GUI/KafeMenu


func _on_map__on_kafe_click() -> void:
	kafe_menu.show()
