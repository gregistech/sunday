class_name Item

extends Node

@export var id : String
@export var display_name : String
@export_file("*.tscn") var representation_file : String
var representation : PackedScene : get = _get_representation_scene
@export var texture : Texture2D
@export var weight : int = 1
@export var stack : int = 1

func _get_representation_scene() -> PackedScene:
	return load(representation_file)

func action():
	pass
