class_name Pickuper

extends FinderReceiver

@export_category("Configuration")

@export var target : StaticBody3D
@export var joint : Joint3D

@export var throw_force : int = 10
@export var rotate_force : int = 10

@export var move_velocity_multiplier : int = 50

var _pickupable : Pickupable
var is_picked_up : bool

func _physics_process(_delta):
	if _pickupable and is_picked_up:
		var velocity = target.global_transform.origin - _pickupable.rigid_body.global_transform.origin
		_pickupable.rigid_body.linear_velocity = velocity * move_velocity_multiplier

func _found(pickupable):
	if not is_picked_up:
		_pickupable = pickupable as Pickupable
	
func _lost():
	if not is_picked_up:
		_pickupable = null

func pick_up():
	if _pickupable:
		is_picked_up = true
		joint.node_b = _pickupable.rigid_body.get_path()
	
func place():
	let_go()
	if _pickupable:
		_pickupable.rigid_body.linear_velocity *= 0
func throw():
	let_go()
	if _pickupable:
		# FIXME: we assume the finder has a raycast, that makes us dependent on the technique of the finder...
		_pickupable.rigid_body.apply_central_impulse(-finder.raycast.global_transform.basis.z.normalized() * throw_force)	
func let_go():
	is_picked_up = false
	joint.node_b = ""

func rotate_left():
	if is_picked_up and _pickupable:
		target.rotate_y(-.01 * rotate_force)
func rotate_right():
	if is_picked_up and _pickupable:
		target.rotate_y(.01 * rotate_force)
func rotate_up():
	if is_picked_up and _pickupable:
		target.rotate_x(.01 * rotate_force)
func rotate_down():
	if is_picked_up and _pickupable:
		target.rotate_x(-.01 * rotate_force)
