extends Node
@onready var tile_map = %TileMap
@onready var player = %Player
@onready var camera = player.get_child(0)
# We use Resources to save the game this lets us save the game in a fast, human-readable, easy way 
func save_game():
	var saved_game:SavedGame = SavedGame.new()
	
	saved_game.camera_zoom = camera.zoom
	saved_game.player_position = player.position
	
	var saved_data:Array[SavedData] = []
	get_tree().call_group("game_objects", "on_save_game", saved_data)
	saved_game.saved_data = saved_data
	
	ResourceSaver.save(saved_game, "user://savegame.tres")
	print("saved")

func load_game():
	Global.on_load()
	var saved_game:SavedGame = load("user://savegame.tres") as SavedGame
	
	player.position = saved_game.player_position
	camera.zoom = saved_game.camera_zoom
	
	get_tree().call_group("game_objects", "on_before_load")
	
	for item in saved_game.saved_data:
		var scene = load(item.scene_path) as PackedScene
		var restored_node = scene.instantiate()
		tile_map.add_child(restored_node)
		
		if restored_node.has_method("on_load_game"):
			restored_node.on_load_game(item)
		
	print("loaded")
