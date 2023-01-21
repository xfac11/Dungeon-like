extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$ExpDropper.spawn_exp_drop(Vector2(0, 0), 1)
	$ExpDropper.spawn_exp_drop(Vector2(22, 0), 5)
	$ExpDropper.spawn_exp_drop(Vector2(60, 0), 15)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
