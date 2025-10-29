extends Window

@onready var estructura = get_node("/root/Game/Utilities/Clist")
@onready var menu_box= $MenuBox
@onready var tienda = $Tienda

func _on_standard_pressed():
	estructura.lista_edificio.mostrar_lista();


func _on_close_requested():
	visible=false
	Global.building_mode=false


func _on_cell_pressed():
	tienda.visible=!tienda.visible
	visible=false

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


func _on_cruces_pressed():
	if estructura.seleccionar_edificio("5"):
		Global.building_id = 5
	else:
		menu_box.visible=true
		menu_box.mesage("Alerta", "Necesitas construir otros edificios antes de acceder a este")
		Global.building_mode=false
		



func _on_tiranosaurio_pressed():
	if estructura.seleccionar_edificio("6"):
		Global.building_id = 6
	else:
		menu_box.visible=true
		menu_box.mesage("Alerta", "Necesitas construir otros edificios antes de acceder a este")
		Global.building_mode=false
		


func _on_alosaurio_pressed():
	if estructura.seleccionar_edificio("7"):
		Global.building_id = 7
	else:
		menu_box.visible=true
		menu_box.mesage("Alerta", "Necesitas construir otros edificios antes de acceder a este")
		Global.building_mode=false




func _on_espinosaurio_pressed():
	if estructura.seleccionar_edificio("8"):
		Global.building_id = 8
	else:
		menu_box.visible=true
		menu_box.mesage("Alerta", "Necesitas construir otros edificios antes de acceder a este")
		Global.building_mode=false



func _on_estegosaurio_pressed():
	if estructura.seleccionar_edificio("9"):
		Global.building_id = 9
	else:
		menu_box.visible=true
		menu_box.mesage("Alerta", "Necesitas construir otros edificios antes de acceder a este")
		Global.building_mode=false
		



func _on_parasaurio_pressed():
	if estructura.seleccionar_edificio("10"):
		Global.building_id = 10
	else:
		menu_box.visible=true
		menu_box.mesage("Alerta", "Necesitas construir otros edificios antes de acceder a este")
		Global.building_mode=false


func _on_gigantosaurio_pressed():
	if estructura.seleccionar_edificio("11"):
		Global.building_id = 11
	else:
		menu_box.visible=true
		menu_box.mesage("Alerta", "Necesitas construir otros edificios antes de acceder a este")
		Global.building_mode=false



func _on_velocirraptor_pressed():
	if estructura.seleccionar_edificio("12"):
		Global.building_id = 12
	else:
		menu_box.visible=true
		menu_box.mesage("Alerta", "Necesitas construir otros edificios antes de acceder a este")
		Global.building_mode=false
		



func _on_triceratops_pressed():
	if estructura.seleccionar_edificio("13"):
		Global.building_id = 13
	else:
		menu_box.visible=true
		menu_box.mesage("Alerta", "Necesitas construir otros edificios antes de acceder a este")
		Global.building_mode=false
		



func _on_evos_pressed():
	if estructura.seleccionar_edificio("14"):
		Global.building_id = 14
	else:
		menu_box.visible=true
		menu_box.mesage("Alerta", "Necesitas construir otros edificios antes de acceder a este")
		Global.building_mode=false
