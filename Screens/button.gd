extends Button


func _on_pressed() -> void:
	CityResources.restart_game()
	get_tree().change_scene_to_file("res://World.tscn")
