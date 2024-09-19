extends CanvasModulate


const MINUTES_PER_DAY = 1440 
const MINUTES_PER_HOUR = 60
const INGAME_TO_REAL_MINUTE_DURATION = (2 * PI) / MINUTES_PER_DAY

signal time_tick(day:int, hour:int, minute:int)
signal pause_tick()

var prev_speed = 1.0
@export var gradient:GradientTexture1D
@export var INGAME_SPEED = 1.0
@export var INITIAL_HOUR = 8:
	set(h):
		INITIAL_HOUR = h
		Global.time = INGAME_TO_REAL_MINUTE_DURATION * INITIAL_HOUR * MINUTES_PER_HOUR

func on_load():
	INGAME_SPEED = 1.0
	_recaculate_time()

func _ready() -> void:
	Global.time = INGAME_TO_REAL_MINUTE_DURATION * INITIAL_HOUR * MINUTES_PER_HOUR

func _process(delta: float) -> void:
	Global.time += delta * INGAME_TO_REAL_MINUTE_DURATION * INGAME_SPEED
	var value = (sin(Global.time - PI / 2) + 1.0) / 2.0
	self.color = gradient.gradient.sample(value)
	
	_recaculate_time()
	
func _input(event):
	if event.is_action_pressed("stop"):
		if INGAME_SPEED > 0:
			prev_speed = INGAME_SPEED
			INGAME_SPEED = 0.0
			pause_tick.emit()
		else:
			INGAME_SPEED = prev_speed
			pause_tick.emit()
func _recaculate_time() -> void:
	var total_minutes = int(Global.time / INGAME_TO_REAL_MINUTE_DURATION)
	
	var day = int(total_minutes / MINUTES_PER_DAY)
	
	var current_day_minutes = total_minutes % MINUTES_PER_DAY
	
	var hour = int(current_day_minutes / MINUTES_PER_HOUR)
	var minute = int(current_day_minutes % MINUTES_PER_HOUR)
	if Global.past_minute != minute:
		Global.past_minute = minute
		time_tick.emit(day,hour,minute)
