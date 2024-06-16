class_name QuickbarPanel

extends Panel

# TODO: how to signal? think about where we decide to use/equip (flesh that out already man...)

@export var container : Container
@export var slot_template : PackedScene
	
func _remove_children():
	for child in container.get_children():
		container.remove_child(child)
	
func changed(inventory : Inventory):
	_remove_children()

	var i = 0
	for stack in inventory.stacks:
		var slot : QuickbarSlot = slot_template.instantiate()
		slot.stack = stack
		
		slot.index = i
		i += 1
		
		container.add_child(slot)
