class_name Finder

extends Node

signal found(target) # NOTE: generics would allow type-safety, maybe in the future...
signal lost

@export_category("Configuration")
@export var raycast : RayCast3D

var _target

func _process(_delta):
	if raycast.is_colliding() and not _target:
		_target = raycast.get_collider()
		if _target:
			found.emit(_target)
	elif _target and not raycast.is_colliding():
		lost.emit()
		_target = null
