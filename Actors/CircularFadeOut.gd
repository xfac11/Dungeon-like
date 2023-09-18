class_name CircularFadeOut
extends Node

export var sprite_path:NodePath

onready var sprite = get_node(sprite_path)
onready var tween = $Tween

func fade_out():
	tween.interpolate_property(sprite.material, "shader_param/noiseEffectivenes",
		0, 0.6, 0.5,
		Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
