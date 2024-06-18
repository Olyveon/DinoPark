extends Node2D

var cell_position
var building_name:String = "building"
var is_point_inside = false

@onready var tile_map = get_parent()
@onready var timer = $Timer


# Called when the node enters the scene tree for the first time.
func _ready():
	cell_position = tile_map.local_to_map(position)
	tile_map.set_cell(1,cell_position,1,Vector2i(0,1))
	timer.start()

func _input(event):
	# Check if the event is a mouse button press
	if is_point_inside:
			if event.is_action_pressed("click_left"):
				on_click()
			if event.is_action_pressed("click_right"):
				if Global.building_mode:
					tile_map.erase_cell(1,cell_position)
					tile_map.remove_child(self)
					queue_free()

# Function to check if a mouse is inside the collision shape
func _on_area_2d_mouse_entered():
	is_point_inside = true

func _on_area_2d_mouse_exited():
	is_point_inside = false

# Pontentially add a hover on inteface to see the building's data
func on_click():
	pass

func on_save_game(saved_data:Array[SavedData]):
	var my_data = SavedData.new()
	my_data.position = global_position
	my_data.building_name = building_name
	my_data.scene_path = scene_file_path
	my_data.timer_left = timer.time_left
	saved_data.append(my_data)

func on_before_load():
	tile_map.remove_child(self)
	queue_free()

func on_load_game(saved_data:SavedData):
	global_position = saved_data.position
	timer.start(saved_data.timer_left)
	building_name = saved_data.building_name


func _on_timer_timeout():
	timer.wait_time = 10
	Global.money += 10
