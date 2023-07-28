class_name CharacterRotate

extends Node

@export_category("Configuration")
@export var smoothness : float = 1

@export var repr : CharacterBody3D
@export var camera : Camera3D

var _input : Vector2
var _velocity : Vector2

func _process(delta):
	_velocity = _velocity.lerp(_input, delta * smoothness)
	repr.rotate_y(_velocity.x)
	camera.rotate_x(_velocity.y)

	camera.rotation.x = clamp(camera.rotation.x, -PI / 2, PI / 2)
	
	_input = Vector2.ZERO

func rotate(input : Vector2):
	_input = input
