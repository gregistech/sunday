class_name InventorySlotRect

extends TextureRect

var index : int
var item : Item

signal move(item : Item, target : int)
signal drop(item : Item)


func _get_preview_rect() -> TextureRect:
	var preview : TextureRect = TextureRect.new()
	preview.texture = texture
	preview.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	preview.custom_minimum_size = Vector2(64, 64)
	return preview

func _set_drag_preview():
	var rect = _get_preview_rect()
	var holder : Control = Control.new()
	holder.add_child(rect)
	set_drag_preview(holder)
	rect.position = -.5 * rect.size

func _get_drag_data(_at_position):
	print(item)
	if item:
		_set_drag_preview()
		return item
	
func _drop_data(_at_position, data):
	move.emit(data as Item, index)
	
func _can_drop_data(_at_position, data):
	return data as Item

# FIXME: detects everywhere
func _input(event):
	if event.is_action_pressed("drop"):
		accept_event()
		print(item)
		if item:
			drop.emit(item)
