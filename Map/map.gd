extends Node2D

@export var buildings_scenes: Array[PackedScene]

@onready var buildings_map: TileMapLayer = $BuildingsMap
@onready var base_map: TileMapLayer = $BaseMap
@onready var wave_spawner: Node2D = $WaveSpawner

signal _on_kafe_click
signal town_hall_built
signal kafe_built
signal water_down_signal
signal game_over

var last_wave_date = "00.00.0000"

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

func _kafe_is_clicked():
	_on_kafe_click.emit()

func reinforce_walls():
	for child in get_children():
		if child is Wall and child.is_built:
			child.health += 50
			child.current_health += 50

func walls_take_damage():
	for child in get_children():
		if child is Building and child.is_built:
			child.current_health -= 100

func _on_test_build_3_pressed() -> void:
	walls_take_damage()

func deactivate_kafe():
	for child in get_children():
		if child is Kafe and child.is_built:
			child.deactivate_for_a_month()

func _on_test_build_pressed() -> void:
	_delete_not_build()
	var town_hall = buildings_scenes[0].instantiate()
	town_hall._on_check_free_ground.connect(is_tiles_are_free_ground)
	town_hall.built.connect(town_hall_built.emit)
	town_hall.destroyed.connect(game_over.emit)
	add_child(town_hall)

func _on_test_build_2_pressed() -> void:
	_delete_not_build()
	var kafe = buildings_scenes[1].instantiate()
	kafe._on_check_free_ground.connect(is_tiles_are_free_ground)
	kafe._on_click.connect(_kafe_is_clicked)
	kafe.built.connect(kafe_built.emit)
	add_child(kafe)

func _on_test_build_4_pressed() -> void:
	_delete_not_build()
	var wall = buildings_scenes[2].instantiate()
	add_child(wall)

func _on_test_build_5_pressed() -> void:
	_delete_not_build()
	var house = buildings_scenes[4].instantiate()
	add_child(house)

func _on_test_build_6_pressed() -> void:
	_delete_not_build()
	var repair_station = buildings_scenes[5].instantiate()
	add_child(repair_station)

func _on_test_build_7_pressed() -> void:
	_delete_not_build()
	var pomp = buildings_scenes[6].instantiate()
	add_child(pomp)

func _on_test_build_8_pressed() -> void:
	_delete_not_build()
	var mine = buildings_scenes[3].instantiate()
	add_child(mine)

func _on_day_timer_timeout() -> void:
	var water_down = false
	for child in get_children():
		if child is Building and child.is_built and not child.is_working and child is not Pomp:
			child.current_health -= 5
			water_down = true
	if water_down:
		water_down_signal.emit()
	
	var date_str = _format_date(CityResources.day, CityResources.month, CityResources.year)
	$"../../GUI/M/V/Control/WaveProgressBar".start_progress_countdown("20.03.4038", date_str)
	spawn_wave_at("20.04.4038", date_str, 1.0)
	$"../../GUI/M/V/Control/WaveProgressBar".start_progress_countdown("27.05.4038", date_str)
	spawn_wave_at("27.06.4038", date_str, 1.3)
	$"../../GUI/M/V/Control/WaveProgressBar".start_progress_countdown("12.07.4038", date_str)
	spawn_wave_at("12.08.4038", date_str, 1.0)
	$"../../GUI/M/V/Control/WaveProgressBar".start_progress_countdown("30.09.4038", date_str)
	spawn_wave_at("30.10.4038", date_str, 1.7)
	$"../../GUI/M/V/Control/WaveProgressBar".start_progress_countdown("1.12.4038", date_str)
	spawn_wave_at("01.01.4039", date_str, 2.0)
	$"../../GUI/M/V/Control/WaveProgressBar".start_progress_countdown("10.03.4039", date_str)
	spawn_wave_at("10.04.4039", date_str, 1.7)
	$"../../GUI/M/V/Control/WaveProgressBar".start_progress_countdown("30.06.4039", date_str)
	spawn_wave_at("30.07.4039", date_str, 3.5)

func spawn_wave_at(date: String, current_date: String, strength: float):
	if current_date == date and current_date != last_wave_date:
		wave_spawner.start_wave(strength)
		last_wave_date = current_date

func _format_date(day, month, year):
	return "%02d.%02d.%d" % [day, month, year]

func _delete_not_build():
	for child in get_children():
		if child is Building and not child.is_built:
			child.queue_free()
