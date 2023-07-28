class_name FinderReceiver

extends Node

@export var finder : Finder

func _ready():
	finder.found.connect(_found)
	finder.lost.connect(_lost)

func _found(_target):
	pass
	
func _lost():
	pass
