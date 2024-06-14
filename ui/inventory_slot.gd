class_name InventorySlot # TODO: many code duplicated with InvetorySlotRect

extends Panel

signal move(stack, target : int)
signal drop(stack)

@export var rect : InventorySlotRect
@export var stack_text : Label

var index : int
var stack : Array

func _ready():
	rect.index = index
	rect.move.connect(_move)
	rect.drop.connect(_drop)

func set_stack(new_stack): # FIXME: not typed as godot's typing system is atrocious
	stack = new_stack
	if stack.size() > 0:
		var item : Item = stack[0]
		if item:
			rect.stack = stack
			rect.texture = item.texture
			stack_text.text = str(stack.size()) + "/" + str(item.stack)

func _move(new_stack, target : int):
	move.emit(new_stack, target)
	
func _drop(new_stack):
	drop.emit(new_stack)
	
