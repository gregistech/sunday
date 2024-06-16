class_name UIManager

extends Control

@export var representation : Node3D

@export_category("Inventory")
@export var inventory : Inventory
@export var inventory_panel : InventoryPanel

func _ready():
	inventory.changed.connect(inventory_panel.changed)
	inventory_panel.move.connect(inventory.move)
	inventory_panel.drop.connect(_inventory_drop)
	inventory_panel.close_requested.connect(toggle_inventory)

func _inventory_drop(stack : Stack):
	inventory.drop(stack)
	pass

func toggle_inventory():
	inventory_panel.visible = !inventory_panel.visible
	if inventory_panel.visible:
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
