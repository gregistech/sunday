class_name InventorySlot # TODO: many code duplicated with InvetorySlotRect

extends Panel

signal move(stack : Stack, target : int)
signal drop(stack : Stack)

@export var rect : InventorySlotRect
@export var stack_text : Label
@export var menu : InventoryInteractMenu

var index : int
var stack : Stack

func _ready():
	rect.index = index
	rect.move.connect(_move)
	rect.drop.connect(func(): _drop(stack))
	menu.drop.connect(func(): _drop(stack))

func set_stack(new_stack : Stack):
	if new_stack != null:
		stack = new_stack
		if stack.size() > 0:
			var item : Item = stack.items[0]
			if item:
				rect.main_stack = stack
				rect.texture = item.texture
				if stack.max_size > 1:
					stack_text.visible = true
					stack_text.text = str(stack.size()) + "/" + str(stack.max_size)
				else:
					stack_text.visible = false

func _move(new_stack : Stack, target : int):
	move.emit(new_stack, target)
	
func _drop(new_stack : Stack):
	drop.emit(new_stack)

func _gui_input(event: InputEvent) -> void:
	if stack != null and not stack.is_empty():
		if event.is_action_pressed("interact_menu_inventory"):
			accept_event()
			menu.position = Vector2(get_window().position) + position
			menu.visible = true
