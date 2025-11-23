extends Area2D

@export var damage: float = 300.0
@export var weakening: float = 50.0
@onready var timer: Timer = $Timer


func _physics_process(delta: float) -> void:
	position += Vector2(-30, -18) * delta
	if damage <= 0:
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.name == "BaseArea":
		var building = area.get_parent()
		if building.current_health > damage:
			building.hurt_for(damage)
			damage -= damage
		else:
			damage -= building.current_health
			building.hurt_for(building.current_health)

func _on_area_exited(area: Area2D) -> void:
	if area.name == "Water":
		timer.start()

func _on_timer_timeout() -> void:
	damage -= weakening

func set_damage(strength: float):
	damage *= strength
