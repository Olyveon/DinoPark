extends Node2D
var building_mode = false
var ui_hover = true
@onready var tile_map = %TileMap
@export var building: PackedScene
const BUILDING = preload("res://scripts/building.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	building_mode = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
#Construction mode
func _input(event):
	if building_mode and ui_hover:
		if event.is_action_pressed("click_left"):
			var mouse_position = tile_map.local_to_map(Vector2i(get_global_mouse_position()))
			tile_map.set_cell(1,mouse_position,2,Vector2i(0,0),1)
		if event.is_action_pressed("click_right"):
			var mouse_position = tile_map.local_to_map(Vector2i(get_global_mouse_position()))
			tile_map.erase_cell(1,mouse_position)
			pass

# Makes sure that the mouse is not currently in the ui to not mess with things behind it 
func _on_h_box_container_mouse_entered():
	ui_hover = false

func _on_h_box_container_mouse_exited():
	ui_hover = true

func _on_building_toggled(toggled_on):
	building_mode = toggled_on 
