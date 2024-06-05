extends Node
@onready var tile_map = %TileMap
@onready var player = %Player
@onready var camera = player.get_child(0)
# We use Resources to save the game this lets us save the game in a fast, human-readable, easy way 
func save_game():
	var saved_game:SavedGame = SavedGame.new()
	saved_game.camera_zoom = camera.zoom
	saved_game.player_position = player.position
	for building in get_tree().get_nodes_in_group("buildings"):
		saved_game.building_positions.append(building.cell_position)
	
	ResourceSaver.save(saved_game, "user://savegame.tres")
	print("saved")

func load_game():
	var saved_game:SavedGame = load("user://savegame.tres") as SavedGame
	
	player.position = saved_game.player_position
	camera.zoom = saved_game.camera_zoom
	for building in get_tree().get_nodes_in_group("buildings"):
		var pos = building.cell_position
		tile_map.erase_cell(1,pos)
	for position in saved_game.building_positions:
		tile_map.set_cell(1,position,2,Vector2i(0,0),1)
		
	print("loaded")
