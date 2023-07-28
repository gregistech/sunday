class_name Damager

extends Area3D

signal damage(dmg : int)

@export var amount : int = 1

func _ready():
	area_entered.connect(_entered)
	area_exited.connect(_exited)
	
func _entered(_area : Area3D):
	pass
	
func _exited(_area : Area3D):
	pass

func _damage():
	damage.emit(amount)
