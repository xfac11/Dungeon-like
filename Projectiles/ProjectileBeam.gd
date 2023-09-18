class_name ProjectileBeam
extends Projectile

export(PackedScene) var ice_particles

func _ready():
	var newParticles = ice_particles.instance()
	get_node("/root/GameScene").add_child(newParticles)
	newParticles.position = global_position


func Movement(_delta):
	var angle = direction.normalized().angle_to(forward)
	rotation = -angle
	return


func HitBody(body:MovementAI):
	body.damage_taker.ResolveHit(damageSrc)
