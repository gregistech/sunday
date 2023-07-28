class_name CharacterHitbox

extends Hitbox

@export_category("Configuration")
@export var health : Health

func _damage(dmg : int):
	health.damage(dmg)
