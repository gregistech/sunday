class_name RunInput

extends BoolInput

func _physics_process(_delta):
	input.emit(Input.is_action_pressed("run"))
