extends Node2D
var cell_position
var is_point_inside = false
@onready var tile_map = get_parent()


# Called when the node enters the scene tree for the first time.
func _ready():
	cell_position = tile_map.local_to_map(position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _input(event):
	# Check if the event is a mouse button press
	if event.is_action_pressed("click_left"):
		if is_point_inside:
			_on_click()
# Function to check if a mouse is inside the collision shape
func _on_area_2d_mouse_entered():
	is_point_inside = true
func _on_area_2d_mouse_exited():
	is_point_inside = false
# Pontentially add a hover on inteface to see the building's data
func _on_click():
	pass
