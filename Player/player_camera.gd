extends Camera2D

@export var SCREEN_BORDER_FOR_MOVEMENT = 20


func _ready() -> void:
	position.x = (limit_right - limit_left) / 2
	position.y = (limit_bottom - limit_top) / 2

func _physics_process(delta: float) -> void:
	if get_global_mouse_position().x <= 0 + SCREEN_BORDER_FOR_MOVEMENT:
		print(position.x)
		#position.x -= 1
		#print(event.relative)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			zoom += Vector2(0.2, 0.2)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			zoom -= Vector2(0.2, 0.2)
	
