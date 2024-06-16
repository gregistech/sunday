class_name InventorySlotRect

extends TextureRect

var index : int
var main_stack : Stack

var temp_stack : Stack = null
var use_temp := false

signal move(stack : Stack, target : int)
signal drop

# TODO: clearly not final
func _get_preview(stack : Stack) -> Control:
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

func _set_drag_preview(stack : Stack):
	var holder := _get_preview(stack)
	set_drag_preview(holder)

const stackgd = preload("res://inventory/stack.gd")
func _get_drag_data(_at_position):
	if use_temp:
		if temp_stack == null:
			temp_stack = stackgd.new([])
			temp_stack.transfer(main_stack, 1)
			_set_drag_preview(temp_stack)
			return temp_stack
	else:
		temp_stack = null
	if main_stack:
		_set_drag_preview(main_stack)
		return main_stack
	
func _drop_data(_at_position, data):
	move.emit(data as Stack, index)
	
func _can_drop_data(_at_position, data):
	return data as Stack
	
func _physics_process(_delta):
	use_temp = Input.is_action_pressed("pick_one_item")

# TODO: drop item outside inventory to drop
