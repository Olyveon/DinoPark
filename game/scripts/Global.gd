extends Node

var building_mode:bool = false
var time:float = 0.0
var past_minute:float = -1.0
var money:int = 1000
var load = false

func on_load():
	building_mode = false

