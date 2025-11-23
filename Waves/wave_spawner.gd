extends Node2D

@export var wave_scene: PackedScene


func start_wave(strength: float):
	for child in get_children():
		if child is Marker2D:
			var wave = wave_scene.instantiate()
			wave.set_damage(strength)
			wave.position = child.position
			add_child(wave)
