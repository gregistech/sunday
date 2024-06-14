class_name Inventory

extends Node

signal changed(stacks : Array[Array])

@export var size : int = 12
@export var stacks : Array[Array] # NOTE: NESTED TYPE COLLECTIONS ARE NOT SUPPORTED? WHAT?
 
func _ready():
	stacks = []
	stacks.resize(size)
	changed.emit(stacks)

func _is_space_enough() -> bool:
	var total = 0
	for stack in stacks:
		if not stack.is_empty():
			total += 1
	return total < size

# NOTE: COME ON, WHERE IS ENUMERATE()???
func _get_first_free_index() -> int:
	var i = 0
	if _is_space_enough():
		for stack in stacks:
			if stack.is_empty():
				return i
			i += 1
	else:
		return -1
	return -1 # NOTE: useless, gdscript thinks not all code paths are covered with the else branch...

func _get_first_stack_index() -> int:
	return -1

func put(item : Item) -> bool:
	if _is_space_enough() and item:
		item.get_parent().remove_child(item)
		add_child(item)
		item.representation.get_parent().remove_child(item.representation)
		add_child(item.representation)
		item.representation.visible = false
		
		var target = _get_first_stack_index()
		if target != -1:
			if stacks[target].size() >= item.stack:
				target = _get_first_free_index()
		else:
			target = _get_first_free_index()
		
		if target != -1:
			stacks[target].append(item)
		else:
			return false
		
		changed.emit(stacks)
		return true
	return false

# FIXME: drop mechanism needs rework for stacks
func drop(item : Item, target : Transform3D):
#	if item and is_instance_valid(item):
#		remove_child(item)
#		items.erase(item)
#		get_tree().root.add_child(item.representation)
#		print(item)
#		item.representation.add_child(item)
#		item.representation.global_transform = target
#		item.representation.visible = true
#		changed.emit(items)
	pass

func _ensure_size(target : int):
	if target >= stacks.size(): # TODO: can't we move this logic? is it even necessary?
			stacks.resize(target + 1)

func move(stack : Array, target: int):
	if target < size:
		_ensure_size(target)
		if stacks[target].is_empty():
			stacks[stacks.find(stack)] = []
			stacks[target] = stack
		else: 
			stacks[stacks.find(stack)] = stacks[target]
			stacks[target] = stack
		changed.emit(stacks)
