class_name ProjectileExplosion
extends Projectile
onready var particles = $Particles2D
onready var sprite = $Sprite
func Movement(_delta):
	return##NO movement


func HitBody(body):
	body.damage_taker.ResolveHit(damageSrc)


func _on_SpriteTimer_timeout():
	sprite.modulate = Color.white


func _on_ParticleTimer_timeout():
	sprite.visible = false
	particles.emitting = true
