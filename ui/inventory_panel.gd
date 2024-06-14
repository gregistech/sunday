class_name InventoryPanel

extends Window

signal move(item : Item, target : int)
signal drop(item : Item)

@export var grid : GridContainer
@export var slot_template : PackedScene
	
func changed(items : Array[Item]):
	for child in grid.get_children():
		grid.remove_child(child)
	var i = 0
	for item in items:
		var slot : InventorySlot = slot_template.instantiate()
		slot.move.connect(func(it : Item, target : int): move.emit(it, target))
		slot.drop.connect(func(it : Item): drop.emit(it))
		
		slot.index = i
		i += 1
		
		slot.set_item(item)
		
		grid.add_child(slot)
		
