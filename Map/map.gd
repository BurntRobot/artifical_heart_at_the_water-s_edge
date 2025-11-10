extends Node2D

@export var buildings_scenes: Array[PackedScene]


func _on_test_build_pressed() -> void:
	var church = buildings_scenes[0].instantiate()
	add_child(church)
