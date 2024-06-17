extends Node

var building_mode = false
var time:float = 0.0
var past_minute:float = -1.0

func on_load():
	building_mode = false
