class_name SpriteColorChanger
extends Node

export(Color) var color_to
export(NodePath)var sprite_path
var _first_color = Color.black

var _sprite:Sprite


func _ready():
	_sprite = get_node(sprite_path)


func change_to():
	_sprite.modulate = color_to


func change_back():
	_sprite.modulate = _first_color
