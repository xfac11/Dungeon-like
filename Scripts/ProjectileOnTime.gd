extends Projectile
export(PackedScene) var projectileToSpawn
func LifetimeEnd():
	call_deferred("SpawnProjectiles",2)
	queue_free()
func SpawnProjectiles(quantity):
	var tempDirection:Vector2 = direction.normalized()
	var angle = 30
	for i in quantity:
		var newBullet = projectileToSpawn.instance()
		theOwner.add_child(newBullet)
		newBullet.position = position
		newBullet.damage = damage
		newBullet.speed = speed*5
		tempDirection = tempDirection.rotated(deg2rad(angle))
		newBullet.SetDirection(tempDirection)
		newBullet.theOwner = theOwner
		angle = (angle*-1)+30
