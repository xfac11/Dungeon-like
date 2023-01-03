extends AnimatedSprite
func _on_BloodEffect_animation_finished():
	queue_free()
