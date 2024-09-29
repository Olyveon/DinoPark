extends Node2D


const MINUTES_PER_DAY = 1440 
const MINUTES_PER_HOUR = 60
const INGAME_TO_REAL_MINUTE_DURATION = (2 * PI) / MINUTES_PER_DAY

var cell_position
var building_name:String = "Montaña Rusa"
var is_point_inside = false
# cooldown is defined in in-game minutes 
var cooldown = 30
# This variables are used when loading and unloading a game file
var target_minute = 60
var target_hour = 24
# How much money does it generate
var revenue = 60

@onready var menu_box = $MenuBox
@onready var tile_map = get_parent()


# Called when the node enters the scene tree for the first time.
func _ready():
	cell_position = tile_map.local_to_map(position)
	tile_map.set_cell(1,cell_position,1,Vector2i(0,1))
	_timer()

func _process(delta):
	var total_minutes = int(Global.time / INGAME_TO_REAL_MINUTE_DURATION)
	var current_day_minutes = total_minutes % MINUTES_PER_DAY
	var current_minute = int(current_day_minutes % MINUTES_PER_HOUR)
	var current_hour = int(current_day_minutes / MINUTES_PER_HOUR)
	if target_minute == current_minute and target_hour == current_hour:
		on_time()
# Handles input
func _input(event):
	# Check if the event is a mouse button press
	if is_point_inside:
			if event.is_action_pressed("click_left"):
				if Global.building_mode == false:
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

# Its called when the building is clicked
func on_click():
	var new_state = !menu_box.visible
	menu_box.visible = new_state
	if new_state == true :
		menu_box.position = menu_box.position - Vector2i(20,20)
		menu_box.mesage(building_name,"Actualmente esta generando: " + "$" + str(revenue) + " cada " + str(cooldown) + " minutos" )


# Defines what properties will be saved 
func on_save_game(saved_data:Array[SavedData]):
	var my_data = SavedData.new()
	my_data.position = global_position
	my_data.building_name = building_name
	my_data.scene_path = scene_file_path
	my_data.minutes_left = target_minute
	my_data.hours_left = target_hour 
	saved_data.append(my_data)
# Destroys itself before loading to not cause repetion
func on_before_load():
	tile_map.erase_cell(1,cell_position)
	tile_map.remove_child(self)
	queue_free()
# Asigns properties to the building after loading the game
func on_load_game(saved_data:SavedData):
	global_position = saved_data.position
	target_minute = saved_data.minutes_left
	target_hour = saved_data.hours_left
	building_name = saved_data.building_name
# Sets a target hour and a taget minute to when the timer should end
func _timer() -> void:
	
	var total_minutes = int(Global.time / INGAME_TO_REAL_MINUTE_DURATION)
	var current_day_minutes = total_minutes % MINUTES_PER_DAY
	var current_minute = int(current_day_minutes % MINUTES_PER_HOUR)
	var current_hour = int(current_day_minutes / MINUTES_PER_HOUR)
	var sum = current_minute + cooldown
	var hour = int(sum / 60) + current_hour
	
	if hour > 23:
		target_hour = hour - 24
	else :
		target_hour = hour
	if sum > 59 :
		target_minute = (sum%60)
	else:
		target_minute = sum
#Defines what happens when the timer ends
func on_time():
	Global.money += revenue
	_timer()

func minutes(x):
	return 60/x