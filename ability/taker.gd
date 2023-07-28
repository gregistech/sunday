class_name Taker

extends FinderReceiver

@export var inventory : Inventory

var _takeable : Takeable

func _found(takeable):
	_takeable = takeable as Takeable

func _lost():
	_takeable = null

func take():
	if _takeable:
		if inventory.put(_takeable.item):
			_takeable.representation.queue_free()
			_takeable = null
