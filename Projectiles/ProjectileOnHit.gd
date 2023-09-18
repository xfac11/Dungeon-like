extends Projectile
class_name ProjectileOnHit
export(PackedScene) var onHitProjectile

#func LifetimeEnd():
#	call_deferred("SpawnProjectiles")
#	queue_free()

func HitBody(body:MovementAI):
	body.damage_taker.ResolveHit(damageSrc)
	call_deferred("SpawnProjectiles")
	queue_free()

func SpawnProjectiles():
	var direction:Vector2 = Vector2(0,1)
	direction = direction.normalized()
	for i in 4:
		var newBullet = onHitProjectile.instance()
		theOwner.add_child(newBullet)
		newBullet.position = position
		newBullet.damage = damage
		newBullet.speed = speed*5
		newBullet.SetDirection(direction)
		newBullet.theOwner = theOwner
		direction = direction.rotated(deg2rad(90))


func _on_ProjectileOnHit_body_entered(body):
	HitBody(body)
