extends Projectile
export(PackedScene) var projectileToSpawn
func LifetimeEnd():
	call_deferred("SpawnProjectiles",2)
	queue_free()
func SpawnProjectiles(quantity):
	var initDirection:Vector2 = direction.normalized()
	var angle = 20
	var n = 1
	
	for i in n:
		var x = 1
		for j in 2:
			var newBullet = InitBullet()
			var tempDirection = initDirection
			tempDirection = tempDirection.rotated(deg2rad(angle * (i+1) * x))
			newBullet.SetDirection(tempDirection)
			x = x * -1


func InitBullet():
	var newBullet = projectileToSpawn.instance()
	theOwner.add_child(newBullet)
	newBullet.position = position
	newBullet.damage = damage
	newBullet.speed = speed*5
	newBullet.theOwner = theOwner
	return newBullet
