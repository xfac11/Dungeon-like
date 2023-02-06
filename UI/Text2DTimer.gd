class_name Text2DTimer
extends Node2D
onready var text2D = $Text2D
var animation

func start_animation():
	$AnimationPlayer.play(animation)


func delete():
	queue_free()
