extends Node2D

@onready var base: TileMapLayer = $Base
@onready var sprite: Sprite2D = $Sprite
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var rotated: bool = false
var is_built: bool = false


func _process(_delta: float) -> void:
	if not is_built:
		position = get_global_mouse_position().snapped(Vector2(30, 18))

func _input(event: InputEvent) -> void:
	if not is_built:
		if event.is_action_pressed("rotate"):
			_rotate()
		if event.is_action_pressed("build"):
			_build()

func _rotate():
	base.rotate_base(rotated)
	rotated = not rotated
	sprite.flip_h = rotated

func _build():
	animation_player.play("start_building")
	is_built = true
