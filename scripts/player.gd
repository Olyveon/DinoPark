extends Node2D

const camera_speed = 100.0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction_x = Input.get_axis("move_left","move_right")
	var direction_y = Input.get_axis("move_up","move_down")
	position.x += camera_speed * direction_x * delta
	position.y += camera_speed * direction_y * delta
