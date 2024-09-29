extends Window


func _on_standard_pressed():
	Global.building_id = 0


func _on_close_requested():
	visible=false


func _on_cell_pressed():
	Global.building_id = 1


func _on_button_pressed():
	Global.building_id = 2


func _on_button_2_pressed():
	Global.building_id = 3


func _on_button_3_pressed():
	Global.building_id = 4
