extends Node2D
class_name Building

@onready var base: TileMapLayer = $Base
@onready var sprite: Sprite2D = $Sprite
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var building_cost: int = 400

var rotated: bool = false
var is_built: bool = false


func _physics_process(_delta: float) -> void:
	if not is_built:
		position = get_global_mouse_position().snapped(Vector2(30, 18))
		if CityResources.money - building_cost < 0:
			sprite.self_modulate = Color('ff000089')
			base._set_all_tiles_to_red()
		else:
			sprite.self_modulate = Color('ffffff89')

func _input(event: InputEvent) -> void:
	if not is_built:
		if event.is_action_pressed("rotate"):
			_rotate()
		if event.is_action_pressed("build"):
			if CityResources.money - building_cost >= 0:
				_build()
			else:
				animation_player.play("cant_build")

func _rotate():
	base.rotate_base(rotated)
	rotated = not rotated
	sprite.flip_h = rotated

func _build():
	animation_player.play("start_building")
	is_built = true
	CityResources.money -= building_cost
	CityResources.max_houses = 1

func next_day():
	CityResources.money += 5 #TODO: *workers

func next_month():
	pass
