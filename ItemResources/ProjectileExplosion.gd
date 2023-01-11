class_name ProjectileExplosion
extends Projectile
onready var particles = $Particles2D

func _ready():
	particles.emitting = true

func Movement(delta):
	return##NO movement

func HitBody(body):
	body.health.TakeDamage(damage)
