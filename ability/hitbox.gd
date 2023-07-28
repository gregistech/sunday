class_name Hitbox

extends Area3D

func _ready():
	area_entered.connect(_entered)
	area_exited.connect(_exited)
	
func _entered(area : Area3D):
	var damager := area as Damager
	if damager:
		damager.damage.connect(_damage)
	
func _exited(area : Area3D):
	var damager := area as Damager
	if damager:
		area.damage.disconnect(_damage)

func _damage(_dmg : int):
	pass
