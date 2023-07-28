class_name CharacterJump

extends Node

@export_category("Configuration")
@export var force : float = 1

@export var repr : CharacterBody3D

func jump():
	if repr.is_on_floor():
		repr.velocity.y += force
