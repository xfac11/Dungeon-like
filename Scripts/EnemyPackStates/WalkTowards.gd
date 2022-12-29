extends State
class_name WalkTowards
var direction:Vector2 = Vector2(0,0)
func Enter(_object):
	pass
func Exit(_object):
	pass
func InputUpdate(_event, _object, _delta) -> State:
	return null
func Update(object:MovementAI, _delta):
	object.Move(direction, 1.0)
