extends Node2D

@onready var tile_map_layer: TileMapLayer = $TileMapLayer
const BASE_TILE_MAP_POINT: Vector2 = Vector2(-1, 0)
var rotated: bool = false


func _process(_delta: float) -> void:
	position = get_global_mouse_position().snapped(Vector2(30, 18))

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("rotate"):
		_rotate_base()

func _rotate_base():
	var old_tiles = tile_map_layer.get_used_cells()
	var new_tiles: Array[Vector2i]
	for _tile in old_tiles:
		var _new_tile_place = _get_rotated_tile_place(_tile)
		new_tiles.append(_new_tile_place)
		_rotate_tile(_tile, _new_tile_place)
	erase_unactive_tiles(new_tiles, old_tiles)
	rotated = not rotated

func _get_rotated_tile_place(_tile: Vector2i):
	var _new_tile_place = Vector2i.ZERO
	if not rotated:
		_new_tile_place.x = BASE_TILE_MAP_POINT.x - _tile.y
		_new_tile_place.y = _tile.x - BASE_TILE_MAP_POINT.x
	else:
		_new_tile_place.x = _tile.y + BASE_TILE_MAP_POINT.x
		_new_tile_place.y = BASE_TILE_MAP_POINT.x - _tile.x
	return _new_tile_place

func _rotate_tile(_tile: Vector2i, _new_tile_place: Vector2i):
	tile_map_layer.set_cell(_new_tile_place, 3, Vector2i(0,0))

func erase_unactive_tiles(_new_tiles: Array[Vector2i], _old_tiles: Array[Vector2i]):
	for _tile in _old_tiles:
		if _tile not in _new_tiles:
			tile_map_layer.erase_cell(_tile)
