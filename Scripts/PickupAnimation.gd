extends Sprite

func _ready():
	var tween = get_node("Tween")
	var x = randf()*20
	var y = randf()*-20
	tween.interpolate_property(self, "position",
		Vector2(0, 0), Vector2(x, y), 0.5,
		Tween.TRANS_QUART, Tween.EASE_OUT)
	tween.interpolate_property(self, "position",
		Vector2(x, y), Vector2(0, 0), 0.5,
		Tween.TRANS_LINEAR, Tween.EASE_OUT, 0.5)
	tween.connect("tween_all_completed", self, "destroy")
	tween.start()


func destroy():
	queue_free()
