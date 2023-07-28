class_name CharacterGravity

extends Node

@export var repr : CharacterBody3D

func _physics_process(delta):
	repr.velocity.y -= ProjectSettings.get_setting("physics/3d/default_gravity") * delta
