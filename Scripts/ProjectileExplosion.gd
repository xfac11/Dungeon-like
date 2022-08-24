extends Projectile

func _ready():
	sprite.play()

func Movement(delta):
	return##NO movement

func HitBody(body):
	body.get_node("Health").TakeDamage(damage)
