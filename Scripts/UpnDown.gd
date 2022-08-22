extends Tween
onready var sprite = get_parent()
var values = [0, 10]

func _ready():
	StartTween()

func StartTween():
	interpolate_property(sprite, "position", Vector2(0, values[0]), Vector2(0,values[1]), 1,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	start()

func _on_Tween_tween_completed(_object, _key):
	values.invert()
	StartTween()
