extends Node2D

@onready var base: TileMapLayer = $Base
@onready var sprite: Sprite2D = $Sprite
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var second_timer: Timer = $SecondTimer
@onready var minute_timer: Timer = $MinuteTimer

var building_cost: int = 400

var rotated: bool = false
var is_built: bool = false


func _process(_delta: float) -> void:
	if not is_built:
		position = get_global_mouse_position().snapped(Vector2(30, 18))
		if CityResources.money - building_cost < 0:
			sprite.self_modulate = Color('ff000089')
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
	second_timer.start()
	minute_timer.start()
	CityResources.money -= building_cost

func _on_second_timer_timeout() -> void:
	pass # Replace with function body.

func _on_minute_timer_timeout() -> void:
	pass # Replace with function body.
