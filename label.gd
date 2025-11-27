extends Label


func _on_test_build_mouse_entered() -> void:
	get_parent().show()
	text = "Townhall\nCost: 500 money.\nDescription:\nMain building for your settlement."
func _on_test_build_mouse_exited() -> void:
	get_parent().hide()


func _on_test_build_2_mouse_entered() -> void:
	get_parent().show()
	text = "Kafe\nCost: 300 money.\nDescription:\nBuilding for getting upgrades to other buildings."
func _on_test_build_2_mouse_exited() -> void:
	get_parent().hide()


func _on_test_build_4_mouse_entered() -> void:
	get_parent().show()
	text = "Wall\nCost: 20 money.\nDescription:\nBuild it to defend from waves."
func _on_test_build_4_mouse_exited() -> void:
	get_parent().hide()


func _on_test_build_5_mouse_entered() -> void:
	get_parent().show()
	text = "House\nCost: 100 money.\nDescription:\nBuilding with citizens."
func _on_test_build_5_mouse_exited() -> void:
	get_parent().hide()


func _on_test_build_6_mouse_entered() -> void:
	get_parent().show()
	text = "Repair station\nCost: 200 money.\nDescription:\nBuilding that repair other buildings in area."
func _on_test_build_6_mouse_exited() -> void:
	get_parent().hide()


func _on_test_build_7_mouse_entered() -> void:
	get_parent().show()
	text = "Pomp\nCost: 300 money.\nDescription:\nBuilding, that produce water for other buildings."
func _on_test_build_7_mouse_exited() -> void:
	get_parent().hide()


func _on_test_build_8_mouse_entered() -> void:
	get_parent().show()
	text = "Mine\nCost: 200 money.\nDescription:\nBuilding that produce money."
func _on_test_build_8_mouse_exited() -> void:
	get_parent().hide()
