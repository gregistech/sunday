class_name Health

extends Node

signal healed(health)
signal damaged(health)

@export var health : int = 100

func heal(hl: int):
	health += hl
	print(health)
	healed.emit(health)

func damage(dmg : int):
	health -= dmg
	print(health)
	damaged.emit(health)
	
