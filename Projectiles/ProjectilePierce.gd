extends Projectile
class_name ProjectilePierce

export var pierceHits = 2
var numberOfHits = 0
func HitBody(body:MovementAI):
	body.damage_taker.ResolveHit(damageSrc)
	if pierceHits == numberOfHits:
		queue_free()
	numberOfHits+= 1
