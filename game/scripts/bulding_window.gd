extends Window


func _on_standard_pressed():
	Global.building_id = 0


func _on_close_requested():
	visible=false


func _on_cell_pressed():
	Global.building_id = 1
