class_name Text2D
extends Node2D

export var font_color = Color.white setget set_font_color, get_font_color
export var text = "" setget set_text, get_text

onready var _label = $Label

func _ready():
	_label.text = text
	_label.set("custom_colors/font_color", font_color)


func set_text(new_value):
	var value = new_value
	if not new_value is String:
		value = str(new_value)
	text = value
	if is_instance_valid(_label):
		_label.text = text


func get_text():
	return text


func set_font_color(new_value):
	font_color = new_value
	if is_instance_valid(_label):
		_label.set("custom_colors/font_color", font_color)


func get_font_color():
	return font_color
