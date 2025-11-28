extends Button

@onready var new_game = preload("res://world.tscn")


func _on_pressed() -> void:
	CityResources.restart_game()
	get_tree().change_scene_to_packed(new_game)
