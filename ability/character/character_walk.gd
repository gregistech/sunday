class_name CharacterWalk

extends Node

@export_category("Configuration")
@export var speed : float = 1
@export var run_multiplier : float = 1.25
@export var can_run : bool
var _is_running : bool

@export var repr : CharacterBody3D

func walk(input : Vector2):
	var _velocity = -(Vector3(input.x, 0, -input.y) * speed).rotated(Vector3(0, 1, 0), repr.rotation.y - deg_to_rad(90))
	if _is_running and can_run:
		_velocity *= run_multiplier
	repr.velocity.x = _velocity.x
	repr.velocity.z = _velocity.z
		
func run(input : bool):
	_is_running = input

func _physics_process(_delta):
	repr.move_and_slide()
