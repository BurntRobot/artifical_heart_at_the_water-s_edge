extends Node2D
class_name Building

@onready var base: TileMapLayer = $Base
@onready var base_for_water: TileMapLayer = $BaseForWater
@onready var sprite: Sprite2D = $Sprite
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var health_bar: ProgressBar = $HealthBar
@onready var health_label: Label = $HealthBar/Label
@onready var area_2d: Area2D = $Area2D
@onready var water_label: Label = $InfoPanel/MarginContainer/VBoxContainer/WaterLabel
@onready var info_panel: PanelContainer = $InfoPanel
@onready var label: Label = $InfoPanel/MarginContainer/VBoxContainer/Label

@onready var base_area: Area2D = $BaseArea

@export var water_in_day = 1
@export var building_cost: int = 400
@export var is_built: bool = false
@export var health: int = 250
var current_health: int

var is_working = true

var rotated: bool = false
var can_build: bool = true

signal _on_check_free_ground(_tile_map: Array[Vector2i])
signal _on_check_free_water(_tile_map: Array[Vector2i])
signal built

const tile_size: Vector2 = Vector2(30, 18)
const tile_size_2: Vector2 = Vector2(15, 9)

func _ready() -> void:
	CityResources._on_next_day.connect(_next_day)
	CityResources._on_next_month.connect(_next_month)
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	health_bar.max_value = health
	current_health = health
	health_bar.value = current_health
	label.text = self.name

func _physics_process(_delta: float) -> void:
	if not is_built:
		var near_position = snap_iso(get_global_mouse_position(), tile_size)
		if position != near_position:
			position = near_position
		#if position != get_global_mouse_position().snapped(tile_size):
		#	position = get_global_mouse_position().snapped(tile_size)
		if you_cant_build():
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
		if current_health < health:
			health_bar.show()
		else:
			health_bar.hide()
		if current_health <= 0:
			_destroy_building()

func _destroy_building():
	queue_free()
	# destruction animation

func you_cant_build():
	return _no_money_for_build() or _no_water_for_building() or _something_placed_already()
func _no_money_for_build():
	return CityResources.money - building_cost < 0
func _no_water_for_building():
	return CityResources.water < water_in_day
func _something_placed_already():
	for _some_area in base_area.get_overlapping_areas():
		if _some_area.name == "BaseArea" and _some_area != base_area:
			return true
	return false


func snap_iso(pos: Vector2, tile_size_var: Vector2) -> Vector2:
	var half_tile_size: Vector2 = tile_size_var * 0.5
	
	var grid_x: float = round((pos.x / half_tile_size.x + pos.y / half_tile_size.y) * 0.5)
	var grid_y: float = round((pos.y / half_tile_size.y - pos.x / half_tile_size.x) * 0.5)
	
	return Vector2(grid_x-grid_y, grid_x+grid_y) * half_tile_size

func hurt_for(damage: int):
	current_health -= damage

func _input(event: InputEvent) -> void:
	if not is_built:
		if event.is_action_pressed("rotate"):
			_rotate()
		if event.is_action_pressed("build"):
			if CityResources.money - building_cost >= 0 and can_build:
				_build()
				built.emit()
				water_label.text = "Water per day: -" + str(water_in_day)
			else:
				animation_player.play("cant_build")
		if event.is_action_pressed("unbuild"):
			queue_free()
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

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
			is_working = true
			$Sprite.self_modulate = Color(1.0, 1.0, 1.0, 1.0)
			CityResources.water -= water_in_day
			water_label.text = "Water per day: -" + str(water_in_day)
		else:
			is_working = false
			$Sprite.self_modulate = Color(0.349, 0.349, 0.349, 1.0)
func _next_month(): pass

func set_red_places(_red_tiles: Array[Vector2i]):
	can_build = false
	for _tile in _red_tiles:
		base.set_cell(_tile, 0, Vector2(3, 0))

func _on_area_2d_mouse_entered() -> void:
	info_panel.show()
	health_bar.show()

func _on_area_2d_mouse_exited() -> void:
	info_panel.hide()
	health_bar.hide()

func heal(ammount: int):
	if current_health < health:
		current_health += ammount
	if current_health > health:
		current_health = health

func can_be_healed():
	return current_health < health
