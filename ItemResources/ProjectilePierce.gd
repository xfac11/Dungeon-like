extends Projectile
class_name ProjectilePierce

export var pierceHits = 2
var numberOfHits = 0
func HitBody(body):
	body.get_node("Health").TakeDamage(damage)
	if pierceHits == numberOfHits:
		queue_free()
	numberOfHits+= 1
