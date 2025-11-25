extends Node2D

@onready var player_camera: Camera2D = $PlayerCamera

var LEFT_MOUSE_BORDER
var RIGHT_MOUSE_BORDER
var UP_MOUSE_BORDER
var DOWN_MOUSE_BORDER
var border_width: int = 10

var LEFT_BORDER
var RIGHT_BORDER
var UP_BORDER
var DOWN_BORDER
var camera_speed: int = 150



func _ready() -> void:
	_set_borders()
	position = Vector2(LEFT_BORDER, UP_BORDER)

func _process(delta: float) -> void:
	_set_borders()
	if Input.is_action_pressed("left") and position.x > LEFT_BORDER:
		_move_camera(Vector2.LEFT, delta)
	if Input.is_action_pressed("right") and position.x < RIGHT_BORDER:
		_move_camera(Vector2.RIGHT, delta)
	if Input.is_action_pressed("up") and position.y > UP_BORDER:
		_move_camera(Vector2.UP, delta)
	if Input.is_action_pressed("down") and position.y < DOWN_BORDER:
		_move_camera(Vector2.DOWN, delta)
	
	var mouse_pos = get_local_mouse_position()
	if mouse_pos.x < LEFT_MOUSE_BORDER and position.x > LEFT_BORDER:
		_move_camera(Vector2.LEFT, delta)
	elif mouse_pos.x > RIGHT_MOUSE_BORDER and position.x < RIGHT_BORDER:
		_move_camera(Vector2.RIGHT, delta)
	if mouse_pos.y < UP_MOUSE_BORDER and position.y > UP_BORDER:
		_move_camera(Vector2.UP, delta)
	elif mouse_pos.y > DOWN_MOUSE_BORDER and position.y < DOWN_BORDER:
		_move_camera(Vector2.DOWN, delta)

func _move_camera(direction: Vector2, delta: float):
	position += direction * camera_speed * delta

func _set_borders():
	var half_screen_x = get_viewport_rect().size.x / 2
	var half_screen_y = get_viewport_rect().size.y / 2
	var mouse_border_x = get_viewport_rect().size.x / border_width
	var mouse_border_y = get_viewport_rect().size.y / border_width
	
	LEFT_BORDER = player_camera.limit_left + half_screen_x
	RIGHT_BORDER = player_camera.limit_right - half_screen_x
	UP_BORDER = player_camera.limit_top + half_screen_y
	DOWN_BORDER = player_camera.limit_bottom - half_screen_y
	
	LEFT_MOUSE_BORDER = -half_screen_x + mouse_border_x
	RIGHT_MOUSE_BORDER = half_screen_x - mouse_border_x
	UP_MOUSE_BORDER = -half_screen_y + mouse_border_y
	DOWN_MOUSE_BORDER = half_screen_y - mouse_border_y
	
	$LeftLine2D.position = Vector2(LEFT_MOUSE_BORDER, -half_screen_y)
	$RightLine2D.position = Vector2(RIGHT_MOUSE_BORDER, -half_screen_y)
	$UpLine2D.position = Vector2(-half_screen_x, UP_MOUSE_BORDER)
	$DownLine2D.position = Vector2(-half_screen_x, DOWN_MOUSE_BORDER)


"""
	if event.is_action_pressed("left"):
		if position.x > limit_left:
			position += Vector2.LEFT * camera_speed
			
		print(position)
	if event.is_action_pressed("right"):
		position += Vector2.RIGHT * camera_speed
		print(position)
"""
