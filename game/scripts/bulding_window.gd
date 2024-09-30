extends Window
@onready var estructura= get_node("/root/Game/Utilities/Clist")

func _on_standard_pressed():
	estructura.lista_edificio.mostrar_lista();


func _on_close_requested():
	visible=false


func _on_cell_pressed():
	if estructura.seleccionar_edificio("1"):
		Global.building_id = 1
	else:
		print("falta")

func _on_button_pressed():
	if estructura.seleccionar_edificio("2"):
		Global.building_id = 2
	else:
		print("falta")

func _on_button_2_pressed():
	if estructura.seleccionar_edificio("3"):
		Global.building_id = 3
	else:
		print("falta")

func _on_button_3_pressed():
	if estructura.seleccionar_edificio("4"):
		Global.building_id = 4
	else:
		print("falta")
