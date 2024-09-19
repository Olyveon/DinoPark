extends Control

@onready var day_label = $HBoxContainer2/DayLabel
@onready var time_label = $HBoxContainer2/HourLabel
@onready var money_label = $HBoxContainer2/MoneyLabel
@onready var texture_rect = $TextureRect

func _process(delta):
	money_label.text = "$" + str(Global.money)

func set_daytime(day: int, hour: int, minute: int) -> void:
	day_label.text = "Day " + str(day + 1)
	time_label.text = _amfm_hour(hour) + ":" + _minute(minute) + " " + _am_pm(hour)

func pause_ui()-> void:
	texture_rect.visible = true
	print("puto")

func pause()->void:
	var new_state = not texture_rect.visible
	texture_rect.visible = new_state

func _amfm_hour(hour:int) -> String:
	if hour == 0:
		return str(12)
	if hour > 12:
		return str(hour - 12)
	return str(hour)


func _minute(minute:int) -> String:
	if minute < 10:
		return "0" + str(minute)
	return str(minute)


func _am_pm(hour:int) -> String:
	if hour < 12:
		return "am"
	else:
		return "pm"
