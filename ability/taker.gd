class_name Taker

extends FinderReceiver

@export var inventory : Inventory

var _takeable : Takeable

func _found(takeable):
	_takeable = takeable as Takeable

func _lost():
	_takeable = null

const stack = preload("res://inventory/stack.gd")

func take():
	if _takeable:
		if inventory.put(stack.new([_takeable.item.duplicate()])) == null:
			print("deletin")
			_takeable.representation.queue_free()
			_lost()
