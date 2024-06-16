class_name QuickbarSlot

extends Container

var stack : Stack = null
@export_range(1, 9) var index : int = 1

signal activate # NOTE: we'll check if we need to use/equip elsewhere

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("quickbar_" + str(index)):
		activate.emit()
