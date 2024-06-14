class_name InventorySlot # TODO: many code duplicated with InvetorySlotRect

extends Panel

signal move(stack : Stack, target : int)
signal drop(stack : Stack)

@export var rect : InventorySlotRect
@export var stack_text : Label

var index : int
var stack : Stack

func _ready():
	rect.index = index
	rect.move.connect(_move)
	rect.drop.connect(_drop)

func set_stack(new_stack : Stack):
	if new_stack != null:
		stack = new_stack
		if stack.size() > 0:
			var item : Item = stack.items[0]
			if item:
				rect.stack = stack
				rect.texture = item.texture
				stack_text.text = str(stack.size()) + "/" + str(stack.max_size)

func _move(new_stack : Stack, target : int):
	move.emit(new_stack, target)
	
func _drop(new_stack : Stack):
	drop.emit(new_stack)
	
