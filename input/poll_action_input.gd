class_name PollActionInput

extends BoolInput

@export var action : String

func _process(_delta):
	if Input.is_action_pressed(action):
		input.emit()
