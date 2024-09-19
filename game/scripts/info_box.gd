extends Window

@onready var revenue_label = $MarginContainer/VBoxContainer/RevenueLabel

func display_info(window_name:String, revenue):
	title = window_name
	revenue_label.text = "Beneficios: $" + str(revenue) + "/hr"


func _on_close_requested():
	queue_free()
