extends Node2D

@onready var tile_map_layer: TileMapLayer = $TileMapLayer
const BASE_TILE_MAP_POINT: Vector2 = Vector2(-1, 0)


func _process(delta: float) -> void:
	position = get_global_mouse_position().snapped(Vector2(30, 18))

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("rotate"):
		for _tile in tile_map_layer.get_used_cells():
			var new_tile = Vector2i.ZERO
			new_tile.x = BASE_TILE_MAP_POINT.x - _tile.y
			new_tile.y = _tile.x - BASE_TILE_MAP_POINT.x
			tile_map_layer.erase_cell(_tile)
			tile_map_layer.set_cell(new_tile, 3, Vector2i(0,0))
