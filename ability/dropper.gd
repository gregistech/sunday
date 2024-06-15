class_name Dropper

extends Node3D

@export var inventory : Inventory

func _ready():
	inventory.dropped.connect(_drop)
	
func _drop(stack : Stack):
	if stack != null:
		for item in stack.items:
			var repr : Node3D = item.representation.instantiate()
			get_tree().root.get_child(0).add_child(repr)
			repr.global_position = global_position
