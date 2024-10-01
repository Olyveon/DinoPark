extends Node2D

var ui_hover = true
var buildings_list:Array
@onready var tile_map = %TileMap
@onready var ui = %UI
@onready var canvas_modulate = %CanvasModulate
@onready var building_window = $Interface/UI/HBoxContainer/Building/Window
@onready var estructura= get_node("/root/Game/Utilities/Clist")
@export var building:PackedScene = load("res://scenes/building.tscn")
@export var dinocell:PackedScene = load("res://scenes/dino_cell.tscn")
@export var mountain:PackedScene = load("res://scenes/mountain.tscn")
@export var museum:PackedScene = load("res://scenes/museum.tscn")
@export var rueda:PackedScene = load("res://scenes/rueda.tscn")
@export var cruces:PackedScene = load("res://scenes/Cruces.tscn")
@export var Tiranosaurio:PackedScene = load("res://scenes/Dinos/Jaula_Tiranosaurio.tscn")
@export var Alosaurio:PackedScene= load("res://scenes/Dinos/Jaula_Alosaurio.tscn")
@export var Espinosaurio:PackedScene = load("res://scenes/Dinos/Jaula_Espinosaurio.tscn")
@export var Estegosaurio:PackedScene = load("res://scenes/Dinos/Jaula_Estegosaurio.tscn")
@export var Parasaurio:PackedScene = load("res://scenes/Dinos/Jaula_Parasaurio.tscn")
@export var Gigantosaurio:PackedScene = load("res://scenes/Dinos/Jaula_Gigantosaurio.tscn")
@export var Velocirraptor:PackedScene = load("res://scenes/Dinos/Jaula_Velocirraptor.tscn")
@export var Triceratops:PackedScene =  load("res://scenes/Dinos/Jaula_Triceratops.tscn")
@export var Evos:PackedScene= load("res://scenes/Evoluciones.tscn")

func _ready():
	Global.building_mode = false
	canvas_modulate.time_tick.connect(ui.set_daytime)
	canvas_modulate.pause_tick.connect(ui.pause)
	# Adds all the buildings to an array with its id 
	buildings_list.insert(0,building)
	buildings_list.insert(1,dinocell)
	buildings_list.insert(2,mountain)
	buildings_list.insert(3, museum)
	buildings_list.insert(4,rueda)
	buildings_list.insert(5, cruces)
	buildings_list.insert(6, Tiranosaurio)
	buildings_list.insert(7, Alosaurio)
	buildings_list.insert(8, Espinosaurio)
	buildings_list.insert(9, Estegosaurio)
	buildings_list.insert(10, Parasaurio)
	buildings_list.insert(11, Gigantosaurio)
	buildings_list.insert(12, Velocirraptor)
	buildings_list.insert(13, Triceratops)
	buildings_list.insert(14, Evos)
	estructura.lista_edificio.mostrar_lista()


#Construction mode
func _input(event):
	if Global.building_mode and ui_hover:
		if event.is_action_pressed("click_left"):
			var mouse_position = tile_map.local_to_map(Vector2i(get_global_mouse_position()))
			if is_free(mouse_position) and is_in_bounds(mouse_position):
				build(mouse_position,Global.building_id)
				
				
			else:
				return

func build(position:Vector2,id:int):
	var new_building = buildings_list[id].instantiate()
	estructura.lista_edificio.agregar("0")
	Global.money -= 200
	new_building.global_position = tile_map.map_to_local(position)
	tile_map.add_child(new_building)
	print("edificio agregado" + str(buildings_list[id]))
	Global.buildings+=1
	#Los numeros en esta seccion equivalen a los index de las evoluciones +5
	if id==6:
		Global.dinos.append("Tiranosaurio")
		print(Global.dinos)
	if id==7:
		Global.dinos.append("Alosaurio")
		print(Global.dinos)
	if id==8:
		Global.dinos.append("Espinosaurio")
		print(Global.dinos)
	if id==9:
		Global.dinos.append("Estegosaurio")
		print(Global.dinos)
	if id==10:
		Global.dinos.append("Parasaurio")
		print(Global.dinos)
	if id==11:
		Global.dinos.append("Gigantosaurio")
		print(Global.dinos)
	if id==12:
		Global.dinos.append("Velocirraptor")
		print(Global.dinos)
	if id==13:
		Global.dinos.append("Triceratops")
		print(Global.dinos)
	
	
# Makes sure that the mouse is not currently in the ui to not mess with things behind it 
func _on_h_box_container_mouse_entered():
	ui_hover = false

func _on_h_box_container_mouse_exited():
	ui_hover = true





func _on_building_toggled(toggled_on):
	Global.building_mode = toggled_on 
	building_window.visible = toggled_on
	

# Check if the tile is free before building 
func is_free(position:Vector2i):
	var occupied_list:Array = []
	occupied_list = tile_map.get_used_cells(1)
	for item in occupied_list:
		if item == position:
			return false
	return true

func is_in_bounds(position:Vector2i):
	var available_list:Array =[]
	available_list = tile_map.get_used_cells(0)
	for item in available_list:
		if item == position:
			return true
	return false



