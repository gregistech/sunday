class_name MouseRotateInput

extends TwoDInput

@export var mouse_sensitivity : float = .25

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		input.emit(-event.relative * mouse_sensitivity)
