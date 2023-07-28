class_name ConstantDamager

extends Damager

@export var timer : Timer

var _is_damaging = false

func _ready():
	super()
	timer.timeout.connect(_damage)

func _process(_delta):
	if _is_damaging and timer.is_stopped():
		timer.start()
	elif not _is_damaging:
		timer.stop()

func _entered(_area):
	_is_damaging = true
	
func _exited(_area):
	_is_damaging = false
