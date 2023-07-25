extends Particles2D
class_name Particles2DTimer
func _on_Timer_timeout():
	queue_free()
