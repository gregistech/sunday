class_name InventorySlot # TODO: many code duplicated with InvetorySlotRect

extends Panel

signal move(item : Item, target : int)
signal drop(item : Item)

@export var rect : InventorySlotRect

var index : int
var item : Item

func _ready():
	rect.index = index
	rect.move.connect(_move)
	rect.drop.connect(_drop)

func set_item(new_item : Item):
	item = new_item
	if item:
		rect.item = item
		rect.texture = item.texture

func _move(new_item : Item, target : int):
	move.emit(new_item, target)
	
func _drop(new_item : Item):
	drop.emit(new_item)
	
