extends Projectile

var theTarget
export var turningRate:float = 0.1
func FindNearestEnemy(var distance:float):
	var enemies = theOwner.get_tree().get_nodes_in_group("ENEMIES")
	var nearestEnemy
	for enemy in enemies:
		var enemyToPlayer:Vector2 = position - enemy.position
		var length = enemyToPlayer.length()
		if length < distance:
			distance = length
			nearestEnemy = enemy
	
	if enemies.size() == 0 or nearestEnemy == null:
		return null
	return nearestEnemy

func Movement(delta):
	if not is_instance_valid(theTarget):
		theTarget = FindNearestEnemy(100)
	else:
		var toTarget = (theTarget.position - position).normalized()
		direction += toTarget * turningRate
		direction = direction.normalized()
	position += delta * speed * direction
	
	var angle = direction.normalized().angle_to(forward)
	rotation = -angle

