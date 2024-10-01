extends Node

var building_mode:bool = false
var time:float = 0.0
var past_minute:float = -1.0
var money:int = 1000
var load = false
var building_id:int = 3
var buildings:int = 0
var dinos:Array=[]
var dinos_evo:Array=[]
var building_especial=0

func on_load():
	building_mode = false

