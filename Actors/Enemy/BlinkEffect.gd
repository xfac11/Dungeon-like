class_name BlinkEffect
extends Node

export(NodePath) var sprite_path
export(float, 0, 1, 0.05) var elapsed_time

onready var tween = $Tween
onready var sprite = get_node(sprite_path)


func blink():
	tween.interpolate_property(sprite.material, "shader_param/blinkValue",
		1, 0, elapsed_time,
		Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()

