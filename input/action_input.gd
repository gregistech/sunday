class_name ActionInput

extends BoolInput

@export var action : String

func _input(event):
	if event.is_action_pressed(action):
		input.emit()
