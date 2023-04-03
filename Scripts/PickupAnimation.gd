extends Sprite
var distance = 20
func _ready():
	var tween = get_node("Tween")
	var x = randf()*1
	var y = randf()*-1
	var target = Vector2(x, y).normalized()
	target*=distance
	tween.interpolate_property(self, "position",
		Vector2(0, 0), Vector2(target), 0.5,
		Tween.TRANS_QUART, Tween.EASE_OUT)
	tween.interpolate_property(self, "position",
		Vector2(target), Vector2(0, 0), 0.5,
		Tween.TRANS_LINEAR, Tween.EASE_OUT, 0.5)
	tween.connect("tween_all_completed", self, "destroy")
	tween.start()


func destroy():
	queue_free()
