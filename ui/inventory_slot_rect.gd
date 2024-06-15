class_name InventorySlotRect

extends TextureRect

var index : int
var stack : Stack

signal move(stack : Stack, target : int)
signal drop(stack : Stack)

# TODO: clearly not final
func _get_preview() -> Control:
	var holder := CenterContainer.new()
	
	# TODO: generalize this, kinda duplicate behaviour
	var preview : TextureRect = TextureRect.new()
	preview.texture = texture
	preview.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	preview.custom_minimum_size = Vector2(64, 64)
	preview.position = -.5 * preview.size
	
	var text : Label = Label.new()
	text.text = str(stack.size()) + "/" + str(stack.max_size)
	text.set_anchors_preset(Control.PRESET_BOTTOM_RIGHT)
	
	holder.add_child(preview)
	holder.add_child(text)
	return holder

func _set_drag_preview():
	var holder := _get_preview()
	set_drag_preview(holder)

func _get_drag_data(_at_position):
	if stack:
		_set_drag_preview()
		return stack
	
func _drop_data(_at_position, data):
	move.emit(data as Stack, index)
	
func _can_drop_data(_at_position, data):
	return data as Stack

# FIXME: detects everywhere
func _input(event):
	if event.is_action_pressed("drop"):
		accept_event()
		if stack:
			drop.emit(stack)
