class_name InventoryInteractMenu

extends PopupMenu

signal drop
signal use
signal equip

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	id_pressed.connect(_pressed)
	
func _pressed(id: int):
	match id:
		0:
			drop.emit()
		1:
			use.emit()
		2: 
			equip.emit()
