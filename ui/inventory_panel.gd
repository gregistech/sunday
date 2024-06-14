class_name InventoryPanel

extends Window

signal move(stack : Stack, target : int)
signal drop(stack : Stack)

@export var grid : GridContainer
@export var slot_template : PackedScene
	
func changed(stacks : Array[Stack]):
	for child in grid.get_children():
		grid.remove_child(child)
	var i = 0
	for stack : Stack in stacks:
		var slot : InventorySlot = slot_template.instantiate()
		slot.move.connect(func(st : Stack, target : int): move.emit(st, target))
		slot.drop.connect(func(st : Stack): drop.emit(st))
		
		slot.index = i
		i += 1
		
		slot.set_stack(stack)
		grid.add_child(slot)
		
