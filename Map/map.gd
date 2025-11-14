extends Node2D

@export var buildings_scenes: Array[PackedScene]

@onready var buildings_map: TileMapLayer = $BuildingsMap
@onready var base_map: TileMapLayer = $BaseMap

signal _on_kafe_click
signal town_hall_built
signal kafe_built


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func is_tiles_are_free_ground(tiles: Array[Vector2i]):
	for child in get_children():
		if child is Building and not child.is_built:
			var _red_tiles: Array[Vector2i] = []
			var base_for_tile = Vector2i(
				int(child.position.x / 30),
				int(child.position.y / 18))
			for _tile in tiles:
				if is_tile_a_ground(_tile + base_for_tile):
					_red_tiles.append(_tile)
			child.set_red_places(_red_tiles)

func is_tiles_are_free_water(tiles):
	pass

func is_tile_a_ground(_tile: Vector2i):
	return _tile in get_ground_tiles()
func get_ground_tiles():
	return base_map.get_used_cells_by_id(0, Vector2i(0, 0))

func is_tile_a_water():
	pass
func get_water_tiles():
	return base_map.get_used_cells_by_id(0, Vector2i(1, 0))

func is_tile_builded():
	pass
func get_builded_tiles():
	return buildings_map.get_used_cells_by_id(0, Vector2i(2, 0))


func _on_test_build_pressed() -> void:
	var town_hall = buildings_scenes[0].instantiate()
	town_hall._on_check_free_ground.connect(is_tiles_are_free_ground)
	town_hall.built.connect(town_hall_built.emit)
	add_child(town_hall)
	

func _on_test_build_2_pressed() -> void:
	var kafe = buildings_scenes[1].instantiate()
	kafe._on_check_free_ground.connect(is_tiles_are_free_ground)
	kafe._on_click.connect(_kafe_is_clicked)
	kafe.built.connect(kafe_built.emit)
	add_child(kafe)

func _kafe_is_clicked():
	_on_kafe_click.emit()

func reinforce_walls():
	for child in get_children():
		if child is Wall and child.is_built:
			child.health += 50
			child.current_health += 50

func walls_take_damage():
	for child in get_children():
		if child is Wall and child.is_built:
			child.current_health -= 100

func _on_test_build_3_pressed() -> void:
	walls_take_damage()

func deactivate_kafe():
	for child in get_children():
		if child is Kafe and child.is_built:
			child.deactivate_for_a_month()
