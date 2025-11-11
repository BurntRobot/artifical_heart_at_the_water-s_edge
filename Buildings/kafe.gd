extends Building
class_name Kafe

signal _on_click


func _input(event: InputEvent) -> void:
	if not is_built:
		super._input(event)
	elif is_built:
		if event.is_action_pressed("build"):
			_on_click.emit()
