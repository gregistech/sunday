class_name Inventory

extends Node

signal changed(stacks : Array[Stack])

@export var size : int = 12
var stacks : Array[Stack]
 
func _ready():
	stacks = []
	stacks.resize(size)
	changed.emit(stacks)

func _is_space_enough() -> bool:
	var total = 0
	for stack in stacks:
		if stack != null:
			if not stack.is_empty():
				total += 1
	return total < size

func _get_first_free_index() -> int:
	var i = 0
	if _is_space_enough():
		for stack in stacks:
			if stack != null:
				if stack.is_empty():
					return i
				i += 1
	else:
		return -1 
	return -1 

func _fill_available_stacks(new_stack : Stack) -> Stack:
	for stack in stacks:
		if stack != null:
			if stack.is_matching_stack(new_stack):
				new_stack = stack.transfer_all(new_stack)
	return new_stack
	
func put(stack : Stack) -> Stack:
	var remaining : Stack = _fill_available_stacks(stack)
	
	if _is_space_enough() and not remaining.is_empty():
		var target : int = _get_first_free_index()
		stacks[target] = remaining
		changed.emit(stacks)
		return null
	else:
		changed.emit(stacks)
		return remaining

# FIXME: drop mechanism needs rework for stacks
func drop(_item : Item, _target : Transform3D):
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

# NOTE: is this even necessary?
func _ensure_size(target : int):
	if target >= stacks.size():
			stacks.resize(target + 1)

func move(stack : Stack, target: int):
	if target < size:
		#_ensure_size(target) l# NOTE: not sure if needed
		if stacks[target] == null: # there wasn't even a stack there
			stacks[stacks.find(stack)] = null
			stacks[target] = stack
		elif stacks[target].is_empty(): # the stack there is empty
			stacks[stacks.find(stack)] = null
			stacks[target] = stack
		else: # there's a stack there
			var current_stack : Stack = stacks[target]
			if current_stack.is_matching_stack(stack): # matching stack, we can transfer
				current_stack.transfer_all(stack)
			else: # not matching, we can replace	
				stacks[stacks.find(stack)] = current_stack
				stacks[target] = stack
		changed.emit(stacks)
