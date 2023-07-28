extends Node

@export_category("Rotate")
@export var character_rotate : CharacterRotate
@export var rotate_input : TwoDInput

@export_category("Movement")
@export var character_walk : CharacterWalk
@export var walk_input : TwoDInput
@export var run_input : BoolInput

@export_category("Jump")
@export var character_jump : CharacterJump
@export var jump_input : BoolInput

@export_category("Pickup")
@export var pickuper : Pickuper
@export var pickup_timeout : float = .1
@export var lose_timeout : float = .1

@export var pickup_input : BoolInput
@export var throw_input : BoolInput
@export var place_input : BoolInput

@export var rotate_left_input : BoolInput
@export var rotate_right_input : BoolInput
@export var rotate_up_input : BoolInput
@export var rotate_down_input : BoolInput

@export_category("Take")
@export var taker : Taker
@export var take_input : BoolInput

@export var ui_manager : UIManager
@export var inventory_input : BoolInput

func _ready():
	rotate_input.input.connect(_rotate)
	walk_input.input.connect(_walk)
	run_input.input.connect(_run)
	jump_input.input.connect(_jump)
	pickup_input.input.connect(_pickup)
	throw_input.input.connect(_throw)
	place_input.input.connect(_place)
	rotate_left_input.input.connect(_rotate_left)
	rotate_right_input.input.connect(_rotate_right)
	rotate_up_input.input.connect(_rotate_up)
	rotate_down_input.input.connect(_rotate_down)
	take_input.input.connect(_take)
	inventory_input.input.connect(_toggle_inventory)

func _rotate(input : Vector2):
	character_rotate.rotate(input)
	
func _walk(input: Vector2):
	character_walk.walk(input)

func _run(input : bool):
	character_walk.run(input)
	
func _jump():
	character_jump.jump()

var _just_picked_up = false
func _set_just_picked_up():
	_just_picked_up = true
	await get_tree().create_timer(pickup_timeout).timeout
	_just_picked_up = false

var _just_lost = false	
func _set_just_lost():
	_just_lost = true
	await get_tree().create_timer(lose_timeout).timeout
	_just_lost = false

func _pickup():
	if not pickuper.is_picked_up and not _just_lost:
		pickuper.pick_up()
		_set_just_picked_up()

func _throw():
	if pickuper.is_picked_up and not _just_picked_up:
		pickuper.throw()
		_set_just_lost()
func _place():
	if pickuper.is_picked_up and not _just_picked_up:
		pickuper.place()
		_set_just_lost()

func _rotate_left():
	pickuper.rotate_left()
func _rotate_right():
	pickuper.rotate_right()
func _rotate_up():
	pickuper.rotate_up()
func _rotate_down():
	pickuper.rotate_down()

func _take():
	taker.take()

func _toggle_inventory():
	ui_manager.toggle_inventory()
