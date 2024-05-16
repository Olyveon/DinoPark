extends Node2D
@onready var camera = $Camera2D
@onready var tile_map = %TileMap
var building_mode = false
var ui_hover = true
const camera_speed = 200.0
# Camera zoom values
var zoom_minimum = Vector2(.2,.2)
var zoom_maximum = Vector2(2.5,2.5)
var zoom_speed = Vector2(.1,.1)

func _ready():
	building_mode = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Gets the direction and moves the "player" which in turn moves the camera
	var direction_x = Input.get_axis("move_left","move_right")
	var direction_y = Input.get_axis("move_up","move_down")
	position.x += camera_speed * direction_x * delta
	position.y += camera_speed * direction_y * delta
# Checks if the mouse wheel it's changing and zooms in or out 
func _input(event: InputEvent):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				if camera.zoom > zoom_minimum:
					camera.zoom -= zoom_speed
					pass
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				if camera.zoom < zoom_maximum:
					camera.zoom += zoom_speed
					pass
			# Improved construction mode 
			if building_mode and ui_hover:
				if event.button_index == MOUSE_BUTTON_LEFT:
					var mouse_position = tile_map.local_to_map(Vector2i(get_global_mouse_position()))
					if mouse_position[0] <= 5 and mouse_position[1] <= 2 :
						tile_map.set_cell(1,mouse_position,1,Vector2i(1,0))
					pass
				if event.button_index == MOUSE_BUTTON_RIGHT:
					var mouse_position = tile_map.local_to_map(Vector2i(get_global_mouse_position()))
					tile_map.erase_cell(1,mouse_position)

func _on_construction_toggled(toggled_on):
	building_mode = toggled_on

# Makes sure that the mouse is not currently in the ui to not mess with things behind it 
func _on_h_box_container_mouse_entered():
	pass
	print("hovered")
	ui_hover = false

func _on_h_box_container_mouse_exited():
	print("unhovered")
	ui_hover = true





func _on_ui_mouse_entered():
	print("ui hovered")
