extends Node2D

@onready var base: TileMapLayer = $Base
@onready var sprite: Sprite2D = $Sprite

var rotated: bool = false


func _process(_delta: float) -> void:
	position = get_global_mouse_position().snapped(Vector2(30, 18))

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("rotate"):
		_rotate()

func _rotate():
	base.rotate_base(rotated)
	rotated = not rotated
	sprite.flip_h = rotated
