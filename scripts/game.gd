extends Node2D
var ui_hover = true
@onready var tile_map = %TileMap
@export var building:PackedScene = load("res://scenes/building.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	Global.building_mode = false

#Construction mode
func _input(event):
	if Global.building_mode and ui_hover:
		if event.is_action_pressed("click_left"):
			var mouse_position = tile_map.local_to_map(Vector2i(get_global_mouse_position()))
			if is_free(mouse_position):
				var new_building = building.instantiate()
				new_building.global_position = tile_map.map_to_local(mouse_position)
				tile_map.add_child(new_building)
			else:
				return

# Makes sure that the mouse is not currently in the ui to not mess with things behind it 
func _on_h_box_container_mouse_entered():
	ui_hover = false

func _on_h_box_container_mouse_exited():
	ui_hover = true

func _on_building_toggled(toggled_on):
	Global.building_mode = toggled_on 

func is_free(position:Vector2i):
	var occupied_list:Array = []
	occupied_list = tile_map.get_used_cells(1)
	for item in occupied_list:
		if item == position:
			return false
	return true
