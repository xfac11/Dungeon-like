extends Projectile
var canDamage = Dictionary()
var bodies = Dictionary()
var size setget set_area_size
var default_size = 30
func set_area_size(new_size):
	$CollisionShape2D.shape.radius = new_size * default_size
	$Particles2D.process_material.emission_sphere_radius = new_size * default_size
	$Sprite.scale = Vector2(new_size, new_size)
	size = new_size

func LifetimeEnd():
	$Particles2D.emitting = true
	for body in bodies:
		body.damageTaker.ResolveHit(damageSrc)

func HitBody(body):
	if !bodies.has(body):
		bodies[body] = body


func _on_ProjectileOnPlayer_body_exited(body):
	bodies.erase(body)


func Movement(delta):
	position = theOwner.get_tree().get_nodes_in_group("PLAYER")[0].position
