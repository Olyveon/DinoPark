extends Button

@onready var hast = get_node("/root/Game/Utilities/THast")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _pressed():
	hast.evolucionar_dinosaurio(1)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
