extends RichTextLabel

var water_out_str: String = "Water out! Buildings collapsing!"


func _on_map_water_down_signal() -> void:
	text = water_out_str
