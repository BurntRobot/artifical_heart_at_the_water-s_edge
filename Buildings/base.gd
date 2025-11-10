extends TileMapLayer
class_name BuildingBaseTiles

const BASE_TILE_MAP_POINT: Vector2 = Vector2(-1, 0)


func rotate_base(_is_rotated: bool):
	var _old_tiles = get_used_cells()
	var _new_tiles: Array[Vector2i]
	for _tile in _old_tiles:
		var _new_tile_place = _get_rotated_tile_place(_tile, _is_rotated)
		_new_tiles.append(_new_tile_place)
		_rotate_tile(_tile, _new_tile_place)
	_erase_unactive_tiles(_new_tiles, _old_tiles)

func _get_rotated_tile_place(_tile: Vector2i, _is_rotated: bool):
	var _new_tile_place = Vector2i.ZERO
	if not _is_rotated:
		_new_tile_place.x = BASE_TILE_MAP_POINT.x - _tile.y
		_new_tile_place.y = _tile.x - BASE_TILE_MAP_POINT.x
	else:
		_new_tile_place.x = _tile.y + BASE_TILE_MAP_POINT.x
		_new_tile_place.y = BASE_TILE_MAP_POINT.x - _tile.x
	return _new_tile_place

func _rotate_tile(_tile: Vector2i, _new_tile_place: Vector2i):
	set_cell(_new_tile_place, 0, Vector2i(2,0))

func _erase_unactive_tiles(_new_tiles: Array[Vector2i], _old_tiles: Array[Vector2i]):
	for _tile in _old_tiles:
		if _tile not in _new_tiles:
			erase_cell(_tile)

func _update_tiles_colors():
	for _tile in get_used_cells():
		set_cell(_tile, 0, Vector2i(2,0))
	#get_cell_tile_data(_tile).get_custom_data("Buildable")

func _set_all_tiles_to_red():
	for _tile in get_used_cells():
		set_cell(_tile, 0, Vector2i(3,0))
