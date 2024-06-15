class_name Inventory

extends Node

signal changed(inventory : Inventory)

@export var size : int = 12
@export var weight_capacity : int = 25
var weight : int : get = _get_weight
var available_weight : int : get = _get_available_weight
var stacks : Array[Stack]
 
const stackgd = preload("res://inventory/stack.gd")

func _ready():
	stacks = []
	stacks.resize(size)
	changed.emit(self)

func _get_weight():
	var result := 0
	for stack in stacks:
		if stack != null:
			result += stack.weight
	return result

func _get_available_weight():
	return weight_capacity - weight

func _is_space_enough() -> bool:
	var total = 0
	for stack in stacks:
		if stack != null:
			if not stack.is_empty():
				total += 1
	return total < size

# [fits, didn't fit]
func _get_stack_that_fits(source : Stack) -> Array[Stack]:
	if _is_space_enough():
		if source.weight <= available_weight:
			return [source, null]
		else:
			var current := 0
			var fitting : Stack = stackgd.new([])
			while current < available_weight:
				var popped := source.pop()
				fitting.push(popped)
				current += popped.weight
			return [fitting, source]
	return [null, source]

func _get_stack_that_fits_and_drop(source : Stack) -> Stack:
	var fitting := _get_stack_that_fits(source)
	drop(fitting[1])
	return fitting[0]

func _get_first_free_index() -> int:
	var i = 0
	if _is_space_enough():
		for stack in stacks:
			if stack == null:
				return i
			else:
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
	var remaining : Stack = _fill_available_stacks(_get_stack_that_fits_and_drop(stack))
	
	if remaining != null:
		if not remaining.is_empty():
			var target : int = _get_first_free_index()
			stacks[target] = remaining
			changed.emit(self)
			return null
		else:
			changed.emit(self)
			return null if remaining.is_empty() else remaining
	else:
		return null

# FIXME: drop mechanism needs rework for stacks
func drop(_stack : Stack):
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
	var source_index := stacks.find(stack)
	if target < size:
		if target == source_index: # if we were to move to the same place
			return
		elif stacks[target] == null or stacks[target].is_empty():
			if source_index == -1:
				stack = _get_stack_that_fits_and_drop(stack)
			stacks[source_index] = null
			stacks[target] = stack
		else: # there's a stack there
			var current_stack : Stack = stacks[target]
			if source_index == -1: # stack not from inventory
				if current_stack.is_matching_stack(stack): # matching stack
					stack = current_stack.transfer_all(stack)
				target = _get_first_free_index()
				if _is_space_enough() and target != -1:
					stacks[target] = stack
				else:
					drop(stack)
			else:
				if current_stack.is_matching_stack(stack): # matching stack, we can transfer
					current_stack.transfer_all(stack)
				else: # not matching, we can replace	
					stacks[source_index] = current_stack
					stacks[target] = stack
		changed.emit(self)
