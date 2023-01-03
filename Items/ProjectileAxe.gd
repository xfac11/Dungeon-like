extends ProjectilePierce
class_name ProjectileAxe

var acc = Vector2(0,-0.4)
var deacc = 1
func Movement(delta):
	position += delta * speed * direction
	position += acc * speed * delta * 5
	acc+= Vector2(0,1*deacc*delta)
