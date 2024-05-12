extends Node2D
@onready var camera = $Camera2D
@onready var tile_map = %TileMap

const camera_speed = 200.0
# Camera zoom values
var zoom_minimum = Vector2(.2,.2)
var zoom_maximum = Vector2(2.5,2.5)
var zoom_speed = Vector2(.1,.1)

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
			# Improvised construction mode 
			if event.button_index == MOUSE_BUTTON_LEFT:
				var mouse_position = tile_map.local_to_map(Vector2i(get_global_mouse_position()))
				tile_map.set_cell(1,mouse_position,1,Vector2i(1,0))
			if event.button_index == MOUSE_BUTTON_RIGHT:
				var mouse_position = tile_map.local_to_map(Vector2i(get_global_mouse_position()))
				tile_map.erase_cell(1,mouse_position)
