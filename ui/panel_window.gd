class_name PanelWindow

extends Window

func _ready() -> void:
	close_requested.connect(func(): visible = false)
