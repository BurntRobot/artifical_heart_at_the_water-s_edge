extends Node2D
class_name Building

@onready var base: TileMapLayer = $Base
@onready var base_for_water: TileMapLayer = $BaseForWater
@onready var sprite: Sprite2D = $Sprite
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var health_bar: ProgressBar = $HealthBar
@onready var health_label: Label = $HealthBar/Label
@onready var area_2d: Area2D = $Area2D

@export var water_in_day = 1
@export var building_cost: int = 400
@export var is_built: bool = false
@export var health: int = 250
var current_health: int


var rotated: bool = false
var can_build: bool = true

signal _on_check_free_ground(_tile_map: Array[Vector2i])
signal _on_check_free_water(_tile_map: Array[Vector2i])
signal built

func _ready() -> void:
	CityResources._on_next_day.connect(_next_day)
	CityResources._on_next_month.connect(_next_month)
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	health_bar.max_value = health
	current_health = health
	health_bar.value = current_health

func _physics_process(_delta: float) -> void:
	if not is_built:
		if position != get_global_mouse_position().snapped(Vector2(30, 18)):
			position = get_global_mouse_position().snapped(Vector2(30, 18))
		if CityResources.money - building_cost < 0 or CityResources.water < water_in_day:
			sprite.self_modulate = Color('ff000089')
			base._set_all_tiles_to_red()
			can_build = false
		else:
			sprite.self_modulate = Color('ffffff89')
			base._update_tiles_colors()
			can_build = true
		# Place for a building
		#_on_check_free_ground.emit(base.get_used_cells())
		#if base_for_water.get_used_cells() == null:
		#	_on_check_free_water.emit(base_for_water.get_used_cells())
	else:
		health_bar.value = current_health
		health_label.text = str(current_health)
		health_bar.max_value = health
		if current_health <= 0:
			queue_free()

func _input(event: InputEvent) -> void:
	if not is_built:
		if event.is_action_pressed("rotate"):
			_rotate()
		if event.is_action_pressed("build"):
			if CityResources.money - building_cost >= 0 and can_build:
				_build()
				built.emit()
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
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _next_day():
	if not area_2d.input_pickable and is_built:
		area_2d.input_pickable = true
	if is_built:
		if CityResources.water >= water_in_day:
			CityResources.water -= water_in_day
		else:
			pass # if water down deactivate
func _next_month(): pass

func set_red_places(_red_tiles: Array[Vector2i]):
	can_build = false
	for _tile in _red_tiles:
		base.set_cell(_tile, 0, Vector2(3, 0))
