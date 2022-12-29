extends Projectile

var theTarget
var percent:float = 0.0
export var percentIncrease:float = 0.1
onready var player = theOwner.get_tree().get_nodes_in_group("PLAYER")[0]
func FindNearestEnemy(var distance:float):
	var enemies = theOwner.get_tree().get_nodes_in_group("ENEMIES")
	var nearestEnemy
	for enemy in enemies:
		var enemyToPlayer:Vector2 = player.position - enemy.position
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
		direction += (theTarget.position - position).normalized()*percent
		if percent < 1.0:
			percent = percent+percentIncrease*delta
	position += delta * speed * direction

func CalcTime(delta):
	return
