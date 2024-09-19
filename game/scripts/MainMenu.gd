extends Control

func _on_exit_pressed():
	get_tree().quit()
func _on_load_game_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")
	SaveLoader.load_game()
func _on_start_game_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")
