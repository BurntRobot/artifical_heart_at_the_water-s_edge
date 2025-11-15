extends Building
class_name Kafe

signal _on_click

@onready var countdown_label: Label = $CountdownLabel

var is_deactivated = false
var countdown = 30

'''
func _input(event: InputEvent) -> void:
	if not is_built:
		super._input(event)
	elif is_built:
		if event.is_action_pressed("build"):
			_on_click.emit()
'''

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if not is_built:
		pass
	elif is_built and not is_deactivated and is_working:
		if event.is_action_pressed("build"):
			_on_click.emit()

func deactivate_for_a_month():
	is_deactivated = true
	countdown_label.text = str(countdown)

func _next_day():
	super._next_day()
	if is_deactivated:
		countdown -= 1
		countdown_label.text = str(countdown)
		if countdown == 0:
			is_deactivated = false
			countdown = 30
			countdown_label.text = ""
