extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = get_node("Tween")
	tween.interpolate_property($Sprite, "position",
		Vector2(0, 0), Vector2(100, 100), 1,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	tween.connect("tween_completed",self,"QueueSelf")
func QueueSelf(_un,_un2):
	$Sprite.queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
