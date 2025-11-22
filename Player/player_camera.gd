extends Camera2D

@export var SCREEN_BORDER_FOR_MOVEMENT = 20

var target_zoom: float = 1.0
const MIN_ZOOM: float = 0.5
const MAX_ZOOM: float = 1.0
const ZOOM_INCREMENT: float = 0.1
const ZOOM_RATE: float = 8.0


func _ready() -> void:
	pass
	#position.x = (limit_right - limit_left) / 2
	#position.y = (limit_bottom - limit_top) / 2

func _physics_process(delta: float) -> void:
	zoom = lerp(zoom, target_zoom * Vector2.ONE, ZOOM_RATE * delta)
	#set_physics_process(not is_equal_approx(zoom.x, target_zoom))
	if get_global_mouse_position().x <= 0 + SCREEN_BORDER_FOR_MOVEMENT:
		pass
		#print(position.x)
		#position.x -= 1
		#print(event.relative)

func _input(event: InputEvent) -> void:
	#if event is InputEventMouseMotion:
	#	if event.button_mask == MOUSE_BUTTON_MASK_MIDDLE:
	#		position -= event.relative * zoom
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN :
			zoom_in()
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom_out()

func zoom_in():
	target_zoom = max(target_zoom - ZOOM_INCREMENT, MIN_ZOOM)
	set_physics_process(true)

func zoom_out():
	target_zoom = min(target_zoom + ZOOM_INCREMENT, MAX_ZOOM)
	set_physics_process(true)
