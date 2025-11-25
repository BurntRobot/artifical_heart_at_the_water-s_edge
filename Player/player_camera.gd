extends Camera2D

var target_zoom: float = 1.0
const MIN_ZOOM: float = 0.5
const MAX_ZOOM: float = 1.0
const ZOOM_INCREMENT: float = 0.1
const ZOOM_RATE: float = 8.0

var camera_speed = 30

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	zoom = lerp(zoom, target_zoom * Vector2.ONE, ZOOM_RATE * delta)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN :
			zoom_in()
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom_out()

func zoom_in():
	target_zoom = max(target_zoom - ZOOM_INCREMENT, MIN_ZOOM)
func zoom_out():
	target_zoom = min(target_zoom + ZOOM_INCREMENT, MAX_ZOOM)
