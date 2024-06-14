class_name InventoryPanel

extends Window

signal move(stack : Array, target : int)
signal drop(stack : Array)

@export var grid : GridContainer
@export var slot_template : PackedScene
	
func changed(stacks : Array[Array]):
	for child in grid.get_children():
		grid.remove_child(child)
	var i = 0
	for stack : Array in stacks:
		var slot : InventorySlot = slot_template.instantiate()
		slot.move.connect(func(st : Array, target : int): move.emit(st, target))
		slot.drop.connect(func(st : Array): drop.emit(st))
		
		slot.index = i
		i += 1
		
		slot.set_stack(stack as Array)
		
		grid.add_child(slot)
		
