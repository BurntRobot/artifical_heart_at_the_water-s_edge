extends Node2D

@onready var player_camera: Camera2D = $PlayerCamera
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
		position += Vector2.LEFT * camera_speed * delta
		print("Left")
	if Input.is_action_pressed("right") and position.x < RIGHT_BORDER:
		position += Vector2.RIGHT * camera_speed * delta
		print("Right")
	if Input.is_action_pressed("up") and position.y > UP_BORDER:
		position += Vector2.UP * camera_speed * delta
		print("Up")
	if Input.is_action_pressed("down") and position.y < DOWN_BORDER:
		position += Vector2.DOWN * camera_speed * delta
		print("Down")

func _input(_event: InputEvent) -> void:
	pass

func _set_borders():
	LEFT_BORDER = player_camera.limit_left + get_viewport_rect().size.x / 2
	RIGHT_BORDER = player_camera.limit_right - get_viewport_rect().size.x / 2
	UP_BORDER = player_camera.limit_top + get_viewport_rect().size.y / 2
	DOWN_BORDER = player_camera.limit_bottom - get_viewport_rect().size.y / 2



"""
	if event.is_action_pressed("left"):
		if position.x > limit_left:
			position += Vector2.LEFT * camera_speed
			
		print(position)
	if event.is_action_pressed("right"):
		position += Vector2.RIGHT * camera_speed
		print(position)
"""
