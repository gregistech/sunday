class_name Inventory

extends Node

signal changed(items : Array[Item])

@export var size : int = 12
@export var items : Array[Item]
 
func _ready():
	items = []
	items.resize(size)
	changed.emit(items)

func _is_space_enough() -> bool:
	var total = 0
	for item in items:
		if item:
			total += 1
	return total < size

func _get_first_free_index() -> int: # NOTE: COME ON, WHERE IS ENUMERATE()???
	var i = 0
	if _is_space_enough():
		for item in items:
			if not item:
				return i
			i += 1
	else:
		return -1
	return -1 # NOTE: ALL CODE PATHS RETURN, CHECK AGAIN...

func put(item : Item) -> bool:
	if _is_space_enough() and item:
		item.get_parent().remove_child(item)
		add_child(item)
		item.representation.get_parent().remove_child(item.representation)
		add_child(item.representation)
		item.representation.visible = false
		items[_get_first_free_index()] = item
		changed.emit(items)
		return true
	return false

func drop(item : Item, target : Transform3D):
	if item and is_instance_valid(item):
		#remove_child(item)
		#items.erase(item)
		#get_tree().root.add_child(item.representation)
		#print(item)
		#item.representation.add_child(item)
		#item.representation.global_transform = target
		#item.representation.visible = true
		changed.emit(items)

# NOTE: looks retarded I know, but we need to check if the array will get out of bounds... try catch gdscript?
func move(item : Item, target: int):
	if target < size:
		if target >= items.size():
			items.resize(target + 1)
		if items[target]:
			var old_item : Item = items[target]
			items[target] = null
			items[items.find(item)] = old_item
			items[target] = item
		else:
			items[items.find(item)] = null
			items[target] = item
		changed.emit(items)
