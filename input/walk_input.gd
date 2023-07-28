class_name WalkInput

extends TwoDInput

func _physics_process(_delta):
	var input_vec : Vector2 = Vector2.ZERO
	input_vec.x += Input.get_action_strength("walk_forward") - Input.get_action_strength("walk_backward")
	input_vec.y += Input.get_action_strength("walk_left") - Input.get_action_strength("walk_right")
	input.emit(input_vec)
