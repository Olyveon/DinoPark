extends Node2D
@onready var camera = $Camera2D
const camera_speed = 200.0
# Camera zoom values
var zoom_minimum = Vector2(.2,.2)
var zoom_maximum = Vector2(2.5,2.5)
var zoom_speed = Vector2(.1,.1)

func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Gets the direction and moves the "player" which in turn moves the camera
	var direction_x = Input.get_axis("move_left","move_right")
	var direction_y = Input.get_axis("move_up","move_down")
	position.x += camera_speed * direction_x * delta
	position.y += camera_speed * direction_y * delta
func _input(event: InputEvent):
	if event is InputEventMouseButton:
		# Checks if the mouse wheel it's changing and zooms in or out 
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				if camera.zoom > zoom_minimum:
					camera.zoom -= zoom_speed
					pass
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				if camera.zoom < zoom_maximum:
					camera.zoom += zoom_speed
					pass
