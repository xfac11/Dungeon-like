extends Projectile
class_name ProjectileRotating
export var angle = 10
export var distance = 25
var startingVector = Vector2(0,1)
var aroundObject
func _ready():
	aroundObject = theOwner.get_tree().get_nodes_in_group("PLAYER")[0]
func Movement(delta):
	var newPosition = aroundObject.position + (startingVector * distance)
	startingVector = startingVector.rotated(angle*delta)
	position = position.move_toward(newPosition,10)
	var vec:Vector2 = position - newPosition
	if (vec.length() < 3):
		position = newPosition

func CalcTime(_delta):#Do nothing. Will live forever until hit
	return
