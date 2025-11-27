extends Building

@onready var area_2d_2: Area2D = $Area2D2

var healing_ammount = 10
@onready var water_label_2: Label = $InfoPanel/MarginContainer/VBoxContainer/WaterLabel2


func _on_area_2d_mouse_entered() -> void:
	super._on_area_2d_mouse_entered()
	base_for_water.show()

func _on_area_2d_mouse_exited() -> void:
	super._on_area_2d_mouse_exited()
	base_for_water.hide()

func _next_day():
	super._next_day()
	if is_built:
		water_label_2.text = "Heal per day: " + str(healing_ammount)
		for building_area in area_2d_2.get_overlapping_areas():
			if building_area.name == "BaseArea":
				if building_area.get_parent().can_be_healed():
					building_area.get_parent().heal(healing_ammount)
					# play sound

func _build():
	super._build()
	base_for_water.hide()
